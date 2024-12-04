package example;

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

import core.Metrics;

public class DataForFigures {
	
	public static void exportDataForFigure1(String directory) throws SQLException, IOException {
		String createTenantsQueries = "CREATE TABLE IF NOT EXISTS tenantQueries(TenantId number(10), QueryId number(3), ArrivalOrder number(10), ArrivalTime number(10,2), ArrivalTimeInterval number(10))";
		String deleteTenantsQueries = "DELETE FROM tenantQueries";
		String insertTenantsQueries = "INSERT INTO tenantQueries VALUES(?, ?, ?, ?, ?)";
		
		String createDataFig1 = "CREATE TABLE IF NOT EXISTS dataFig1(TimeUnit number(10), Tenant1 number(10), Tenant2 number(10), Tenant3 number(10), Tenant4 number(10), Tenant5 number(10), \r\n" +
								"Tenant6 number(10), Tenant7 number(10), Tenant8 number(10), Tenant9 number(10), Tenant10 number(10), \r\n" +
								"Tenant11 number(10), Tenant12 number(10), Tenant13 number(10), Tenant14 number(10), Tenant15 number(10), \r\n" +
								"Tenant16 number(10), Tenant17 number(10), Tenant18 number(10), Tenant19 number(10), Tenant20 number(10))";
		String deleteDataFig1 = "DELETE FROM dataFig1";
		String insertDataFig1 = "INSERT INTO dataFig1(TimeUnit) SELECT DISTINCT ArrivalTimeInterval FROM tenantQueries ORDER BY ArrivalTimeInterval";
		
		PreparedStatement pstm = null;
		Statement stm = null;
		Connection conn = null;
		BufferedReader csvReader = null;
		
		try {
			conn = DBConnect();			
			stm = conn.createStatement();
			stm.execute(createTenantsQueries);
			stm.execute(deleteTenantsQueries);
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			stm.close();
			conn.close();
		}
		
		try {
			conn = DBConnect();		
			
			// load data from the input file into the relation InitialTraces
			csvReader = new BufferedReader(new FileReader(directory + "\\20tenantsQueries\\Tenant_Queries.csv"));
			
			//skip the file header
			String row = csvReader.readLine();
			while ((row = csvReader.readLine()) != null) {
			    String[] data = row.split(";");
			    int tenantId = Integer.parseInt(data[0]);
			    int queryId = Integer.parseInt(data[1]);
			    int arrivalOrder = Integer.parseInt(data[2]);
			    double arrivalTime = Double.parseDouble(data[3].replace(",", "."));
			    int arrivalTimeInterval = Integer.parseInt(data[4]);
			    try {
			    	pstm = conn.prepareStatement(insertTenantsQueries);
			    	pstm.setInt(1, tenantId);
			    	pstm.setInt(2, queryId);
			    	pstm.setInt(3, arrivalOrder);
			    	pstm.setDouble(4, arrivalTime);
			    	pstm.setInt(5, arrivalTimeInterval);
			    	pstm.execute();
			    } catch (SQLException se) {
			    	System.out.println(se);
			    }
			    finally {
			    	pstm.close();
			    }
			}
			csvReader.close();
			System.out.println("Tenants's queries inserted.");
		} catch (IOException ie) {
			System.out.println(ie);
		} finally {
			conn.close();
//			System.out.println("Connection closed.");
		}
		
		try {
			conn = DBConnect();			
			stm = conn.createStatement();
			stm.execute(createDataFig1);
			System.out.println("dataFig1 created.");
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			stm.close();
			conn.close();
		}
		
		try {
			conn = DBConnect();			
			stm = conn.createStatement();
			stm.execute(deleteDataFig1);
			stm.execute(insertDataFig1);
			System.out.println("dataFig1 inserted.");
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			stm.close();
			conn.close();
		}
		
		try {
			conn = DBConnect();			
			stm = conn.createStatement();
			for(int i=1; i<21;i++) {
				String updateDataFig1 = "UPDATE dataFig1 SET Tenant"+i+" = (SELECT COUNT(*) FROM tenantQueries WHERE TenantId="+i+" AND ArrivalTimeInterval=dataFig1.TimeUnit) "
						+ "WHERE TimeUnit >= (SELECT MIN(ArrivalTimeInterval) FROM tenantQueries WHERE TenantId="+i+") AND TimeUnit <= (SELECT MAX(ArrivalTimeInterval) FROM tenantQueries WHERE TenantId="+i+")";
				stm.execute(updateDataFig1);
			}
			System.out.println("dataFig1 updated.");
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			stm.close();
			conn.close();
		}
		
		// export the dataFig1 relation into the output file
		FileWriter csvWriter = null;
		ResultSet rst = null;
		try {
			conn = DBConnect();			
			stm = conn.createStatement();
			try {
				csvWriter = new FileWriter(directory + "\\excelFilesforFigures\\dataFigure1.csv");
				//write the file header
				csvWriter.append("Time Unit");
				for(int i=1; i<21; i++) {
					csvWriter.append(";");
					csvWriter.append("Tenant " + i);
				}
				csvWriter.append("\n");
			} catch (IOException ie) {
				System.out.println(ie);
			}
			
			String readDataFig1 = "SELECT * FROM dataFig1";
			rst = stm.executeQuery(readDataFig1);
			// read the tuples one by one and write them into a csv file
			while(rst.next()) {
				csvWriter.append(Integer.toString(rst.getInt("TimeUnit")));
				for(int i=1; i<21; i++) {
					csvWriter.append(";");
					int count =rst.getInt("Tenant"+i);
					if(rst.wasNull()) {
						csvWriter.append("");
					} else {
						csvWriter.append(Integer.toString(count));
					}
				}
				csvWriter.append("\n");					
			}				
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			stm.close();
			rst.close();
			csvReader.close();
			csvWriter.close();
			conn.close();
			System.out.println("File dataFigure1.csv exported.");
		}					
	}

