import java.sql.*;
import java.util.*;
import java.text.*;
import java.time.*;
import java.io.*;
import org.apache.spark.sql.SparkSession;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.catalog.Catalog;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class PowerTest_l {
    private static FileWriter csvWriter = null;

    public static void main(String[] args) {

			try {
				csvWriter = new FileWriter("/root/home/spark/mtdds/files_SparkSQL/step2Scripts_SparkSQL/ExecTime_100.csv");
				//write the file header
				csvWriter.append("queryId");
				csvWriter.append(";");
				csvWriter.append("ExecTime");
				csvWriter.append("\n");
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

        SparkSession spark = SparkSession
                              .builder()
                              .appName("MTDDS Driver")
                              .config("spark.master", "spark://gros-21:7077")
                              //.config("spark.master", "local[*]")
                              .config("spark.sql.warehouse.dir", "hdfs://gros-21:9000/usr/spark/spark-warehouse")
                              //.config("spark.blockManager.port", "10025")
                              //.config("spark.driver.blockManager.port", "10026")
                              .config("spark.driver.host", "gros-21")
                              //.config("spark.driver.bindAddress", "gros-21")
                              .config("spark.executor.memoryOverhead", "10g")
                              .config("spark.memory.offHeap.enabled", "true")
                              .config("spark.memory.offHeap.size","16g")
                              .config("spark.sql.crossJoin.enabled", "true")
                              .config("spark.shuffle.service.enabled", "true")
                              .config("spark.shuffle.service.port", "7337")
                              .config("spark.shuffle.io.numConnections", "6")
                              .config("spark.shuffle.io.backLog", "256")
                              .config("spark.reducer.maxReqsInFlight", "3")
                              .config("spark.shuffle.file.buffer", "64k")
                              .config("spark.shuffle.sort.bypassMergeThreshold", "300")
                              .config("spark.worker.cleanup.enabled", "true")
                              .config("spark.dynamicAllocation.enabled", "true")
                              .config("spark.dynamicAllocation.minExecutors", "1")
                              .config("spark.dynamicAllocation.maxExecutors", "10")
                              .config("spark.dynamicAllocation.executorIdleTimeout", "800")
                              .config("spark.dynamicAllocation.shuffleTracking.enabled", "false")
                              .config("spark.shuffle.file.buffer", "1m")
                              .config("spark.sql.autoBroadcastJoinThreshold", "50m")
                              //.config("spark.sql.shuffle.partitions", "100")
                              //.config("spark.shuffle.memoryFraction", "0.6")
                              //.config("spark.reducer.maxSizeInFlight", "128m")
                              //.config("spark.storage.memoryFraction", "0.4")
                              //.config("spark.serializer", "org.apache.spark.serializer.KryoSerializer")
                              //.config("spark.default.parallelism", "24")
                              //.config("spark.driver.maxResultSize", "2g")
                              .config("spark.network.timeout", "800s")
                              //.config("spark.shuffle.io.maxRetries", "10")
                              //.config("spark.broadcast.blockSize","2m")
                              .config("spark.executor.instances", "2")
                              .config("spark.executor.memory", "24g")
                              .config("spark.executor.cores", "8")
                              .config("spark.driver.memory", "16g")
                              .config("spark.driver.cores", "8")
                              .enableHiveSupport()
                              .getOrCreate();
         spark.sql("CLEAR CACHE");
        
        for(int queryNumber=1; queryNumber<100; queryNumber++){
		String scriptFileName = "/root/home/spark/mtdds/files_SparkSQL/step5IndividualQueries/l/" + queryNumber + ".sql";
           System.out.println("Launching the query " + queryNumber + "...");
		java.util.Date startingDate = new java.util.Date();
           try{	
			StringBuilder sqlScript = new StringBuilder();
			try(BufferedReader reader = new BufferedReader(new FileReader(scriptFileName))){
                       String line;
                       while((line = reader.readLine())!=null){
                              sqlScript.append(line).append("\n");
                       }
                } catch(IOException e) {
                       e.printStackTrace();
                }
                spark.sql("USE l");
                String[] sqlQueries=sqlScript.toString().split(";");
                int NbQueries = sqlQueries.length - 1;
                for(int i=0; i<NbQueries; i++) {
                    String query = sqlQueries[i];
                    if(!query.isEmpty()){
                         System.out.println("Executing query: " + query);
                         Dataset<Row> result = spark.sql(query);
                         result.show();
                    }
                }
            }
            catch(Exception rse){
                rse.printStackTrace();
            }

		 try{
                java.util.Date finishingDate = new java.util.Date();
                try{
                    csvWriter.append(Integer.toString(queryNumber));
                    csvWriter.append(";");
                    csvWriter.append(Long.toString(finishingDate.getTime()-startingDate.getTime()));
                    csvWriter.append("\n");
                }
                catch(IOException ioe)
                {
                    System.out.println("IO Exception...");
                    ioe.printStackTrace();
                }
           }
           catch(Exception e) {}

        }

        try{
                csvWriter.flush();
                csvWriter.close();
        }
        catch(IOException ioe)
        {
                System.out.println("IO Exception.");
        }
        finally {
                if(spark != null) {
                     spark.stop();
                }
        }
        return;
    }
}
