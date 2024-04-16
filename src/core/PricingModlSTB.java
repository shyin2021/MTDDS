package core;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

//This is a basic version to give an example. It should be enriched before a real usage. The STBSLOs, STBTenantTier and QueryComplexity relations should be filled according to the established SLOs.
public class PricingModlSTB {
	public static void generateBills() throws SQLException {
		// Empty the Price_per_query relation
		String deleteBills = "DELETE FROM Price_per_query";
		// compute the price for each query according to the Service Tier Based SLOs
		String insertBills = "INSERT INTO Price_per_query SELECT SUTNumber, clusterSize, arrivalRateFactor, tenantName, queryName, timerName, perfSLO, FinishTime-LaunchTime, price*perfSLO*1.0/3600"
				+ " FROM FormatedTraces FT, STBSLOs STBS, STBTenantTier STBTT, QueryComplexity QC WHERE FT.tenantName=STBTT.tenantId AND FT.queryName=QC.queryId AND STBS.tierId=STBTT.tierId AND QC.queryComplexity = STBS.queryComplexity";
		// consider the penalties in case of performance SLO violation
		String updateBills = "UPDATE Price_per_query SET price_millicents = 0 - price_millicents WHERE (SUTNumber, clusterSize, arrivalRateFactor, tenantId, queryId, timerId)"
				+ " IN (SELECT SUTNumber, clusterSize, arrivalRateFactor, tenantName, queryName, timerName FROM FormatedTraces FT, STBSLOs STBS, STBTenantTier STBTT, QueryComplexity QC WHERE FT.tenantName=STBTT.tenantId AND "
				+ "FT.queryName=QC.queryId AND STBS.tierId=STBTT.tierId AND QC.queryComplexity = STBS.queryComplexity AND (FinishTime-LaunchTime)>perfSLO)";
		Statement stm = null;
		Connection conn = null;
		
		try {
			conn = DBConnect();
			
			stm = conn.createStatement();
			stm.executeUpdate(deleteBills);
			System.out.println("Tuples deleted from Price_per_query.");
			stm.executeUpdate(insertBills);
			System.out.println("Tuples inserted into Price_per_query.");
			stm.executeUpdate(updateBills);
			System.out.println("Tuples updated for queries with SLO vialations in Price_per_query.");
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
	
	public static void computeIntermediateMetrics(int SUTNumber, int clusterSize, int NbARF) throws SQLException {
		generateBills();
		PricingModelCommon.computeTotalPerTenant();
		for(int i=1; i<=NbARF; i++) {
			System.out.println("[COUNTER] SUTNumber = " + SUTNumber + ", clusterSize = " + clusterSize + ", arrivalRateFactor = " + i);
			PricingModelCommon.computeSuccesses(SUTNumber, clusterSize, i);
			PricingModelCommon.computeBenefit(SUTNumber, clusterSize, i, "STB");
		}
	} 
	
	public static void main(String[] args) throws SQLException {
		//
		computeIntermediateMetrics(Integer.parseInt(args[0]), Integer.parseInt(args[1]), Integer.parseInt(args[2]));
	}
}
