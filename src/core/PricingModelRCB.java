package core;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

// This is an instantiation of the RCB pricing model. It can be modified or extended according to the provider's exact strategy.
public class PricingModelRCB {
	public static void generateBills(int gainFactor) throws SQLException {
		// Empty the Price_per_query relation
		String deleteBills = "DELETE FROM Price_per_query";
		// compute the price for each query
		String insertBills = "INSERT INTO Price_per_query SELECT SUTNumber, clusterSize, arrivalRateFactor, tenantName, queryName, timerName, expectedExecTime, FinishTime-LaunchTime, nbNodes * (SELECT price FROM RSPrices WHERE resourceType='node')*executionTime*" + gainFactor + "*1.0/3600"
				+ " FROM FormatedTraces FT, tenants TN, DBSizesSF DS, PerfSLOs_per_Tenant PPT WHERE FT.tenantName=TN.tenantId AND TN.DBSize=DS.DBSize AND FT.queryName=PPT.queryId AND PPT.tenantId=TN.TenantID";
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
	
	public static void computeIntermediateMetrics(int SUTNumber, int clusterSize, int NbARF, int accelerationFactor, int gainFactor, boolean isolatedExecution) throws SQLException {
		generateBills(gainFactor);
		PricingModelCommon.computeTotalPerTenant();
		for(int i=1; i<=NbARF; i++) {
			System.out.println("[COUNTER] SUTNumber = " + SUTNumber + ", clusterSize = " + clusterSize + ", arrivalRateFactor = " + i*accelerationFactor);
			PricingModelCommon.computeSuccesses(SUTNumber, clusterSize, i*accelerationFactor);
			PricingModelCommon.computeBenefit(SUTNumber, clusterSize, i*accelerationFactor, "RCB", isolatedExecution);
		}
	} 
	
	public static void main(String[] args) throws SQLException {
		//
		computeIntermediateMetrics(Integer.parseInt(args[0]), Integer.parseInt(args[1]), Integer.parseInt(args[2]), Integer.parseInt(args[3]), Integer.parseInt(args[4]), Boolean.parseBoolean(args[5]));
	}
}
