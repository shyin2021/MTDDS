package tools;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

// Input: Execution traces with (TenantName, QueryNumber, ThreadName, Event, TimeStamp)
// Output: Execution traces with (SUTNumber, clusterSize, arrivalRateFactor, TenantName, QueryNumber, ThreadName, LaunchTime, StartTime, FinishTime);
public class ExecutionTraceTransformer {
   
	static Connection DBConnect(){
		Connection conn = null;
        try {
            // db parameters
            String url = "jdbc:sqlite:mtdds.db";
            // create a connection to the database
            conn = DriverManager.getConnection(url);
            
            System.out.println("Connection to SQLite has been established.");
            
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
	
        return conn;	
    }

	
	public static void transformTraces(String inputFile, String outputFile, int SUTNumber, int clusterSize, int arrivalRateFactor) throws SQLException {
		//read the input file
		BufferedReader csvReader;
		FileWriter csvWriter = null;
		String deleteInitialTraces = "DELETE FROM InitialTraces";
		String deleteFormatedTraces = "DELETE FROM FormatedTraces WHERE SUTNumber=? AND clusterSize=? and arrivalRateFactor=?";
		String insertInitialTraces = "INSERT INTO InitialTraces VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
		String insertFormatedTraces = "INSERT INTO FormatedTraces(SUTNumber, clusterSize, arrivalRateFactor, tenantName, queryName, timerName, launchTime) SELECT SUTNumber, clusterSize, arrivalRateFactor, tenantName, queryName, timerName, timestamp FROM InitialTraces WHERE event='Launched'";
		String updateFormatedTraces1 = "UPDATE FormatedTraces SET startTime = (SELECT timestamp FROM InitialTraces IT WHERE FormatedTraces.tenantName=IT.tenantName AND FormatedTraces.timerName=IT.timerName AND IT.event='Started') WHERE SUTNumber=? AND clusterSize=? and arrivalRateFactor=?";
		String updateFormatedTraces2 = "UPDATE FormatedTraces SET finishTime = (SELECT timestamp FROM InitialTraces IT WHERE FormatedTraces.tenantName=IT.tenantName AND FormatedTraces.timerName=IT.timerName AND IT.event='Finished') WHERE SUTNumber=? AND clusterSize=? and arrivalRateFactor=?";
		String updateFormatedTraces3 = "UPDATE FormatedTraces SET relativeLaunchTime = launchTime - (SELECT MIN(launchTime) FROM FormatedTraces WHERE SUTNumber=? AND clusterSize=? and arrivalRateFactor=?) WHERE SUTNumber=? AND clusterSize=? and arrivalRateFactor=?";
		String updateFormatedTraces4 = "UPDATE FormatedTraces SET waitingTime = startTime - launchTime WHERE SUTNumber=? AND clusterSize=? and arrivalRateFactor=?";
		String updateFormatedTraces5 = "UPDATE FormatedTraces SET executionTime = finishTime - startTime WHERE SUTNumber=? AND clusterSize=? and arrivalRateFactor=?";
		String readFormatedTraces = "SELECT * FROM FormatedTraces WHERE SUTNumber=? AND clusterSize=? AND arrivalRateFactor=? ORDER BY tenantName, timerName ";
		
		Statement stm = null;
		PreparedStatement pstm = null;
		ResultSet rst = null;
		
		System.out.println("[COUNTER] SUTNumber = " + SUTNumber + ", clusterSize = " + clusterSize + ", arrivalRateFactor = " + arrivalRateFactor);
		
		// Connection
		Connection conn = DBConnect();
		try {
	    	stm = conn.createStatement();
	    	stm.executeUpdate(deleteInitialTraces);
	    	System.out.println("InitialTraces deleted.");
	    	pstm = conn.prepareStatement(deleteFormatedTraces);
	    	pstm.setInt(1, SUTNumber);
	    	pstm.setInt(2, clusterSize);
	    	pstm.setInt(3, arrivalRateFactor);
	    	pstm.executeUpdate();
	    	System.out.println("Formated Traces deleted.");
	    } catch (SQLException se) {
	    	System.out.println(se);
	    } finally {
	    	stm.close();
	    	pstm.close();
	    	conn.close();
	    	System.out.println("Connection closed.");
	    }
		
		conn = DBConnect();
		try {
			// load data from the input file into the relation InitialTraces
			csvReader = new BufferedReader(new FileReader(inputFile));
			
			//skip the file header
			String row = csvReader.readLine();
			long prev_hour = 0;
			boolean change_day = false;
			while ((row = csvReader.readLine()) != null) {
			    String[] data = row.split(";");
			    // retrieve one line of the traces
			    String tenantName = data[0];
			    String queryName = data[1];
			    String timerName = data[2];
			    String event = data[3];
			    String ts[] = data[4].split("[:.]");
			    long hour = Long.parseLong(ts[0]);
			    long minute = Long.parseLong(ts[1]);
			    long second = Long.parseLong(ts[2]);
			    long millis = Long.parseLong(ts[3]);
			    
			    if(hour < prev_hour) {
			    	change_day = true;
			    }
			    prev_hour = hour;
			    if(change_day) {
			    	hour = hour + 24;
			    }
			    
			    long timestamp = hour*3600000 + minute*60000 + second*1000 + millis; 
			    // add this information in the database
			    try {
			    	pstm = conn.prepareStatement(insertInitialTraces);
			    	pstm.setInt(1, SUTNumber);
			    	pstm.setInt(2, clusterSize);
			    	pstm.setInt(3, arrivalRateFactor);
			    	pstm.setString(4, tenantName);
			    	pstm.setString(5, queryName);
			    	pstm.setString(6, timerName);
			    	pstm.setString(7, event);
			    	pstm.setLong(8, timestamp);
			    	pstm.executeUpdate();
			    } catch (SQLException se) {
			    	System.out.println(se);
			    }
			    finally {
			    	pstm.close();
			    }
			} 
			
			// fill the relation FormatedTraces
			try {
				stm = conn.createStatement();
				stm.executeUpdate(insertFormatedTraces);
		    	System.out.println("Formated Traces updated for launch time.");
		    	pstm = conn.prepareStatement(updateFormatedTraces1);
		    	pstm.setInt(1, SUTNumber);
		    	pstm.setInt(2, clusterSize);
		    	pstm.setInt(3, arrivalRateFactor);
		    	pstm.executeUpdate();
				pstm.close();
		    	System.out.println("Formated Traces updated for start time.");
		    	pstm = conn.prepareStatement(updateFormatedTraces2);
		    	pstm.setInt(1, SUTNumber);
		    	pstm.setInt(2, clusterSize);
		    	pstm.setInt(3, arrivalRateFactor);
		    	pstm.executeUpdate();
				pstm.close();
		    	System.out.println("Formated Traces updated for finish time.");
		    	pstm = conn.prepareStatement(updateFormatedTraces3);
		    	pstm.setInt(1, SUTNumber);
		    	pstm.setInt(2, clusterSize);
		    	pstm.setInt(3, arrivalRateFactor);
		    	pstm.setInt(4, SUTNumber);
		    	pstm.setInt(5, clusterSize);
		    	pstm.setInt(6, arrivalRateFactor);
		    	pstm.executeUpdate();
				pstm.close();
		    	System.out.println("Formated Traces updated for relative launch time.");
		    	pstm = conn.prepareStatement(updateFormatedTraces4);
		    	pstm.setInt(1, SUTNumber);
		    	pstm.setInt(2, clusterSize);
		    	pstm.setInt(3, arrivalRateFactor);
		    	pstm.executeUpdate();
				pstm.close();
		    	System.out.println("Formated Traces updated for waiting time.");
		    	pstm = conn.prepareStatement(updateFormatedTraces5);
		    	pstm.setInt(1, SUTNumber);
		    	pstm.setInt(2, clusterSize);
		    	pstm.setInt(3, arrivalRateFactor);
		    	pstm.executeUpdate();
				pstm.close();
		    	System.out.println("Formated Traces updated for execution time.");
		    } catch (SQLException se) {
		    	System.out.println(se);
		    } finally {
		    	stm.close();
		    }
			
			// export the FormatedTraces relation into the output file
			try {
				try {
					csvWriter = new FileWriter(outputFile); //tenantName, queryName, timerName, launchTime, startTime, finishTime, relativeLaunchTime, waitingTime, executionTime
					//write the file header
					csvWriter.append("tenantName");
					csvWriter.append(";");
					csvWriter.append("queryName");
					csvWriter.append(";");
					csvWriter.append("timerName");
					csvWriter.append(";");
					csvWriter.append("launchTime");
					csvWriter.append(";");
					csvWriter.append("startTime");
					csvWriter.append(";");
					csvWriter.append("finishTime");
					csvWriter.append(";");
					csvWriter.append("relativeLaunchTime");
					csvWriter.append(";");
					csvWriter.append("waitingTime");
					csvWriter.append(";");
					csvWriter.append("executionTime");
					csvWriter.append("\n");
				} catch (IOException ie) {
					System.out.println(ie);
				}
				
				pstm = conn.prepareStatement(readFormatedTraces);
				pstm.setInt(1, SUTNumber);
		    	pstm.setInt(2, clusterSize);
		    	pstm.setInt(3, arrivalRateFactor);
				rst = pstm.executeQuery();
				DateFormat dateFormat = new SimpleDateFormat("HH:mm:ss.SSS");
				String prev_tenantName = null;
				// read the tuples one by one and write them into a csv file
				while(rst.next()) {
					String tenantName = rst.getString("tenantName");
					if(tenantName.equals(prev_tenantName)) {
						csvWriter.append("");
					} else {
						csvWriter.append(tenantName);
					}
					prev_tenantName = tenantName;
					
					csvWriter.append(";");
					csvWriter.append(rst.getString("queryName"));
					csvWriter.append(";");
					csvWriter.append(rst.getString("timerName"));
					csvWriter.append(";");
					csvWriter.append(dateFormat.format(rst.getLong("launchTime")-3600000));
					csvWriter.append(";");
					csvWriter.append(dateFormat.format(rst.getLong("startTime")-3600000));
					csvWriter.append(";");
					csvWriter.append(dateFormat.format(rst.getLong("finishTime")-3600000));
					csvWriter.append(";");
					csvWriter.append(dateFormat.format(rst.getLong("relativeLaunchTime")-3600000));
					csvWriter.append(";");
					csvWriter.append(dateFormat.format(rst.getLong("waitingTime")-3600000));
					csvWriter.append(";");
					csvWriter.append(dateFormat.format(rst.getLong("executionTime")-3600000));
					csvWriter.append("\n");					
				}				
			} catch (SQLException se) {
				System.out.println(se);
			} finally {
				pstm.close();
				rst.close();
				csvReader.close();
				csvWriter.close();
			}
			
			
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			conn.close();
			System.out.println("Connection closed.");
		}

		
	}
	
	public static void transformAllTraces(int SUTNumber, String inputDir, int NbTraces, String outputDir) throws SQLException {
		for(int i=1; i<=NbTraces; i++) {
			transformTraces(inputDir+"\\ExecutionTraces_SUT"+Integer.toString(SUTNumber)+"_ARF"+i+".csv", outputDir+"\\ExecutionTraces_SUT"+Integer.toString(SUTNumber)+"_ARF"+i+"_formated.csv", SUTNumber, 5, i);
		}
	}
	
	public static void main(String[] args) throws SQLException
	{
		transformAllTraces(Integer.parseInt(args[0]), args[1], Integer.parseInt(args[2]), args[3]);
		System.out.println("Execution traces transformed.");
	}	
}