	public static void exportDataForFigure2(String directory) throws IOException, SQLException {
		// export data for Figure 2
		FileWriter csvWriter = null;
		Statement stm = null;
		Connection conn = null;
		ResultSet rst = null;
		try {
			conn = DBConnect();			
			stm = conn.createStatement();
			try {
				csvWriter = new FileWriter(directory + "\\excelFilesforFigures\\dataFigure2.csv"); 
				//write the file header
				csvWriter.append("Time Unit");
				csvWriter.append(";");
				csvWriter.append("Total number of query arrivals per time unit");
				csvWriter.append("\n");
			} catch (IOException ie) {
				System.out.println(ie);
			}
			
			String readDataFig2 = "SELECT ArrivalTimeInterval, COUNT(*) FROM tenantQueries GROUP BY ArrivalTimeInterval";
			rst = stm.executeQuery(readDataFig2);
			// read the tuples one by one and write them into a csv file
			while(rst.next()) {
				csvWriter.append(Integer.toString(rst.getInt(1)));
				csvWriter.append(";");
				int count =rst.getInt(2);
				csvWriter.append(Integer.toString(count));
				csvWriter.append("\n");					
			}				
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			stm.close();
			rst.close();
			csvWriter.close();
			conn.close();
			System.out.println("File dataFigure2.csv exported.");
		}					
	}
	
