import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import org.apache.spark.SparkConf;
import org.apache.spark.sql.*;
import org.apache.spark.sql.types.*;
import org.apache.spark.sql.functions;
import org.json.JSONArray;

public class SparkSQLPool {
        private Map<String, String> connectionOptions;
        private int usedConnectionCount;
        private int maxConnectionCount;
        private boolean skipResults;
        private int updating;
        private int selecting;
        private SparkSession sparkSession;

        public SparkSQLPool(SparkSession sparkSession, boolean skipResults, Map<String, String> connectionOptions) {
            for (Map.Entry<String, String> entry : connectionOptions.entrySet()) {
                if (entry.getValue() == null) {
                    System.out.println("connection_options: " + connectionOptions);
                    System.out.println("Please define all these options :)");
                    System.exit(-1);
                }
            }

            this.connectionOptions = connectionOptions;
            this.usedConnectionCount = 0;
            this.skipResults = skipResults;
            this.updating = 0;
            this.selecting = 0;
            this.sparkSession = sparkSession;
            Dataset<Row> result = this.sparkSession.sql("USE " + this.connectionOptions.get("database"));
            result.show();
        }
        
        public static SparkSession createSparkSession() {
            SparkConf conf = new SparkConf()
                    .set("spark.sql.catalogImplementation", "hive")
                    .set("spark.master", "spark://gros-21:7077")
                   .set("spark.sql.warehouse.dir", "hdfs://gros-21:9000/usr/spark/spark-warehouse")
                    .set("spark.driver.host", "gros-21")
                    .set("spark.executor.memoryOverhead", "10g")
                    .set("spark.memory.offHeap.enabled", "true")
                    .set("spark.memory.offHeap.size", "16g")
                    .set("spark.sql.crossJoin.enabled", "true")
                    .set("spark.shuffle.service.enabled", "true")
                    .set("spark.shuffle.service.port", "7337")
                    .set("spark.shuffle.io.numConnections", "6")
                    .set("spark.shuffle.io.backLog", "256")
                    .set("spark.reducer.maxReqsInFlight", "3")
                    .set("spark.shuffle.file.buffer", "64k")
                    .set("spark.shuffle.sort.bypassMergeThreshold", "300")
                    .set("spark.worker.cleanup.enabled", "true")
                    .set("spark.dynamicAllocation.enabled", "true")
                    .set("spark.dynamicAllocation.minExecutors", "1")
                    .set("spark.dynamicAllocation.maxExecutors", "10")
                    .set("spark.dynamicAllocation.executorIdleTimeout", "800")
                    .set("spark.dynamicAllocation.shuffleTracking.enabled", "false")
                    .set("spark.shuffle.file.buffer", "1m")
                    .set("spark.sql.autoBroadcastJoinThreshold", "50m")
                    .set("spark.network.timeout", "800s")
                    .set("spark.executor.instances", "2")
                    .set("spark.executor.memory", "24g")
                    .set("spark.executor.cores", "8")
                    .set("spark.driver.memory", "16g")
                    .set("spark.driver.cores", "8")
                    .set("spark.sql.dateFormat","yyyy-MM-dd"); 

            SparkSession sparkSession = SparkSession.builder()
                    .appName("MTDDS Driver")
                    .config(conf)
                    .getOrCreate();
            
            return sparkSession;
        }

        public static Map<String, Object> getConfig() {
            Map<String, Object> config = new HashMap<>();
            config.put("name", "sparkSQL");
            config.put("connector", SparkSQLPool.class);
            config.put("query_template_path", "/root/home/spark/mtdds/CABTests_SparkSQL/sql_sparkSQL");
            return config;
        }

        public void endPool() {
            // Code to stop the spark session
                this.sparkSession.stop();
        }
        
        public static String fillBinds(String sql, JSONArray binds) {
System.out.println(binds);
            if (binds == null) {
                return sql;
            }
            
            String result = sql;
            for (int i = binds.length() - 1; i >= 0; i--) {
                if (binds.get(i) == null) {
                    return result;
                }
                
                if (binds.get(i) instanceof Integer) {
                    result = result.replaceAll(":" + (i + 1), String.valueOf(binds.get(i)));
                } else if (binds.get(i) instanceof String) {
                    result = result.replaceAll(":" + (i + 1), "'" + binds.get(i) + "'");
                } else {
                    throw new Error("unknown type for binding");
                }
            }
            
            return result;
        }
        
        public synchronized ResultObject runPrintSync(String sql, JSONArray binds) {
            System.out.println(System.getenv("SPARK_HOME"));
            usedConnectionCount++;
            String boundSql = fillBinds(sql, binds);
System.out.println(boundSql);
            Dataset<Row> result = this.sparkSession.sql("USE " + this.connectionOptions.get("database"));
            result.show();
            long start = System.currentTimeMillis();
            // SparkSession sparkSession;
            Dataset<Row> res = this.sparkSession.sql(boundSql);
            List<Row> resRows = res.collectAsList();
            long done = System.currentTimeMillis();
            //System.out.println(resRows);
            res.show();
            usedConnectionCount--;
            return new ResultObject(resRows, done - start);
        }

        public synchronized ResultObject runSync(String sql, JSONArray binds) {
            usedConnectionCount++;
            String boundSql = fillBinds(sql, binds);
            Dataset<Row> result = this.sparkSession.sql("USE " + this.connectionOptions.get("database"));
            result.show();
            long start = System.currentTimeMillis();
            System.out.println(start);
            List<Row> resRows = null;
            try {
                Dataset<Row> res = this.sparkSession.sql( boundSql);
                resRows = res.collectAsList();
            } catch(Exception e) {
                System.out.println(e);
            }
            long done = System.currentTimeMillis();
            System.out.println(done);
            usedConnectionCount--;
            return new ResultObject(resRows, done - start);
        }
        
        public class ResultObject {
            List<Row> rows;
            long time;

            ResultObject(List<Row> rows, long time) {
                this.rows = rows;
                this.time = time;
            }
        }
        
        public ResultObject runArraySync(String[] sqlArray, JSONArray binds) {
            List<Row> resRows = null;
            long duration = 0;
            try {
                for (int idx = 0; idx < sqlArray.length; idx++) {
                    String boundSql = SparkSQLPool.fillBinds(sqlArray[idx], binds);
                    Dataset<Row> result = this.sparkSession.sql("USE " + this.connectionOptions.get("database"));
                    result.show(); 
                    System.out.println(sqlArray.length + " Query 23 Test " + boundSql);
                    long start = System.currentTimeMillis();
                    this.sparkSession.sql(boundSql);
                    long done = System.currentTimeMillis();
                    System.out.println(idx + " done!!!!!");
                    duration = duration + (done -start);
                }
            } catch (Exception e) {
                //this.sparkSession.sql("ROLLBACK");
                System.out.println(e);
            } finally {
                //this.sparkSession.stop();
            }
            this.usedConnectionCount--;
            return new ResultObject(resRows, duration); 
        }
        public void waitUntilConnectionsReleased() {
            while (true) {
                if (this.usedConnectionCount == 0) {
                    return;
                }
                try {
                    Thread.sleep(100);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
   }
