package tools;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class TenantsLoader {
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
	
	public static void loadTenants(String tenantsFile) throws SQLException {
		BufferedReader csvReader;
		String deleteTenants = "DELETE FROM tenants";
		String insertTenants = "INSERT INTO tenants VALUES(?, ?, ?)"; //TenantId, DBSize, Priority
		
		Statement stm = null;
		PreparedStatement pstm = null;
		
		// Connection
		Connection conn = DBConnect();
		try {
	    	stm = conn.createStatement();
	    	stm.executeUpdate(deleteTenants);
	    	System.out.println("Tenants deleted.");
	    } catch (SQLException se) {
	    	System.out.println(se);
	    } finally {
	    	stm.close();
	    }
		
		try {
			// load data from the input file into the relation InitialTraces
			csvReader = new BufferedReader(new FileReader(tenantsFile)); // TenantId, ArrivalTime, NbQueries, Lamda, IdleRatio, PeakRatio, f_peak, DBSize, QueriesComplexity, Priority
			
			//skip the file header
			String row = csvReader.readLine();
			while ((row = csvReader.readLine()) != null) {
			    String[] data = row.split(";");
			    String tenantId = "tenant" + data[0];
			    String DBSize = data[2];
			    String Priority = data[1];
			    try {
			    	pstm = conn.prepareStatement(insertTenants);
			    	pstm.setString(1, tenantId);
			    	pstm.setString(2, DBSize);
			    	pstm.setString(3, Priority);
			    	pstm.execute();
			    } catch (SQLException se) {
			    	System.out.println(se);
			    }
			    finally {
			    	pstm.close();
			    }
			}
			csvReader.close();
			System.out.println("Tenants inserted.");
		} catch (IOException ie) {
			System.out.println(ie);
		} finally {
			conn.close();
			System.out.println("Connection closed.");
		}
	}
	
	public static void main(String[] args) throws SQLException {
		//
		loadTenants(args[0]);
	}
}
