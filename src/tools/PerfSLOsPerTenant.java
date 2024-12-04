package tools;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class PerfSLOsPerTenant {
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
	
	// Load the performance SLOs into the database
	public static void  LoadPerfSLOs(String inputFile, String SUTName) throws SQLException {
		//read the input file
		BufferedReader csvReader;
		String createSUTPerfSLOs = "CREATE TABLE IF NOT EXISTS " + SUTName + "perfSLOs(\r\n"
				+ "		queryId varchar(20), \r\n"
				+ "		scaleFactor number(6),\r\n"
				+ "		expectedExecTime number(20),\r\n"
				+ "		expectedQCT number(20), \r\n"
				+ "		perfSLO_premium number(20), \r\n"
				+ "		perfSLO_standard number(20), \r\n"
				+ "		perfSLO_basic number(20),\r\n"
				+ "		PRIMARY KEY (queryId, scaleFactor))";
		String deleteSUTPerfSLOs = "DELETE FROM " + SUTName + "PerfSLOs";
		String insertSUTPerfSLOs = "INSERT INTO " + SUTName + "perfSLOs VALUES(?, ?, ?, ?, ?, ?, ?)"; //(queryId, scaleFactor, expectedExecTime, expectedQCT, perfSLO_premium, perfSLO_standard, perfSLO_basic)
		
		Statement stm = null;
		PreparedStatement pstm = null;
		
		// Connection
		Connection conn = DBConnect();
		try {
	    	stm = conn.createStatement();
	    	stm.execute(createSUTPerfSLOs);
	    	stm.executeUpdate(deleteSUTPerfSLOs);
	    	System.out.println(SUTName + "PerfSLOs deleted.");
	    } catch (SQLException se) {
	    	System.out.println(se);
	    } finally {
	    	stm.close();
	    }
		
		try {
			// load data from the input file into the relation InitialTraces
			csvReader = new BufferedReader(new FileReader(inputFile));
			
			//skip the file header
			String row = csvReader.readLine();
			while ((row = csvReader.readLine()) != null) {
			    String[] data = row.split(";");
			    // retrieve one line of the traces
			    String queryId = data[0];
			    int scaleFactor = Integer.parseInt(data[1]);
			    long expectedExecTime = Long.parseLong(data[2]);
			    long exectedQCT = Long.parseLong(data[3]);
			    long perfSLO_premium = Long.parseLong(data[4]);
			    long perfSLO_standard = Long.parseLong(data[5]);
			    long perfSLO_basic = Long.parseLong(data[6]);
			    
			    try {
			    	pstm = conn.prepareStatement(insertSUTPerfSLOs);
			    	pstm.setString(1, queryId);
			    	pstm.setInt(2, scaleFactor);
			    	pstm.setLong(3, expectedExecTime);
			    	pstm.setLong(4, exectedQCT);
			    	pstm.setLong(5, perfSLO_premium);
			    	pstm.setLong(6, perfSLO_standard);
			    	pstm.setLong(7, perfSLO_basic);
			    	pstm.execute();
			    } catch (SQLException se) {
			    	System.out.println(se);
			    }
			    finally {
			    	pstm.close();
			    }
			}
			csvReader.close();
			System.out.println(SUTName + "PerfSLOs inserted.");
		} catch (IOException ie) {
			System.out.println(ie);
		} finally {
			conn.close();
			System.out.println("Connection closed.");
		}
	}
	
	// compute the performance SLOs to use for comparing SUTs
	public static void  ComputePerfSLOs(String SUT_A, String SUT_B, String PriorityTRTFile) throws SQLException {
		//get the tolerance rate threshold for the premium tenants : trp
		BufferedReader priorityTRTReader;
		double trp = 1;
		try {
			priorityTRTReader = new BufferedReader(new FileReader(PriorityTRTFile)); // Priority, TRT
						
			//skip the file header
			String row = priorityTRTReader.readLine();
			while ((row = priorityTRTReader.readLine()) != null) {
				String[] data = row.split(";");
				String Priority = data[0];
				double TRT = Double.parseDouble(data[1]);
				if(Priority.equals("Premium")) {
					trp = TRT;
				}
			}
			priorityTRTReader.close();
		} catch (IOException ie) {
			System.out.println(ie);
		}
		
		// prepare the statements
		String deletePerfSLOs = "DELETE FROM PerfSLOs";
		String insertPerfSLOs = "INSERT INTO perfSLOs SELECT SUT_A.queryId, SUT_A.scaleFactor, "
				+ "MAX(MAX(SUT_A.expectedExecTime, SUT_B.expectedExecTime)/" + Double.toString(trp) +", MIN(SUT_A.expectedExecTime, SUT_B.expectedExecTime)), "
				+ "MAX(MAX(SUT_A.expectedQCT, SUT_B.expectedQCT)/" + Double.toString(trp) +", MIN(SUT_A.expectedQCT, SUT_B.expectedQCT)), "
				+ "MAX(MAX(SUT_A.perfSLO_premium, SUT_B.perfSLO_premium)/" + Double.toString(trp) +", MIN(SUT_A.perfSLO_premium, SUT_B.perfSLO_premium)), "
				+ "MAX(MAX(SUT_A.perfSLO_standard, SUT_B.perfSLO_standard)/" + Double.toString(trp) +", MIN(SUT_A.perfSLO_standard, SUT_B.perfSLO_standard)), "
				+ "MAX(MAX(SUT_A.perfSLO_basic, SUT_B.perfSLO_basic)/" + Double.toString(trp) +", MIN(SUT_A.perfSLO_basic, SUT_B.perfSLO_basic)) "
				+ "FROM " + SUT_A + "perfSLOs SUT_A, " + SUT_B + "perfSLOs SUT_B "
				+ "WHERE SUT_A.queryId = SUT_B.queryId AND SUT_A.scaleFactor = SUT_B.scaleFactor";
		//(queryId, scaleFactor, expectedExecTime, expectedQCT, perfSLO_premium, perfSLO_standard, perfSLO_basic)
		/*String insertPerfSLOs = "INSERT INTO perfSLOs SELECT SUT_A.queryId, SUT_A.scaleFactor, "
				+ "MAX(SUT_A.expectedExecTime, SUT_B.expectedExecTime), "
				+ "MAX(SUT_A.expectedQCT, SUT_B.expectedQCT), "
				+ "MAX(SUT_A.perfSLO_premium, SUT_B.perfSLO_premium), "
				+ "MAX(SUT_A.perfSLO_standard, SUT_B.perfSLO_standard), "
				+ "MAX(SUT_A.perfSLO_basic, SUT_B.perfSLO_basic) "
				+ "FROM " + SUT_A + "perfSLOs SUT_A, " + SUT_B + "perfSLOs SUT_B "
				+ "WHERE SUT_A.queryId = SUT_B.queryId AND SUT_A.scaleFactor = SUT_B.scaleFactor";*/
		
		Statement stm = null;
		
		// Connection
		Connection conn = DBConnect();
		try {
	    	stm = conn.createStatement();
	    	stm.executeUpdate(deletePerfSLOs);
	    	System.out.println("PerfSLOs deleted.");
	    	stm.executeUpdate(insertPerfSLOs);
	    	System.out.println("PerfSLOs inserted.");
	    } catch (SQLException se) {
	    	System.out.println(se);
	    } finally {
	    	stm.close();
			conn.close();
			System.out.println("Connection closed.");
	    }
	}
	
	// compute the perfSLOs for each tenant
	public static void computePerfSLOs_per_tenant(String tenantsFile) throws SQLException {
		//read the input file
				BufferedReader csvReader;
				String deletePerfSLOs_per_tenant = "DELETE FROM PerfSLOs_per_tenant";
				String insertPerfSLOs_per_tenant = "INSERT INTO perfSLOs_per_tenant VALUES(?, ?, ?, ?, ?)"; //(tenantId, queryId, expectedExectime, expectedQCT, perfSLO)
				String retrieveSLOsbyDBSize = "SELECT PerfSLOs.* FROM PerfSLOs, DBSizesSF WHERE PerfSLOs.scaleFactor = DBSizesSF.scaleFactor AND DBSize = ?";
				
				Statement stm = null;
				PreparedStatement pstm = null;
				
				// Connection
				Connection conn = DBConnect();
				try {
			    	stm = conn.createStatement();
			    	stm.executeUpdate(deletePerfSLOs_per_tenant);
			    	System.out.println("PerfSLOs_per_tenant deleted.");
			    } catch (SQLException se) {
			    	System.out.println(se);
			    } finally {
			    	stm.close();
			    }
				
				try {
					// load data from the input file into the relation InitialTraces
					csvReader = new BufferedReader(new FileReader(tenantsFile)); // TenantId, Priority, DBSize, QueriesComplexity, ArrivalTime, NbQueries, Lamda, IdleRatio, PeakRatio, f_peak  
					
					//skip the file header
					String row = csvReader.readLine();
					while ((row = csvReader.readLine()) != null) {
					    String[] data = row.split(";");
					    // retrieve one line of the traces
					    String tenantId = "tenant" + data[0];
					    String priority = data[1];
					    String DBSize = data[2];
					    
					    // insert tuples into PerfSLOs_per_tenant
					    if(priority.equals("Basic")) {
					    	pstm = conn.prepareStatement(retrieveSLOsbyDBSize);
					    	pstm.setString(1, DBSize);
					    	ResultSet rst = pstm.executeQuery();
						    
						    while(rst.next()) {
						    	String queryId = rst.getString("queryId");
						    	long expectedExectime = rst.getLong("expectedExectime");
						    	long expectedQCT = rst.getLong("expectedQCT");
						    	long perfSLO_basic = rst.getLong("perfSLO_basic");
							    try {
							    	pstm = conn.prepareStatement(insertPerfSLOs_per_tenant);
							    	pstm.setString(1, tenantId);
							    	pstm.setString(2, queryId);
							    	pstm.setLong(3, expectedExectime);
							    	pstm.setLong(4, expectedQCT);
							    	pstm.setLong(5, perfSLO_basic);
							    	pstm.execute();
							    } catch (SQLException se) {
							    	//System.out.println(se);
							    }
							    finally {
							    	pstm.close();
							    }
						    }
						    stm.close();
						    rst.close();
					    } else if (priority.equals("Standard")) {
					    	pstm = conn.prepareStatement(retrieveSLOsbyDBSize);
					    	pstm.setString(1, DBSize);
					    	ResultSet rst = pstm.executeQuery();
						    
						    while(rst.next()) {
						    	String queryId = rst.getString("queryId");
						    	long expectedExectime = rst.getLong("expectedExectime");
						    	long expectedQCT = rst.getLong("expectedQCT");
						    	long perfSLO_standard = rst.getLong("perfSLO_standard");
							    try {
							    	pstm = conn.prepareStatement(insertPerfSLOs_per_tenant);
							    	pstm.setString(1, tenantId);
							    	pstm.setString(2, queryId);
							    	pstm.setLong(3, expectedExectime);
							    	pstm.setLong(4, expectedQCT);
							    	pstm.setLong(5, perfSLO_standard);
							    	pstm.execute();
							    } catch (SQLException se) {
							    	//System.out.println(se);
							    }
							    finally {
							    	pstm.close();
							    }
						    }
						    stm.close();
						    rst.close();
					    } else {
					    	pstm = conn.prepareStatement(retrieveSLOsbyDBSize);
					    	pstm.setString(1, DBSize);
					    	ResultSet rst = pstm.executeQuery();
						    
						    while(rst.next()) {
						    	String queryId = rst.getString("queryId");
						    	long expectedExectime = rst.getLong("expectedExectime");
						    	long expectedQCT = rst.getLong("expectedQCT");
						    	long perfSLO_premium = rst.getLong("perfSLO_premium");
							    try {
							    	pstm = conn.prepareStatement(insertPerfSLOs_per_tenant);
							    	pstm.setString(1, tenantId);
							    	pstm.setString(2, queryId);
							    	pstm.setLong(3, expectedExectime);
							    	pstm.setLong(4, expectedQCT);
							    	pstm.setLong(5, perfSLO_premium);
							    	pstm.execute();
							    } catch (SQLException se) {
							    	//System.out.println(se);
							    }
							    finally {
							    	pstm.close();
							    }
						    }
						    stm.close();
						    rst.close();
					    }					    
					}
					csvReader.close();
					System.out.println("PerfSLOs_per_tenant inserted.");
				} catch (IOException ie) {
					System.out.println(ie);
				} finally {
					conn.close();
					System.out.println("Connection closed.");
				}
	}
	
	public static void main(String[] args) throws SQLException {
		// args[0]: PerfSLOs.csv
		LoadPerfSLOs(args[0], args[1]);
		LoadPerfSLOs(args[2], args[3]);
		ComputePerfSLOs(args[4], args[5], args[6]);
		computePerfSLOs_per_tenant(args[7]);
	}
}
