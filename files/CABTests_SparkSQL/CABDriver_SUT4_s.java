import java.io.File;
import java.io.IOException;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.lang.Thread;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;
import java.util.Properties;
import java.util.concurrent.*;
import org.apache.spark.sql.*;
import org.apache.spark.sql.types.*;

import org.json.JSONObject;
import org.json.JSONArray;

class QueryStreamExecutor {

    private Map<String, Object> databaseConfig;
    private SparkSQLPool_s databaseConnection;
    private ArrayList<Map<String, Object>> queryExecutionLog;
    private int totalCost;
    private int totalScanned;
    private int totalStartDelay;
    private int outstanding;
    private JSONObject database;
    private List<String> queryTemplates;
    private int total_start_delay;
    private int remaining_retries = 1000;
    private long start_of_run_ts = System.currentTimeMillis() + 2000;
    private String[] query_templates;

    public QueryStreamExecutor(SparkSession sparkSession, Map<String, Object> databaseConfig, int queryStreamId) {
        this.databaseConfig = databaseConfig;
        Map<String, String> connectionOptions = new HashMap<>();
        connectionOptions.put("database", "tenant" + queryStreamId);
        this.databaseConnection = new SparkSQLPool_s(sparkSession, false, connectionOptions);
        this.queryExecutionLog = new ArrayList<Map<String, Object>>();
        this.totalCost = 0;
        this.totalScanned = 0;
        this.totalStartDelay = 0;
    }

    public void loadQueryStream(int streamId) throws Exception {
        String content = new String(Files.readAllBytes(Paths.get("/root/home/spark/mtdds/CABTests_SparkSQL/query_streams/query_stream_" + streamId + ".json")));
        this.database = new JSONObject(content);
        Map<String, Object> meta = new HashMap<>();
        for (Map.Entry<String, Object> entry : database.toMap().entrySet()) {
            System.out.println(entry.getKey());
            if (!entry.getKey().equals("queries")) {
                meta.put(entry.getKey(), entry.getValue());
            }
        }
        System.out.println(meta);
    }

    public void loadQueryTemplates() throws IOException {
        this.queryTemplates = new ArrayList<>();
        for (int queryId = 1; queryId <= 23; queryId++) {
            String template = new String(Files.readAllBytes(new File(databaseConfig.get("query_template_path") + "/" + queryId + ".sql").toPath()));
            queryTemplates.add(template);
        }
        System.out.println("Templates loaded");
    }
    