	public static void exportDataForFigure3(String directory) throws IOException, SQLException {
		// export data for Figure 3
		FileWriter csvWriter = null;
		Statement stm = null;
		Connection conn = null;
		ResultSet rst = null;
		try {
			conn = DBConnect();			
			stm = conn.createStatement();
			try {
				csvWriter = new FileWriter(directory + "\\excelFilesforFigures\\dataFigure3.csv"); 
				//write the file header
				csvWriter.append("Time Unit");
				csvWriter.append(";");
				csvWriter.append("Tenant 4");
				csvWriter.append(";");
				csvWriter.append("Tenant 8");
				csvWriter.append(";");
				csvWriter.append("Tenant 16");
				csvWriter.append("\n");	
			} catch (IOException ie) {
				System.out.println(ie);
			}
			
			String readDataFig3 = "SELECT TimeUnit, Tenant4, Tenant8, Tenant16 FROM dataFig1";
			rst = stm.executeQuery(readDataFig3);
			// read the tuples one by one and write them into a csv file
			while(rst.next()) {
				csvWriter.append(Integer.toString(rst.getInt(1)));
				for(int i=2; i<5; i++) {
					csvWriter.append(";");
					int count =rst.getInt(i);
					if(rst.wasNull()) {
						csvWriter.append("");
					} else {
						csvWriter.append(Integer.toString(count));
					}
				}
				csvWriter.append("\n");					
			}				
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			stm.close();
			rst.close();
			csvWriter.close();
			conn.close();
			System.out.println("File dataFigure3.csv exported.");
		}							
	}
	
/*	public static void exportDataForFigure6a(String directory) throws IOException, SQLException {
		// export data for Figure 6a
		FileWriter csvWriter = null;
		Statement stm = null;
		Connection conn = null;
		ResultSet rst = null;
		try {
			conn = DBConnect();			
			stm = conn.createStatement();
			try {
				csvWriter = new FileWriter(directory + "\\excelFilesforFigures\\dataFigure6a.csv"); 
				//write the file header
				for(int i=0;i<6;i++) {
					csvWriter.append("");
					csvWriter.append(";");
				}
				csvWriter.append("Launched");
				csvWriter.append(";");
				csvWriter.append("Waiting");
				csvWriter.append(";");
				csvWriter.append("Execution");
				csvWriter.append("\n");	
			} catch (IOException ie) {
				System.out.println(ie);
			}
			
			String readDataFig6a = "SELECT tenantName, queryName, timerName, launchTime, startTime, finishTime, relativeLaunchTime, waitingTime, executionTime FROM FormatedTraces "
					+ "WHERE ((timerName >= 'Timer-140' AND timerName <= 'Timer-146') OR (timerName >= 'Timer-185' AND timerName <= 'Timer-189') OR (timerName >= 'Timer-190' AND timerName <= 'Timer-194') OR (timerName >= 'Timer-221' AND timerName <= 'Timer-227')) "
					+ "AND SUTNumber=2 AND clusterSize=11 AND arrivalRateFactor=2 ORDER BY tenantName, timerName";
			rst = stm.executeQuery(readDataFig6a);
			// read the tuples one by one and write them into a csv file
			DateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
			int rowNb = 0;
			while(rst.next()) {
				rowNb++;
				if(rowNb==1 || rowNb==8  || rowNb==18) {
					csvWriter.append(rst.getString(1));
				} else {
					csvWriter.append("");
				}
				csvWriter.append(";");
				csvWriter.append(rst.getString(2));
				csvWriter.append(";");
				csvWriter.append(rst.getString(3));
				for(int i=4; i<10; i++) {
					csvWriter.append(";");
					Long time = rst.getLong(i)-3600000;
					if(time<1000) {
						time = time + 1000;
					}
					csvWriter.append(dateFormat.format(time));
				}
				csvWriter.append("\n");					
			}				
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			stm.close();
			rst.close();
			csvWriter.close();
			conn.close();
			System.out.println("File dataFigure6a.csv exported.");
		}							
	}

	public static void exportDataForFigure6b(String directory) throws IOException, SQLException {
		// export data for Figure 6b
		FileWriter csvWriter = null;
		Statement stm = null;
		Connection conn = null;
		ResultSet rst = null;
		try {
			conn = DBConnect();			
			stm = conn.createStatement();
			try {
				csvWriter = new FileWriter(directory + "\\excelFilesforFigures\\dataFigure6b.csv"); 
				//write the file header
				for(int i=0;i<6;i++) {
					csvWriter.append("");
					csvWriter.append(";");
				}
				csvWriter.append("Launched");
				csvWriter.append(";");
				csvWriter.append("Waiting");
				csvWriter.append(";");
				csvWriter.append("Execution");
				csvWriter.append("\n");	
			} catch (IOException ie) {
				System.out.println(ie);
			}
			
			String readDataFig6b = "SELECT tenantName, queryName, timerName, launchTime, startTime, finishTime, relativeLaunchTime, waitingTime, executionTime FROM FormatedTraces "
					+ "WHERE ((timerName >= 'Timer-140' AND timerName <= 'Timer-146') OR (timerName >= 'Timer-185' AND timerName <= 'Timer-189') OR (timerName >= 'Timer-190' AND timerName <= 'Timer-194') OR (timerName >= 'Timer-221' AND timerName <= 'Timer-227')) "
					+ "AND SUTNumber=2 AND clusterSize=11 AND arrivalRateFactor=10 ORDER BY tenantName, timerName";
			rst = stm.executeQuery(readDataFig6b);
			// read the tuples one by one and write them into a csv file
			DateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
			int rowNb = 0;
			while(rst.next()) {
				rowNb++;
				if(rowNb==1 || rowNb==8  || rowNb==18) {
					csvWriter.append(rst.getString(1));
				} else {
					csvWriter.append("");
				}
				csvWriter.append(";");
				csvWriter.append(rst.getString(2));
				csvWriter.append(";");
				csvWriter.append(rst.getString(3));
				for(int i=4; i<10; i++) {
					csvWriter.append(";");
					Long time = rst.getLong(i)-3600000;
					if(time<1000) {
						time = time + 1000;
					}
					csvWriter.append(dateFormat.format(time));
				}
				csvWriter.append("\n");					
			}				
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			stm.close();
			rst.close();
			csvWriter.close();
			conn.close();
			System.out.println("File dataFigure6b.csv exported.");
		}							
	}*/
	
	public static void exportDataForFigure6(String directory) throws IOException, SQLException {
		// export data for Figure 6
		FileWriter csvWriter = null;
		Statement stm = null;
		Connection conn = null;
		ResultSet rst = null;
		try {
			conn = DBConnect();			
			stm = conn.createStatement();
			try {
				csvWriter = new FileWriter(directory + "\\excelFilesforFigures\\dataFigure6.csv"); 
				//write the file header
				csvWriter.append("ARF");
				csvWriter.append("\n");
				csvWriter.append("");
				csvWriter.append(";");
				csvWriter.append("LUBF");
				csvWriter.append(";");
				csvWriter.append("SSR");
				csvWriter.append(";");
				csvWriter.append("FTS");
				csvWriter.append("\n");	
			} catch (IOException ie) {
				System.out.println(ie);
			}
			
			String readDataFig6 = "SELECT arrivalRateFactor, ROUND(UBF_centsPerHour), ROUND(satisfactionRate*100), ROUND(fairness*100) FROM Benefits WHERE SUTNumber=1 AND clusterSize=11 AND pricingModel='RCB'";
			rst = stm.executeQuery(readDataFig6);
			// read the tuples one by one and write them into a csv file
			while(rst.next()) {
				csvWriter.append(Integer.toString(rst.getInt(1)));
				csvWriter.append(";");
				csvWriter.append(Integer.toString(rst.getInt(2)));
				csvWriter.append(";");
				csvWriter.append(Integer.toString(rst.getInt(3))+"%");
				csvWriter.append(";");
				csvWriter.append(Integer.toString(rst.getInt(4))+"%");
				csvWriter.append("\n");					
			}				
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			stm.close();
			rst.close();
			csvWriter.close();
			conn.close();
			System.out.println("File dataFigure6.csv exported.");
		}									
	}
	
