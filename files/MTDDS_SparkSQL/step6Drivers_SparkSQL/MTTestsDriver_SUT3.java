import java.sql.*;
import java.util.*;
import java.util.concurrent.Semaphore;
import java.util.concurrent.locks.ReentrantLock;
import java.util.concurrent.CountDownLatch;
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

public class MTTestsDriver_SUT3 {
    private static final int MAX_AV = 3;
    private static final int NB_QUERIES = 290;
    private static Semaphore sem = new Semaphore(MAX_AV, true);
    private static FileWriter csvWriter = null;
    private static ReentrantLock writerLock = new ReentrantLock();
    private static CountDownLatch latch = new CountDownLatch(NB_QUERIES);
    	
	// Display a message with the thread name
    static void threadMessage(String message) {
        String threadName =
            Thread.currentThread().getName();
        System.out.format("%s: %s%n",
                          threadName,
                          message);
    }
	
    static void createTimerTask(int delay, int queryNumber, String tenantId, String DBSize, SparkSession spark){
    	// creating timer task, timer	
	Timer t = new Timer();
	TimerTask tt = new TimerTask(){
		public void run(){
			DateFormat dateFormat = new SimpleDateFormat("HH:mm:ss.SSS");
			java.util.Date launchDate = new java.util.Date();
			try{
				writerLock.lock();
				csvWriter.append(tenantId);
				csvWriter.append(";");
				csvWriter.append("q"+Integer.toString(queryNumber));
				csvWriter.append(";");
				csvWriter.append(Thread.currentThread().getName());
				csvWriter.append(";");
				csvWriter.append("Launched");
				csvWriter.append(";");
				csvWriter.append(dateFormat.format(launchDate));
				csvWriter.append("\n");
				writerLock.unlock();
			}
			catch(IOException ioe)
			{
				System.out.println("IO Exception.");
			}
						
			try{
				if(queryNumber==78){
					Boolean acquired = false;
					while(!acquired){
						// try to acquire all the semaphores for the query 78 to get more memory
						acquired = sem.tryAcquire(MAX_AV); 
					}
				} 
				else{
					sem.acquire();
				}
			}
			catch(InterruptedException ie){
				threadMessage("Failed to acquire the semaphore");
			}
						
			boolean success = true;
			do{        		
				java.util.Date startingDate = new java.util.Date();
				try{
					writerLock.lock();
					csvWriter.append(tenantId);
					csvWriter.append(";");
					csvWriter.append("q"+Integer.toString(queryNumber));
					csvWriter.append(";");
					csvWriter.append(Thread.currentThread().getName());
					csvWriter.append(";");
					csvWriter.append("Started");
					csvWriter.append(";");
					csvWriter.append(dateFormat.format(startingDate));
					csvWriter.append("\n");
					writerLock.unlock();
				}
				catch(IOException ioe)
				{
					System.out.println("IO Exception.");
				}
				// Launch the query script
				String scriptFileName = null;
				if(DBSize.equals("Small")){
					scriptFileName = "/root/home/spark/mtdds/files_SparkSQL/step5IndividualQueries/s/" 
								+ queryNumber + ".sql";
				}
				else if(DBSize.equals("Medium")){
					scriptFileName = "/root/home/spark/mtdds/files_SparkSQL/step5IndividualQueries/m/" 
								+ queryNumber + ".sql";
				} else // if(DBSize.equals("Large"))
				{
					scriptFileName = "/root/home/spark/mtdds/files_SparkSQL/step5IndividualQueries/l/" 
								+ queryNumber + ".sql";
				}
				System.out.println("Launching the query " + queryNumber + "...");
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

                                        //Dataset<Row> result = spark.sql("SHOW DATABASES"); 
                                        //result.show();
                                        spark.sql("USE " + tenantId);
                                        String[] sqlQueries=sqlScript.toString().split(";");
				        int NbQueries = sqlQueries.length - 1;
                                        System.out.println(NbQueries + "******");
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
					success = false;
					// if there are other exceptions, reconnect and reexecute the queries
				}
			}while (!success);
			try{
				java.util.Date finishingDate = new java.util.Date();
				try{
					writerLock.lock();
					csvWriter.append(tenantId);
					csvWriter.append(";");
					csvWriter.append("q"+Integer.toString(queryNumber));
					csvWriter.append(";");
					csvWriter.append(Thread.currentThread().getName());
					csvWriter.append(";");
					csvWriter.append("Finished");
					csvWriter.append(";");
					csvWriter.append(dateFormat.format(finishingDate));
					csvWriter.append("\n");
					writerLock.unlock();
				}
				catch(IOException ioe)
				{
					System.out.println("IO Exception...");
					ioe.printStackTrace();
				}
				t.cancel();				
				if(queryNumber==78){
					sem.release(MAX_AV); // release all the semaphores
				}
				else{
					sem.release();
				}
				latch.countDown();
				//Thread.currentThread().join();
			}
			catch(Exception e) {}
		};
	};
    	t.schedule(tt, delay);	
    }
    static void launchQueries(String tenantId, String file, String DBSize, int arrivalRateFactor, SparkSession spark){
	try{
		// read the input file with the tenant's query arrivals
		File inputFile = new File(file);
		FileReader fr = new FileReader(inputFile);
		BufferedReader br = new BufferedReader(fr);
		String line = br.readLine();
		line = br.readLine();
		String[] tempArr;
		// launch queries one by one
		while(line != null){
			tempArr = line.split("[,;.]");
			int arrivalTime = Integer.parseInt(tempArr[3]);
			float arrivalTimeDigits = Float.parseFloat("0." + tempArr[4]);
			int queryNumber = Integer.parseInt(tempArr[1]);
			createTimerTask((arrivalTime * 300000+(int)(arrivalTimeDigits*300000))/arrivalRateFactor, queryNumber, tenantId, DBSize, spark);
			line = br.readLine();	
		}	
	}
	catch(FileNotFoundException fnd){
		System.out.println("File not found.");
	}
	catch(IOException ioe){
		System.out.println("IO Exception.");
	}
    }
	
    public static void main(String[] args) {
    
    	int arrivalRateFactor = Integer.parseInt(args[0])*10;
	DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	java.util.Date date = new java.util.Date();
	System.out.println(dateFormat.format(date));
	
	// Initialize the Execution traces file
	try{
		csvWriter = new FileWriter("/root/home/spark/mtdds/files_SparkSQL/step6Drivers_SparkSQL/ExecutionTraces_SUT3_ARF" + arrivalRateFactor/10 +".csv"); // SUT3
		csvWriter.append("TenantName");
		csvWriter.append(";");
		csvWriter.append("QueryNumber");
		csvWriter.append(";");
		csvWriter.append("ThreadName");
		csvWriter.append(";");
		csvWriter.append("Event");
		csvWriter.append(";");
		csvWriter.append("TimeStamp");
		csvWriter.append("\n");
	}
	catch(IOException ioe)
	{
		System.out.println("IO Exception.");
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

	// Tenant1
	String fileName1 = "/root/home/spark/mtdds/files_SparkSQL/6tenantsQueries/Tenant_1_Queries.csv";


	launchQueries("tenant1", fileName1, "Medium", arrivalRateFactor, spark);

	// Tenant2
	String fileName2 = "/root/home/spark/mtdds/files_SparkSQL/6tenantsQueries/Tenant_2_Queries.csv";

	launchQueries("tenant2", fileName2, "Small", arrivalRateFactor, spark);

	// Tenant3
	String fileName3 = "/root/home/spark/mtdds/files_SparkSQL/6tenantsQueries/Tenant_3_Queries.csv";

	launchQueries("tenant3", fileName3, "Medium", arrivalRateFactor, spark);

	// Tenant4
	String fileName4 = "/root/home/spark/mtdds/files_SparkSQL/6tenantsQueries/Tenant_4_Queries.csv";

	launchQueries("tenant4", fileName4, "Small", arrivalRateFactor, spark);

	// Tenant5
	String fileName5 = "/root/home/spark/mtdds/files_SparkSQL/6tenantsQueries/Tenant_5_Queries.csv";

	launchQueries("tenant5", fileName5, "Large", arrivalRateFactor, spark);

	// Tenant6
	String fileName6 = "/root/home/spark/mtdds/files_SparkSQL/6tenantsQueries/Tenant_6_Queries.csv";

	launchQueries("tenant6", fileName6, "Medium", arrivalRateFactor, spark);


	try{
		latch.await();
		csvWriter.flush();
		csvWriter.close();
	}
	catch(InterruptedException ie){
		System.out.println("Interrupted Exception.");
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

