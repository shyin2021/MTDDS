package tools;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class InputFilesLoader {
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
	
	public static void loadRSPrices(String RSPricesFile) throws SQLException {
		BufferedReader csvReader;
		String deleteRSPrices = "DELETE FROM RSPrices";
		String insertRSPrices = "INSERT INTO RSPrices VALUES(?, ?, ?)"; // resourceType, price, unit
		
		Statement stm = null;
		PreparedStatement pstm = null;
		
		// Connection
		Connection conn = DBConnect();
		try {
	    	stm = conn.createStatement();
	    	stm.executeUpdate(deleteRSPrices);
	    	System.out.println("RSPrices deleted.");
	    } catch (SQLException se) {
	    	System.out.println(se);
	    } finally {
	    	stm.close();
	    }
		
		try {
			// load data from the input file into the relation InitialTraces
			csvReader = new BufferedReader(new FileReader(RSPricesFile)); // resourceType, price, unit
			
			//skip the file header
			String row = csvReader.readLine();
			while ((row = csvReader.readLine()) != null) {
			    String[] data = row.split(";");
			    String resourceType = data[0];
			    int price = Integer.parseInt(data[1]);
			    String unit = data[2];
			    try {
			    	pstm = conn.prepareStatement(insertRSPrices);
			    	pstm.setString(1, resourceType);
			    	pstm.setInt(2, price);
			    	pstm.setString(3, unit);
			    	pstm.execute();
			    } catch (SQLException se) {
			    	System.out.println(se);
			    }
			    finally {
			    	pstm.close();
			    }
			}
			csvReader.close();
			System.out.println("RSPrices inserted.");
		} catch (IOException ie) {
			System.out.println(ie);
		} finally {
			conn.close();
			System.out.println("Connection closed.");
		}
	}
	
	public static void loadDBSizesSF(String DBSizesSFFile) throws SQLException {
		BufferedReader csvReader;
		String deleteDBSizesSF = "DELETE FROM DBSizesSF";
		String insertDBSizesSF = "INSERT INTO DBSizesSF VALUES(?, ?)"; // DBSize, scaleFactor
		
		Statement stm = null;
		PreparedStatement pstm = null;
		
		// Connection
		Connection conn = DBConnect();
		try {
	    	stm = conn.createStatement();
	    	stm.executeUpdate(deleteDBSizesSF);
	    	System.out.println("DBSizesSF deleted.");
	    } catch (SQLException se) {
	    	System.out.println(se);
	    } finally {
	    	stm.close();
	    }
		
		try {
			// load data from the input file into the relation DBSizesSF
			csvReader = new BufferedReader(new FileReader(DBSizesSFFile)); // DBSize, scaleFactor
			
			//skip the file header
			String row = csvReader.readLine();
			while ((row = csvReader.readLine()) != null) {
			    String[] data = row.split(";");
			    String DBSize = data[0];
			    int scaleFactor = Integer.parseInt(data[1]);
			    try {
			    	pstm = conn.prepareStatement(insertDBSizesSF);
			    	pstm.setString(1, DBSize);
			    	pstm.setInt(2, scaleFactor);
			    	pstm.execute();
			    } catch (SQLException se) {
			    	System.out.println(se);
			    }
			    finally {
			    	pstm.close();
			    }
			}
			csvReader.close();
			System.out.println("DBSizesSF inserted.");
		} catch (IOException ie) {
			System.out.println(ie);
		} finally {
			conn.close();
			System.out.println("Connection closed.");
		}
	}
	
	public static void loadPriorityTRT(String PriorityTRTFile) throws SQLException {
		BufferedReader csvReader;
		String deletePriorityTRT = "DELETE FROM PriorityTRT";
		String insertPriorityTRT = "INSERT INTO PriorityTRT VALUES(?, ?)"; // Priority, TRT (tolerance rate threshold )
		
		Statement stm = null;
		PreparedStatement pstm = null;
		
		// Connection
		Connection conn = DBConnect();
		try {
	    	stm = conn.createStatement();
	    	stm.executeUpdate(deletePriorityTRT);
	    	System.out.println("PriorityTRT deleted.");
	    } catch (SQLException se) {
	    	System.out.println(se);
	    } finally {
	    	stm.close();
	    }
		
		try {
			// load data from the input file into the relation PriorityTRT
			csvReader = new BufferedReader(new FileReader(PriorityTRTFile)); // Priority, TRT
			
			//skip the file header
			String row = csvReader.readLine();
			while ((row = csvReader.readLine()) != null) {
			    String[] data = row.split(";");
			    String Priority = data[0];
			    double TRT = Double.parseDouble(data[1]);
			    try {
			    	pstm = conn.prepareStatement(insertPriorityTRT);
			    	pstm.setString(1, Priority);
			    	pstm.setDouble(2, TRT);
			    	pstm.execute();
			    } catch (SQLException se) {
			    	System.out.println(se);
			    }
			    finally {
			    	pstm.close();
			    }
			}
			csvReader.close();
			System.out.println("PriorityTRT inserted.");
		} catch (IOException ie) {
			System.out.println(ie);
		} finally {
			conn.close();
			System.out.println("Connection closed.");
		}
	}
	
	public static void main(String[] args) throws SQLException {
		loadRSPrices(args[0]);
		loadDBSizesSF(args[1]);
		loadPriorityTRT(args[2]);
	}
}