	public static void exportDataForFigure7(String directory) throws IOException, SQLException {
		// export data for Figure 7
		FileWriter csvWriter = null;
		Statement stm = null;
		Connection conn = null;
		ResultSet rst = null;
		try {
			conn = DBConnect();			
			stm = conn.createStatement();
			try {
				csvWriter = new FileWriter(directory + "\\excelFilesforFigures\\dataFigure7.csv"); 
				//write the file header
				csvWriter.append("ARF");
				csvWriter.append("\n");
				csvWriter.append("");
				csvWriter.append(";");
				csvWriter.append("LUBF");
				csvWriter.append(";");
				csvWriter.append("SSR");
				csvWriter.append(";");
				csvWriter.append("FTS");
				csvWriter.append("\n");	
			} catch (IOException ie) {
				System.out.println(ie);
			}
			
			String readDataFig7 = "SELECT arrivalRateFactor, ROUND(UBF_centsPerHour), ROUND(satisfactionRate*100), ROUND(fairness*100) FROM Benefits WHERE SUTNumber=2 AND clusterSize=11 AND pricingModel='RCB'";
			rst = stm.executeQuery(readDataFig7);
			// read the tuples one by one and write them into a csv file
			while(rst.next()) {
				csvWriter.append(Integer.toString(rst.getInt(1)));
				csvWriter.append(";");
				csvWriter.append(Integer.toString(rst.getInt(2)));
				csvWriter.append(";");
				csvWriter.append(Integer.toString(rst.getInt(3))+"%");
				csvWriter.append(";");
				csvWriter.append(Integer.toString(rst.getInt(4))+"%");
				csvWriter.append("\n");					
			}				
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			stm.close();
			rst.close();
			csvWriter.close();
			conn.close();
			System.out.println("File dataFigure8.csv exported.");
		}										
	}
	
	public static void exportDataForFigure8(String directory) throws IOException {
		// export data for Figure 8
		FileWriter csvWriter = null;
		try {
			try {
				csvWriter = new FileWriter(directory + "\\excelFilesforFigures\\dataFigure8.csv"); 
				//write the file header
				csvWriter.append("");
				csvWriter.append(";");
				csvWriter.append("ARF");
				csvWriter.append(";");
				csvWriter.append("UBF");
				csvWriter.append(";");
				csvWriter.append("SSR");
				csvWriter.append(";");
				csvWriter.append("FTS");
				csvWriter.append(";");
				csvWriter.append("TPAT");
				csvWriter.append("\n");	
			} catch (IOException ie) {
				System.out.println(ie);
			}
			
			// SUT1
			int HARF = Metrics.getPO_Metric1Bis_HARF(1, "RCB", 11, 0.7);
			double SSR = Metrics.getTO_Metric1_SSR(1, "RCB", 11, HARF);
			double FTS = Metrics.getTO_Metric2_FTS(1, "RCB", 11, HARF);
			double TPAT = Metrics.getTO_Metric3_TPAT(1, "RCB", 11, HARF);
			double LUBF = Metrics.getLUBF(1, "RCB", 11, HARF);

			csvWriter.append("SUT1");
			csvWriter.append(";");
			csvWriter.append(Integer.toString(HARF));
			csvWriter.append(";");
			csvWriter.append(Double.toString(LUBF).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(SSR).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(FTS).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(TPAT).replace(".", ","));
			csvWriter.append("\n");	
			
			// SUT2
			HARF = Metrics.getPO_Metric1Bis_HARF(2, "RCB", 11, 0.7);
			SSR = Metrics.getTO_Metric1_SSR(2, "RCB", 11, HARF);
			FTS = Metrics.getTO_Metric2_FTS(2, "RCB", 11, HARF);
			TPAT = Metrics.getTO_Metric3_TPAT(2, "RCB", 11, HARF);
			LUBF = Metrics.getLUBF(2, "RCB", 11, HARF);

			csvWriter.append("SUT2-HARF");
			csvWriter.append(";");
			csvWriter.append(Integer.toString(HARF));
			csvWriter.append(";");
			csvWriter.append(Double.toString(LUBF).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(SSR).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(FTS).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(TPAT).replace(".", ","));
			csvWriter.append("\n");		
			
			// SUT2
			int OARF = Metrics.getPO_Metric2Bis_OARF(2, "RCB", 11, 0.7);
			SSR = Metrics.getTO_Metric1_SSR(2, "RCB", 11, OARF);
			FTS = Metrics.getTO_Metric2_FTS(2, "RCB", 11, OARF);
			TPAT = Metrics.getTO_Metric3_TPAT(2, "RCB", 11, OARF);
			LUBF = Metrics.getLUBF(2, "RCB", 11, OARF);

			csvWriter.append("SUT2-OARF");
			csvWriter.append(";");
			csvWriter.append(Integer.toString(OARF));
			csvWriter.append(";");
			csvWriter.append(Double.toString(LUBF).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(SSR).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(FTS).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(TPAT).replace(".", ","));
			csvWriter.append("\n");	
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			csvWriter.close();
			System.out.println("File dataFigure8.csv exported.");
		}												
	}	
	