    public void runQueryStream() throws InterruptedException {
        this.outstanding = 0;
        this.total_start_delay = 0;
        this.remaining_retries = 100;
        long startOfRunTs = System.currentTimeMillis() + 2000;

        JSONArray queries = this.database.getJSONArray("queries");
System.out.println(queries.length());
        for (int idx = 0; idx < queries.length(); idx++) {
            this.outstanding++;
            final int queryIndex = idx;
            JSONObject query = queries.getJSONObject(queryIndex); 
System.out.println(idx+ " TO start");
            new Thread(() -> {
                try {
                    runQuery(query, queryIndex, startOfRunTs);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }).start();
        }

        while (outstanding != 0) {
            Thread.sleep(100);
        }

        long totalTime = System.currentTimeMillis() - startOfRunTs;
        printExecutionStats(totalTime);
    }

    private void runQuery(JSONObject query, int idx, long startOfRunTs) throws Exception {
        long actualStartTs = System.currentTimeMillis();
        long plannedStartTs = startOfRunTs + query.getLong("start");
        long startDelay = actualStartTs - plannedStartTs;
System.out.println(idx + " HI " + query.getInt("query_id"));
        if (startDelay < 0) {
            Thread.sleep(-startDelay);
            runQuery(query, idx, startOfRunTs);
            return;
        }
System.out.println(this.remaining_retries);

        String queryTemplate = this.queryTemplates.get(query.getInt("query_id") - 1);
System.out.println(queryTemplate);
        SparkSQLPool_s.ResultObject res = null;

        while (this.remaining_retries > 0) {
            try {
                if ((int) query.get("query_id") != 23) {
                    System.out.println("[" + idx + "] Running: " + queryTemplate);
                    res = this.databaseConnection.runPrintSync(queryTemplate, query.getJSONArray("arguments"));
                } else {
                    System.out.println("[" + idx + "] Running split queries.");
                    String[] queryTemplateSplit = queryTemplate.split(":split:");
                    res = this.databaseConnection.runArraySync(queryTemplateSplit, query.getJSONArray("arguments"));
                }
            } catch (Exception e) {
                System.out.println("[" + idx + "] Failed: " + e);
                this.remaining_retries--;
                if (this.remaining_retries == 0) {
                    throw new Exception("Retries exceeded");
                }
                continue;
            }
            break;
        }

        long queryDuration = res.time;
        long doneTs = System.currentTimeMillis();
        long queryDurationWithQueue = doneTs - plannedStartTs;

        Map<String, Object> logEntry = new HashMap<>();
        logEntry.put("query_id", query.getInt("query_id"));
        logEntry.put("start", actualStartTs);
        logEntry.put("relative_start", actualStartTs - startOfRunTs);
        logEntry.put("query_duration", queryDuration);
        logEntry.put("query_duration_with_queue", queryDurationWithQueue);
        logEntry.put("start_delay", startDelay);
        this.queryExecutionLog.add(logEntry);
        this.totalStartDelay += startDelay;
        this.outstanding--; 

        System.out.println("[" + idx + "] Completed query stats: " + this.database.get("database_id") + ", " + query.getInt("query_id") + ", " + queryDuration + ", " + queryDurationWithQueue + ", " + (actualStartTs - startOfRunTs));
    }

    private void printExecutionStats(long totalTime) {
        System.out.println("-- START CSV --");
        BufferedWriter writer = null;
      try{
        writer = new BufferedWriter(new FileWriter("/root/home/spark/mtdds/CABTests_SparkSQL/CAB_traces"+this.database.get("database_id").toString() + ".csv"));
        writer.write("query_stream_id,query_id,start,relative_start,query_duration,query_duration_with_queue,start_delay");
        writer.newLine();
        for (Map<String, Object> entry : this.queryExecutionLog) {
            writer.write(String.join(",",
                    this.database.get("database_id").toString(),
                    entry.get("query_id").toString(),
                    entry.get("start").toString(),
                    entry.get("relative_start").toString(),
                    entry.get("query_duration").toString(),
                    entry.get("query_duration_with_queue").toString(),
                    entry.get("start_delay").toString()
            ));
            writer.newLine();
        }
        writer.close();
      } catch (IOException e) {
        System.out.println(e.getMessage());
      }
        System.out.println("-- STOP CSV --");
        System.out.println("total_time: " + totalTime);
        System.out.println("total_lost: " + this.totalStartDelay);
        System.out.println("query_duration: " + this.queryExecutionLog.stream().mapToLong(e -> (long) e.get("query_duration")).sum());
        System.out.println("query_duration_with_queue: " + this.queryExecutionLog.stream().mapToLong(e -> (long) e.get("query_duration_with_queue")).sum());
        System.out.println("total_cost: " + this.totalCost);
        System.out.println("total_scanned: " + this.totalScanned);
    }
}

public class CABDriver_SUT4_s {
    public static void main(String[] args) {
        int currentId = Integer.parseInt(args[0]);
        SparkSession sparkSession = SparkSQLPool_s.createSparkSession();
        ExecutorService executorService = Executors.newFixedThreadPool(20); // Adjust the number of threads as needed
            
            Future<String> future = executorService.submit(() -> {
                try {
                    System.out.println("query_stream_id: " + currentId);
                    QueryStreamExecutor executor = new QueryStreamExecutor(sparkSession, SparkSQLPool_s.getConfig(), currentId);
                    executor.loadQueryStream(currentId);
                    executor.loadQueryTemplates();
System.out.println("BEFORE...");
                    executor.runQueryStream();
                        
                    System.out.println("Completed query stream: " + currentId);
                } catch (IOException e) {
                    System.err.println("Error loading query stream " + currentId + ": " + e.getMessage());
                } catch (Exception e) {
                    System.err.println("Error running query stream " + currentId + ": " + e.getMessage());
                }
                sparkSession.stop();
                return("Completed query stream: " + currentId);
            });
           
            try{
               String result = future.get();
               System.out.println(result);
               executorService.shutdown();
           } catch(InterruptedException | ExecutionException e) {
               e.printStackTrace();
           } finally {
               if(!executorService.isShutdown()) {
                   executorService.shutdown();
               }
           }
   }
}
