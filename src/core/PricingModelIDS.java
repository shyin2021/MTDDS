package core;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

// This is a basic version to give an example. It should be enriched before a real usage. The IDSTraces relation should be filled using real traces.
public class PricingModelIDS {
	private static final int price_per_GB = 5; // 5 cents per Gigabyte: should be replaced by the real value
	public static void generateBills() throws SQLException {
		// Empty the Price_per_query relation
		String deleteBills = "DELETE FROM Price_per_query";
		// compute the price for each query
		String insertBills = "INSERT INTO Price_per_query SELECT SUTNumber, clusterSize, arrivalRateFactor, tenantName, queryName, timerName, NULL, NULL, totalInputDataSize*" + price_per_GB
				+ " FROM IDSTraces";
		Statement stm = null;
		Connection conn = null;
		
		try {
			conn = DBConnect();
			
			stm = conn.createStatement();
			stm.executeUpdate(deleteBills);
			System.out.println("Tuples deleted from Price_per_query.");
			stm.executeUpdate(insertBills);
			System.out.println("Tuples inserted into Price_per_query.");
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			stm.close();
			conn.close();
			System.out.println("Connection closed.");
		}
	};
	
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
	
	public static void computeIntermediateMetrics(int SUTNumber, int clusterSize, int NbARF, int accelerationFactor, boolean isolatedExecution) throws SQLException {
		generateBills();
		PricingModelCommon.computeTotalPerTenant();
		for(int i=1; i<=NbARF; i++) {
			System.out.println("[COUNTER] SUTNumber = " + SUTNumber + ", clusterSize = " + clusterSize + ", arrivalRateFactor = " + i*accelerationFactor);
			PricingModelCommon.computeSuccesses(SUTNumber, clusterSize, i*accelerationFactor);
			PricingModelCommon.computeBenefit(SUTNumber, clusterSize, i*accelerationFactor, "IDS", isolatedExecution);
		}
	} 
	
	public static void main(String[] args) throws SQLException {
		//
		computeIntermediateMetrics(Integer.parseInt(args[0]), Integer.parseInt(args[1]), Integer.parseInt(args[2]), Integer.parseInt(args[3]), Boolean.parseBoolean(args[4]));
	}
}