	public static void exportDataForFigure9(String directory) throws IOException, SQLException {
		// export data for Figure 9
		FileWriter csvWriter = null;
		Statement stm = null;
		Connection conn = null;
		ResultSet rst = null;
		try {
			conn = DBConnect();			
			stm = conn.createStatement();
			try {
				csvWriter = new FileWriter(directory + "\\excelFilesforFigures\\dataFigure9.csv"); 
				//write the file header
				csvWriter.append("ARF");
				csvWriter.append("\n");
				csvWriter.append("");
				csvWriter.append(";");
				csvWriter.append("LUBF");
				csvWriter.append(";");
				csvWriter.append("SSR");
				csvWriter.append(";");
				csvWriter.append("TPAT");
				csvWriter.append("\n");	
			} catch (IOException ie) {
				System.out.println(ie);
			}
			
			String readDataFig9 = "SELECT arrivalRateFactor, ROUND(UBF_centsPerHour), ROUND(satisfactionRate*100), ROUND(tpat) FROM Benefits WHERE SUTNumber=2 AND clusterSize=11 AND pricingModel='RCB'";
			rst = stm.executeQuery(readDataFig9);
			// read the tuples one by one and write them into a csv file
			while(rst.next()) {
				csvWriter.append(Integer.toString(rst.getInt(1)));
				csvWriter.append(";");
				csvWriter.append(Integer.toString(rst.getInt(2)));
				csvWriter.append(";");
				csvWriter.append(Integer.toString(rst.getInt(3))+"%");
				csvWriter.append(";");
				csvWriter.append(Integer.toString(rst.getInt(4)));
				csvWriter.append("\n");					
			}				
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			stm.close();
			rst.close();
			csvWriter.close();
			conn.close();
			System.out.println("File dataFigure9.csv exported.");
		}												
	}
	
	public static void exportDataForFigure10(String directory) throws IOException, SQLException {
		// export data for Figure 10
		FileWriter csvWriter = null;
		Statement stm = null;
		Connection conn = null;
		ResultSet rst = null;
		try {
			conn = DBConnect();			
			stm = conn.createStatement();
			try {
				csvWriter = new FileWriter(directory + "\\excelFilesforFigures\\dataFigure10.csv"); 
				//write the file header
				csvWriter.append("ARF");
				csvWriter.append("\n");
				csvWriter.append("");
				csvWriter.append(";");
				csvWriter.append("LUBF");
				csvWriter.append(";");
				csvWriter.append("SSR");
				csvWriter.append(";");
				csvWriter.append("TPAT");
				csvWriter.append("\n");	
			} catch (IOException ie) {
				System.out.println(ie);
			}
			
			String readDataFig10 = "SELECT arrivalRateFactor, ROUND(UBF_centsPerHour), ROUND(satisfactionRate*100), ROUND(tpat) FROM Benefits WHERE SUTNumber=2 AND clusterSize=11 AND pricingModel='QLSA'";
			rst = stm.executeQuery(readDataFig10);
			// read the tuples one by one and write them into a csv file
			while(rst.next()) {
				csvWriter.append(Integer.toString(rst.getInt(1)));
				csvWriter.append(";");
				csvWriter.append(Integer.toString(rst.getInt(2)));
				csvWriter.append(";");
				csvWriter.append(Integer.toString(rst.getInt(3))+"%");
				csvWriter.append(";");
				csvWriter.append(Integer.toString(rst.getInt(4)));
				csvWriter.append("\n");					
			}				
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			stm.close();
			rst.close();
			csvWriter.close();
			conn.close();
			System.out.println("File dataFigure10.csv exported.");
		}														
	}
	
	public static void exportDataForFigure11(String directory) throws IOException, SQLException {
		// export data for Figure 11
		FileWriter csvWriter = null;
		Statement stm = null;
		Connection conn = null;
		ResultSet rst = null;
		try {
			conn = DBConnect();			
			stm = conn.createStatement();
			try {
				csvWriter = new FileWriter(directory + "\\excelFilesforFigures\\dataFigure11.csv"); 
				//write the file header
				csvWriter.append("ARF");
				csvWriter.append("\n");
				csvWriter.append("");
				csvWriter.append(";");
				csvWriter.append("LUBF");
				csvWriter.append(";");
				csvWriter.append("SSR");
				csvWriter.append(";");
				csvWriter.append("FTS");
				csvWriter.append("\n");	
			} catch (IOException ie) {
				System.out.println(ie);
			}
			
			String readDataFig11 = "SELECT arrivalRateFactor, ROUND(UBF_centsPerHour), ROUND(satisfactionRate*100), ROUND(fairness*100) FROM Benefits WHERE SUTNumber=2 AND clusterSize=11 AND pricingModel='QLSA'";
			rst = stm.executeQuery(readDataFig11);
			// read the tuples one by one and write them into a csv file
			while(rst.next()) {
				csvWriter.append(Integer.toString(rst.getInt(1)));
				csvWriter.append(";");
				csvWriter.append(Integer.toString(rst.getInt(2)));
				csvWriter.append(";");
				csvWriter.append(Integer.toString(rst.getInt(3))+"%");
				csvWriter.append(";");
				csvWriter.append(Integer.toString(rst.getInt(4))+"%");
				csvWriter.append("\n");					
			}				
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			stm.close();
			rst.close();
			csvWriter.close();
			conn.close();
			System.out.println("File dataFigure11.csv exported.");
		}								
	}
	
