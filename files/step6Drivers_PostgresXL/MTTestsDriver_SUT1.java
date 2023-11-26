package example;
import java.sql.*;
import java.util.*;
import java.util.concurrent.Semaphore;
import java.util.concurrent.locks.ReentrantLock;
import java.util.concurrent.CountDownLatch;
import java.text.*;
import java.time.*;
import java.io.*;
import org.apache.ibatis.jdbc.*;
import org.postgresql.jdbc3.*;

public class MTTestsDriver_SUT1 {
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
	
    static Connection DBConnect(Jdbc3PoolingDataSource source){
	Connection conn = null;
	
	try { 		
		//call the getConnection() method for obtaining a connection
		conn = source.getConnection();
		threadMessage("You are connected.");
	} catch(SQLException sqlods){
		threadMessage("Connection impossible!");
	}
		
	return conn;
		
    }
    static void createTimerTask(int delay, int queryNumber, Jdbc3PoolingDataSource source, String DBSize){
    	// creating timer task, timer	
	Timer t = new Timer();
	TimerTask tt = new TimerTask(){
		public void run(){
			Connection conn = null;
			
			DateFormat dateFormat = new SimpleDateFormat("HH:mm:ss.SSS");
			java.util.Date launchDate = new java.util.Date();
			try{
				writerLock.lock();
				csvWriter.append(source.getUser());
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
				// Connection
				conn = DBConnect(source);
				java.util.Date startingDate = new java.util.Date();
				try{
					writerLock.lock();
					csvWriter.append(source.getUser());
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
					scriptFileName = "/home/postgres/mtdds/individualQueries/s/" 
								+ queryNumber + ".sql";
				}
				else if(DBSize.equals("Medium")){
					scriptFileName = "/home/postgres/mtdds/individualQueries/m/" 
								+ queryNumber + ".sql";
				} else // if(DBSize.equals("Large"))
				{
					scriptFileName = "/home/postgres/mtdds/individualQueries/l/" 
								+ queryNumber + ".sql";
				}
				System.out.println("Launching the query " + queryNumber + "...");
				try{
					// Initialize the script runner
					ScriptRunner sr = new ScriptRunner(conn);
					// set SendFullScript to be true
					sr.setSendFullScript(true);
					// Create a read object
					Reader reader = new BufferedReader(new FileReader(scriptFileName));
					// Run the script
					sr.runScript(reader);
				}
				catch(FileNotFoundException fnd){
					System.out.println("File not found: " + scriptFileName);
				}
				catch(Exception rse){
					success = false;
					// if there are other exceptions, reconnect and reexecute the queries
				}
				finally{
					try{
						if(conn != null)
							conn.close();
							threadMessage("Connection closed.");
						}
					catch(SQLException se){
						threadMessage("Failed to close the connection.");
					}
				}
			}while (!success);
			try{
				java.util.Date finishingDate = new java.util.Date();
				try{
					writerLock.lock();
					csvWriter.append(source.getUser());
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
    static void launchQueries(Jdbc3PoolingDataSource source, String file, String DBSize, int arrivalRateFactor){
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
			tempArr = line.split("[,;]");
			int arrivalTime = Integer.parseInt(tempArr[3]);
			float arrivalTimeDigits = Float.parseFloat("0." + tempArr[4]);
			int queryNumber = Integer.parseInt(tempArr[1]);
			createTimerTask((arrivalTime * 300000+(int)(arrivalTimeDigits*300000))/arrivalRateFactor, queryNumber, source, DBSize);
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
    
    	int arrivalRateFactor = Integer.parseInt(args[0]);
	DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	java.util.Date date = new java.util.Date();
	System.out.println(dateFormat.format(date));
	
	// Initialize the Execution traces file
	try{
		csvWriter = new FileWriter("ExecutionTraces_SUT1_ARF" + arrivalRateFactor +".csv"); // SUT1
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
	
	// Tenant1
	Jdbc3PoolingDataSource source1 = new Jdbc3PoolingDataSource();
	source1.setDataSourceName("dsTenant1");
	source1.setServerName("master:30001");
	source1.setDatabaseName("tenant1");
	source1.setUser("tenant1");
	source1.setPassword("tenant1");
	source1.setMaxConnections(100);
	String fileName1 = "/home/postgres/mtdds/tenantQueries/Tenant_1_Queries.csv";

	launchQueries(source1, fileName1, "Medium", arrivalRateFactor);

	// Tenant2
	Jdbc3PoolingDataSource source2 = new Jdbc3PoolingDataSource();
	source2.setDataSourceName("dsTenant2");
	source2.setServerName("master:30001");
	source2.setDatabaseName("tenant2");
	source2.setUser("tenant2");
	source2.setPassword("tenant2");
	source2.setMaxConnections(100);
	String fileName2 = "/home/postgres/mtdds/tenantQueries/Tenant_2_Queries.csv";

	launchQueries(source2, fileName2, "Small", arrivalRateFactor);

	// Tenant3
	Jdbc3PoolingDataSource source3 = new Jdbc3PoolingDataSource();
	source3.setDataSourceName("dsTenant3");
	source3.setServerName("master:30001");
	source3.setDatabaseName("tenant3");
	source3.setUser("tenant3");
	source3.setPassword("tenant3");
	source3.setMaxConnections(100);
	String fileName3 = "/home/postgres/mtdds/tenantQueries/Tenant_3_Queries.csv";

	launchQueries(source3, fileName3, "Medium", arrivalRateFactor);

	// Tenant4
	Jdbc3PoolingDataSource source4 = new Jdbc3PoolingDataSource();
	source4.setDataSourceName("dsTenant4");
	source4.setServerName("master:30001");
	source4.setDatabaseName("tenant4");
	source4.setUser("tenant4");
	source4.setPassword("tenant4");
	source4.setMaxConnections(100);
	String fileName4 = "/home/postgres/mtdds/tenantQueries/Tenant_4_Queries.csv";

	launchQueries(source4, fileName4, "Small", arrivalRateFactor);

	// Tenant5
	Jdbc3PoolingDataSource source5 = new Jdbc3PoolingDataSource();
	source5.setDataSourceName("dsTenant5");
	source5.setServerName("master:30001");
	source5.setDatabaseName("tenant5");
	source5.setUser("tenant5");
	source5.setPassword("tenant5");
	source5.setMaxConnections(100);
	String fileName5 = "/home/postgres/mtdds/tenantQueries/Tenant_5_Queries.csv";

	launchQueries(source5, fileName5, "Large", arrivalRateFactor);

	// Tenant6
	Jdbc3PoolingDataSource source6 = new Jdbc3PoolingDataSource();
	source6.setDataSourceName("dsTenant6");
	source6.setServerName("master:30001");
	source6.setDatabaseName("tenant6");
	source6.setUser("tenant6");
	source6.setPassword("tenant6");
	source6.setMaxConnections(100);
	String fileName6 = "/home/postgres/mtdds/tenantQueries/Tenant_6_Queries.csv";

	launchQueries(source6, fileName6, "Medium", arrivalRateFactor);


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

	return;	
    }
}

