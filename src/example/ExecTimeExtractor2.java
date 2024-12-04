package example;

import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Iterator;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import java.io.BufferedReader;
import java.io.FileReader;

public class ExecTimeExtractor2 {
	// connection to a DBMS
	static Connection DBConnect() throws SQLException{
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
	
	public static void extractExecTime(String dir, String outputFile) throws IOException, SQLException {
		FileWriter csvWriter = null;
		String planFile = null;
		BufferedReader planReader = null;
		String createExecTimes = "CREATE TABLE IF NOT EXISTS ExecTimes (queryId varchar(20), execTime number(20))";
		String deleteExecTimes = "DELETE FROM ExecTimes";
		String insertExecTime = "INSERT INTO ExecTimes VALUES(?,?)";
		String computeAvgExecTimes = "SELECT queryId, AVG(execTime) as avgExecTime FROM ExecTimes GROUP BY queryId";
		
		Statement stm = null;
		PreparedStatement pstm = null;
		ResultSet rst = null;
		
		// Connection
		Connection conn = DBConnect();
		try {
	    	stm = conn.createStatement();
	    	stm.execute(createExecTimes);
	    	System.out.println("ExecTimes created.");
	    	stm.executeUpdate(deleteExecTimes);
	    	System.out.println("ExecTimes created.");
	    } catch (SQLException se) {
	    	System.out.println(se);
	    } finally {
	    	stm.close();
	    }
		
		try {
			try {
				csvWriter = new FileWriter(outputFile);
				//write the file header
				csvWriter.append("queryId");
				csvWriter.append(";");
				csvWriter.append("execTime");
				csvWriter.append("\n");
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			for(int i=1; i<=3; i++){
				Set<String> planFiles = listFiles(dir + "_" + i);
				Iterator<String> itr = planFiles.iterator();
				while(itr.hasNext()) {
					planFile = itr.next();
					planReader = new BufferedReader(new FileReader(dir+"\\"+planFile));
					String row;
					while ((row = planReader.readLine()) != null) {
					    String[] data = row.split(" ");
					    if(data.length<2) {
					    	continue;
					    }
					    else if(data[1].equals("Execution") && data[2].equals("time:")) {
					    	String[] fnameToken = planFile.split("[_.]");
					    	String queryId = fnameToken[3].substring(1);
					    	String[] execTime = data[3].split("[.]");
					    	Long execTime_ms = Long.parseLong(execTime[0]);

					    	try {
						    	pstm = conn.prepareStatement(insertExecTime);
						    	pstm.setString(1, queryId);
						    	pstm.setLong(2, execTime_ms);
						    	pstm.execute();
						    } catch (SQLException se) {
						    	System.out.println(se);
						    }
						    finally {
						    	pstm.close();
						    }
					    }
					}
				}
			}
			
			// compute the average ExecTime of each query and write it into the output file
			try {
		    	stm = conn.createStatement();
		    	rst = stm.executeQuery(computeAvgExecTimes);
		    	while(rst.next()) {
					String queryId = rst.getString("queryId");
					Long avgExecTime = rst.getLong("avgExecTime");

					csvWriter.append(queryId);
					csvWriter.append(";");
					csvWriter.append(Long.toString(avgExecTime));
					csvWriter.append("\n");					
				}				
		    } catch (SQLException se) {
		    	System.out.println(se);
		    } finally {
		    	stm.close();
		    	rst.close();
		    }
			
			csvWriter.flush();
			csvWriter.close();
			planReader.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public static Set<String> listFiles(String dir) throws IOException {
	    try (Stream<Path> stream = Files.list(Paths.get(dir))) {
	        return stream
	          .filter(file -> !Files.isDirectory(file))
	          .map(Path::getFileName)
	          .map(Path::toString)
	          .collect(Collectors.toSet());
	    }
	}
	
	public static void main(String[] args) throws IOException, SQLException {
		//args[0]: input directory
		//args[1]: output file (directory + file name)
		extractExecTime(args[0], args[1]);		
	}
}