	public static void exportDataForFigure12(String directory) throws IOException {
		// export data for Figure 12
		FileWriter csvWriter = null;
		try {
			try {
				csvWriter = new FileWriter(directory + "\\excelFilesforFigures\\dataFigure12.csv"); 
				//write the file header
				csvWriter.append("");
				csvWriter.append(";");
				csvWriter.append("ARF");
				csvWriter.append(";");
				csvWriter.append("UBF");
				csvWriter.append(";");
				csvWriter.append("SSR");
				csvWriter.append(";");
				csvWriter.append("FTS");
				csvWriter.append(";");
				csvWriter.append("TPAT");
				csvWriter.append("\n");	
			} catch (IOException ie) {
				System.out.println(ie);
			}
			
			// SUT1 HARF/OARF
			int HARF = Metrics.getPO_Metric1Bis_HARF(1, "QLSA", 11, 0.7);
			double SSR = Metrics.getTO_Metric1_SSR(1, "QLSA", 11, HARF);
			double FTS = Metrics.getTO_Metric2_FTS(1, "QLSA", 11, HARF);
			double TPAT = Metrics.getTO_Metric3_TPAT(1, "QLSA", 11, HARF);
			double LUBF = Metrics.getLUBF(1, "QLSA", 11, HARF);

			csvWriter.append("SUT1-HARF/OARF");
			csvWriter.append(";");
			csvWriter.append(Integer.toString(HARF));
			csvWriter.append(";");
			csvWriter.append(Double.toString(LUBF).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(SSR).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(FTS).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(TPAT).replace(".", ","));
			csvWriter.append("\n");	
			
			// SUT2 HARF
			HARF = Metrics.getPO_Metric1Bis_HARF(2, "QLSA", 11, 0.7);
			SSR = Metrics.getTO_Metric1_SSR(2, "QLSA", 11, HARF);
			FTS = Metrics.getTO_Metric2_FTS(2, "QLSA", 11, HARF);
			TPAT = Metrics.getTO_Metric3_TPAT(2, "QLSA", 11, HARF);
			LUBF = Metrics.getLUBF(2, "QLSA", 11, HARF);

			csvWriter.append("SUT2-HARF");
			csvWriter.append(";");
			csvWriter.append(Integer.toString(HARF));
			csvWriter.append(";");
			csvWriter.append(Double.toString(LUBF).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(SSR).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(FTS).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(TPAT).replace(".", ","));
			csvWriter.append("\n");
			
			// SUT2 OARF
			int OARF = Metrics.getPO_Metric2Bis_OARF(2, "QLSA", 11, 0.7);
			SSR = Metrics.getTO_Metric1_SSR(2, "QLSA", 11, OARF);
			FTS = Metrics.getTO_Metric2_FTS(2, "QLSA", 11, OARF);
			TPAT = Metrics.getTO_Metric3_TPAT(2, "QLSA", 11, OARF);
			LUBF = Metrics.getLUBF(2, "QLSA", 11, OARF);

			csvWriter.append("SUT2-OARF");
			csvWriter.append(";");
			csvWriter.append(Integer.toString(OARF));
			csvWriter.append(";");
			csvWriter.append(Double.toString(LUBF).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(SSR).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(FTS).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(TPAT).replace(".", ","));
			csvWriter.append("\n");		
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			csvWriter.close();
			System.out.println("File dataFigure13.csv exported.");
		}													
	}

	public static void exportDataForFigure13(String directory) throws IOException {
		// export data for Figure 13
		FileWriter csvWriter = null;
		try {
			try {
				csvWriter = new FileWriter(directory + "\\excelFilesforFigures\\dataFigure13.csv"); 
				//write the file header
				csvWriter.append("");
				csvWriter.append(";");
				csvWriter.append("ARF");
				csvWriter.append(";");
				csvWriter.append("UBF");
				csvWriter.append(";");
				csvWriter.append("SSR");
				csvWriter.append(";");
				csvWriter.append("FTS");
				csvWriter.append(";");
				csvWriter.append("TPAT");
				csvWriter.append("\n");	
			} catch (IOException ie) {
				System.out.println(ie);
			}
			
			// SUT2 OARF
			int HARF = Metrics.getPO_Metric2Bis_OARF(2, "QLSA", 11, 0.7);
			double SSR = Metrics.getTO_Metric1_SSR(2, "QLSA", 11, HARF);
			double FTS = Metrics.getTO_Metric2_FTS(2, "QLSA", 11, HARF);
			double TPAT = Metrics.getTO_Metric3_TPAT(2, "QLSA", 11, HARF);
			double LUBF = Metrics.getLUBF(2, "QLSA", 11, HARF);

			csvWriter.append("SUT2b-OARF");
			csvWriter.append(";");
			csvWriter.append(Integer.toString(HARF));
			csvWriter.append(";");
			csvWriter.append(Double.toString(LUBF).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(SSR).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(FTS).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(TPAT).replace(".", ","));
			csvWriter.append("\n");	
			
			// SUT3 HARF
			HARF = Metrics.getPO_Metric1Bis_HARF(3, "QLSA", 11, 0.7);
			SSR = Metrics.getTO_Metric1_SSR(3, "QLSA", 11, HARF);
			FTS = Metrics.getTO_Metric2_FTS(3, "QLSA", 11, HARF);
			TPAT = Metrics.getTO_Metric3_TPAT(3, "QLSA", 11, HARF);
			LUBF = Metrics.getLUBF(3, "QLSA", 11, HARF);

			csvWriter.append("SUT3-HARF");
			csvWriter.append(";");
			csvWriter.append(Integer.toString(HARF));
			csvWriter.append(";");
			csvWriter.append(Double.toString(LUBF).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(SSR).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(FTS).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(TPAT).replace(".", ","));
			csvWriter.append("\n");
			
			// SUT3 OARF
			int OARF = Metrics.getPO_Metric2Bis_OARF(3, "QLSA", 11, 0.7);
			SSR = Metrics.getTO_Metric1_SSR(3, "QLSA", 11, OARF);
			FTS = Metrics.getTO_Metric2_FTS(3, "QLSA", 11, OARF);
			TPAT = Metrics.getTO_Metric3_TPAT(3, "QLSA", 11, OARF);
			LUBF = Metrics.getLUBF(3, "QLSA", 11, OARF);

			csvWriter.append("SUT3-OARF");
			csvWriter.append(";");
			csvWriter.append(Integer.toString(OARF));
			csvWriter.append(";");
			csvWriter.append(Double.toString(LUBF).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(SSR).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(FTS).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(TPAT).replace(".", ","));
			csvWriter.append("\n");		
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			csvWriter.close();
			System.out.println("File dataFigure13.csv exported.");
		}													
	}
	
	public static void exportDataForFigure14(String directory) throws IOException {
		// export data for Figure 14
		FileWriter csvWriter = null;
		try {
			try {
				csvWriter = new FileWriter(directory + "\\excelFilesforFigures\\dataFigure14.csv"); 
				//write the file header
				csvWriter.append("");
				csvWriter.append(";");
				csvWriter.append("ARF");
				csvWriter.append(";");
				csvWriter.append("UBF");
				csvWriter.append(";");
				csvWriter.append("SSR");
				csvWriter.append(";");
				csvWriter.append("FTS");
				csvWriter.append(";");
				csvWriter.append("TPAT");
				csvWriter.append("\n");	
			} catch (IOException ie) {
				System.out.println(ie);
			}
			
			// SUT2 OARF
			int HARF = Metrics.getPO_Metric2Bis_OARF(2, "QLSA", 11, 0.7);
			double SSR = Metrics.getTO_Metric1_SSR(2, "QLSA", 11, HARF);
			double FTS = Metrics.getTO_Metric2_FTS(2, "QLSA", 11, HARF);
			double TPAT = Metrics.getTO_Metric3_TPAT(2, "QLSA", 11, HARF);
			double LUBF = Metrics.getLUBF(2, "QLSA", 11, HARF);

			csvWriter.append("SUT2b+-OARF");
			csvWriter.append(";");
			csvWriter.append(Integer.toString(HARF));
			csvWriter.append(";");
			csvWriter.append(Double.toString(LUBF).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(SSR).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(FTS).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(TPAT).replace(".", ","));
			csvWriter.append("\n");	
			
			// SUT3 HARF
			HARF = Metrics.getPO_Metric1Bis_HARF(3, "QLSA", 11, 0.7);
			SSR = Metrics.getTO_Metric1_SSR(3, "QLSA", 11, HARF);
			FTS = Metrics.getTO_Metric2_FTS(3, "QLSA", 11, HARF);
			TPAT = Metrics.getTO_Metric3_TPAT(3, "QLSA", 11, HARF);
			LUBF = Metrics.getLUBF(3, "QLSA", 11, HARF);

			csvWriter.append("SUT3-HARF");
			csvWriter.append(";");
			csvWriter.append(Integer.toString(HARF));
			csvWriter.append(";");
			csvWriter.append(Double.toString(LUBF).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(SSR).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(FTS).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(TPAT).replace(".", ","));
			csvWriter.append("\n");
			
			// SUT3 OARF
			int OARF = Metrics.getPO_Metric2Bis_OARF(3, "QLSA", 11, 0.7);
			SSR = Metrics.getTO_Metric1_SSR(3, "QLSA", 11, OARF);
			FTS = Metrics.getTO_Metric2_FTS(3, "QLSA", 11, OARF);
			TPAT = Metrics.getTO_Metric3_TPAT(3, "QLSA", 11, OARF);
			LUBF = Metrics.getLUBF(3, "QLSA", 11, OARF);

			csvWriter.append("SUT3-OARF");
			csvWriter.append(";");
			csvWriter.append(Integer.toString(OARF));
			csvWriter.append(";");
			csvWriter.append(Double.toString(LUBF).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(SSR).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(FTS).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(TPAT).replace(".", ","));
			csvWriter.append("\n");		
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			csvWriter.close();
			System.out.println("File dataFigure14.csv exported.");
		}													
	}
	
	public static void exportDataForFigure15(String directory) throws IOException {
		// export data for Figure 15
		FileWriter csvWriter = null;
		try {
			try {
				csvWriter = new FileWriter(directory + "\\excelFilesforFigures\\dataFigure15.csv"); 
				//write the file header
				csvWriter.append("");
				csvWriter.append(";");
				csvWriter.append("ARF");
				csvWriter.append(";");
				csvWriter.append("UBF");
				csvWriter.append(";");
				csvWriter.append("SSR");
				csvWriter.append(";");
				csvWriter.append("FTS");
				csvWriter.append(";");
				csvWriter.append("TPAT");
				csvWriter.append("\n");	
			} catch (IOException ie) {
				System.out.println(ie);
			}
			
			// SUT3a OARF
			int HARF = Metrics.getPO_Metric2Bis_OARF(3, "RCB", 11, 0.7);
			double SSR = Metrics.getTO_Metric1_SSR(3, "RCB", 11, HARF);
			double FTS = Metrics.getTO_Metric2_FTS(3, "RCB", 11, HARF);
			double TPAT = Metrics.getTO_Metric3_TPAT(3, "RCB", 11, HARF);
			double LUBF = Metrics.getLUBF(3, "RCB", 11, HARF);

			csvWriter.append("SUT3a-OARF");
			csvWriter.append(";");
			csvWriter.append(Integer.toString(HARF));
			csvWriter.append(";");
			csvWriter.append(Double.toString(LUBF).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(SSR).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(FTS).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(TPAT).replace(".", ","));
			csvWriter.append("\n");	
			
			// SUT3a HARF
			HARF = Metrics.getPO_Metric1Bis_HARF(3, "RCB", 11, 0.7);
			SSR = Metrics.getTO_Metric1_SSR(3, "RCB", 11, HARF);
			FTS = Metrics.getTO_Metric2_FTS(3, "RCB", 11, HARF);
			TPAT = Metrics.getTO_Metric3_TPAT(3, "RCB", 11, HARF);
			LUBF = Metrics.getLUBF(3, "RCB", 11, HARF);

			csvWriter.append("SUT3a-HARF");
			csvWriter.append(";");
			csvWriter.append(Integer.toString(HARF));
			csvWriter.append(";");
			csvWriter.append(Double.toString(LUBF).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(SSR).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(FTS).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(TPAT).replace(".", ","));
			csvWriter.append("\n");
			
			// SUT4a OARF
			int OARF = Metrics.getPO_Metric2Bis_OARF(4, "RCB", 11, 0.7);
			SSR = Metrics.getTO_Metric1_SSR(4, "RCB", 11, OARF);
			FTS = Metrics.getTO_Metric2_FTS(4, "RCB", 11, OARF);
			TPAT = Metrics.getTO_Metric3_TPAT(4, "RCB", 11, OARF);
			LUBF = Metrics.getLUBF(4, "RCB", 11, OARF);

			csvWriter.append("SUT4a-OARF");
			csvWriter.append(";");
			csvWriter.append(Integer.toString(OARF));
			csvWriter.append(";");
			csvWriter.append(Double.toString(LUBF).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(SSR).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(FTS).replace(".", ","));
			csvWriter.append(";");
			csvWriter.append(Double.toString(TPAT).replace(".", ","));
			csvWriter.append("\n");		
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			csvWriter.close();
			System.out.println("File dataFigure15.csv exported.");
		}													
	}
	
	public static void exportDataForAllFigure_to_12(String directory) throws SQLException, IOException {
		exportDataForFigure1("files");
		exportDataForFigure2("files");
		exportDataForFigure3("files");
		exportDataForFigure7("files");
		exportDataForFigure8("files");
		exportDataForFigure9("files");
		exportDataForFigure10("files");
		exportDataForFigure11("files");
		exportDataForFigure12("files");
	}
	
	// connection to a DBMS
	static Connection DBConnect() throws SQLException{
		Connection conn = null;
        try {
            // db parameters
            String url = "jdbc:sqlite:mtdds.db";
            // create a connection to the database
            conn = DriverManager.getConnection(url);
            
//            System.out.println("Connection to SQLite has been established.");
            
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } 
        
        return conn;	
    }
	
	public static void main(String[] args) throws SQLException, IOException {
		exportDataForFigure10("files");
	}
}
