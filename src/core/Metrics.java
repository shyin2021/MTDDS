package core;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Metrics {
	
	// TO_Metric 1: SSR (SLO Satisfaction Rate), which is the percentage of the number of queries that have been successfully executed over the total number of queries.  
	public static double getTO_Metric1_SSR(int SUTNumber, String pricingModel, int clusterSize, int arrivalRateFactor) throws SQLException{
		double SSR;
		String getSSR = "SELECT satisfactionRate FROM benefits WHERE SUTNumber = ? AND pricingModel = ? and clusterSize = ? AND arrivalRateFactor = ?";
		
		Connection conn = DBConnect();
		
		PreparedStatement pstm = conn.prepareStatement(getSSR);
		pstm.setInt(1, SUTNumber);
		pstm.setString(2, pricingModel);
		pstm.setInt(3, clusterSize);
		pstm.setInt(4, arrivalRateFactor);
		ResultSet rs = pstm.executeQuery();
		
		rs.next();
		SSR = rs.getDouble(1);
		
		rs.close();
		pstm.close();
		conn.close();
		
		return SSR;
	}
	
	// TO_Metric 2: FTS (Fairness between the Tenants’ Satisfaction rates).
	public static double getTO_Metric2_FTS(int SUTNumber, String pricingModel, int clusterSize, int arrivalRateFactor) throws SQLException{
		double FTS;
		String getSSR = "SELECT fairness FROM benefits WHERE SUTNumber = ? AND pricingModel = ? and clusterSize = ? AND arrivalRateFactor = ?";
		
		Connection conn = DBConnect();
		
		PreparedStatement pstm = conn.prepareStatement(getSSR);
		pstm.setInt(1, SUTNumber);
		pstm.setString(2, pricingModel);
		pstm.setInt(3, clusterSize);
		pstm.setInt(4, arrivalRateFactor);
		ResultSet rs = pstm.executeQuery();
		
		rs.next();
		FTS = rs.getDouble(1);
		
		rs.close();
		pstm.close();
		conn.close();
		
		return FTS;
	}
	
	// TO_Metric 3: TPAT (Total Payment of All Tenants), which is simply the sum of the bills of all tenants.
	public static double getTO_Metric3_TPAT(int SUTNumber, String pricingModel, int clusterSize, int arrivalRateFactor) throws SQLException{
		double TPAT;
		String getTPAT = "SELECT tpat FROM benefits WHERE SUTNumber = ? AND pricingModel = ? and clusterSize = ? AND arrivalRateFactor = ?";
		
		Connection conn = DBConnect();
		
		PreparedStatement pstm = conn.prepareStatement(getTPAT);
		pstm.setInt(1, SUTNumber);
		pstm.setString(2, pricingModel);
		pstm.setInt(3, clusterSize);
		pstm.setInt(4, arrivalRateFactor);
		ResultSet rs = pstm.executeQuery();
		
		rs.next();
		TPAT = rs.getDouble(1);
		
		rs.close();
		pstm.close();
		conn.close();
		
		return TPAT;
	}
	
	// PO_Metric 1: MNN (Minimum Number of Nodes required before a system saturation) under the reference query arrival time
	public static int getPO_Metric1_MNN(int SUTNumber, String pricingModel, int arrivalRateFactor, double SSR_min) throws SQLException{
		int MNN;
		String getMNN = "SELECT MIN(clusterSize) FROM benefits WHERE SUTNumber = ? AND pricingModel = ? AND arrivalRateFactor = ? AND benefit > 0 AND satisfactionRate > ?";

		Connection conn = DBConnect();
		
		PreparedStatement pstm = conn.prepareStatement(getMNN);
		pstm.setInt(1, SUTNumber);
		pstm.setString(2, pricingModel);
		pstm.setInt(3, arrivalRateFactor);
		pstm.setDouble(4, SSR_min);
		ResultSet rs = pstm.executeQuery();
		
		rs.next();
		MNN = rs.getInt(1);
		
		rs.close();
		pstm.close();
		conn.close();
		
		
		return MNN;	
	}
	
	// PO_Metric 1 Bis: HARF (Highest Arrival Rate Factor before a system saturation) under the reference number of nodes.
	public static int getPO_Metric1Bis_HARF(int SUTNumber, String pricingModel, int clusterSize, double SSR_min) throws SQLException{
			int HARF;
			String getHARF = "SELECT MAX(arrivalRateFactor) FROM benefits WHERE SUTNumber = ? AND pricingModel = ? AND clusterSize = ? AND benefit > 0 AND satisfactionRate > ?";

			Connection conn = DBConnect();
			
			PreparedStatement pstm = conn.prepareStatement(getHARF);
			pstm.setInt(1, SUTNumber);
			pstm.setString(2, pricingModel);
			pstm.setInt(3, clusterSize);
			pstm.setDouble(4, SSR_min);
			ResultSet rs = pstm.executeQuery();
			
			rs.next();
			HARF = rs.getInt(1);
			
			rs.close();
			pstm.close();
			conn.close();
			
			
			return HARF;	
	}

	// PO_Metric 2: ONN (Optimal Number of Nodes) which gives the highest LUBF under the reference query arrival rate (if it is known).
	public static int getPO_Metric2_ONN(int SUTNumber, String pricingModel, int arrivalRateFactor, double SSR_min) throws SQLException{
			int ONN;
			String getONN = "SELECT clusterSize FROM benefits WHERE SUTNumber = ? AND pricingModel = ? AND arrivalRateFactor = ? AND satisfactionRate > ? AND UBF_centsPerHour = (SELECT MAX(UBF_centsPerHour) FROM benefits WHERE SUTNumber = ? AND pricingModel = ? AND arrivalRateFactor = ? AND satisfactionRate > ?)";

			Connection conn = DBConnect();
			
			PreparedStatement pstm = conn.prepareStatement(getONN);
			pstm.setInt(1, SUTNumber);
			pstm.setString(2, pricingModel);
			pstm.setInt(3, arrivalRateFactor);
			pstm.setDouble(4, SSR_min);
			pstm.setInt(5, SUTNumber);
			pstm.setString(6, pricingModel);
			pstm.setInt(7, arrivalRateFactor);
			pstm.setDouble(8, SSR_min);
			ResultSet rs = pstm.executeQuery();
			
			rs.next();
			ONN = rs.getInt(1);
			
			rs.close();
			pstm.close();
			conn.close();
			
			
			return ONN;	
	}
	
	// PO_Metric 2 Bis: OARF (Optimal Arrival Rate Factor) which gives the highest LUBF under the reference number of nodes (if it is known).
	public static int getPO_Metric2Bis_OARF(int SUTNumber, String pricingModel, int clusterSize, double SSR_min) throws SQLException{
			int OARF;
			String getOARF = "SELECT arrivalRateFactor FROM benefits WHERE SUTNumber = ? AND pricingModel = ? AND clusterSize = ? AND satisfactionRate > ? AND UBF_centsPerHour = (SELECT MAX(UBF_centsPerHour) FROM benefits WHERE SUTNumber = ? AND pricingModel = ? AND clusterSize = ? AND satisfactionRate > ?)";

			Connection conn = DBConnect();
			
			PreparedStatement pstm = conn.prepareStatement(getOARF);
			pstm.setInt(1, SUTNumber);
			pstm.setString(2, pricingModel);
			pstm.setInt(3, clusterSize);
			pstm.setDouble(4, SSR_min);
			pstm.setInt(5, SUTNumber);
			pstm.setString(6, pricingModel);
			pstm.setInt(7, clusterSize);
			pstm.setDouble(8, SSR_min);
			ResultSet rs = pstm.executeQuery();
			
			rs.next();
			OARF = rs.getInt(1);
			
			rs.close();
			pstm.close();
			conn.close();
			
			
			return OARF;	
	}
	
	// get LUBF.  
	public static double getLUBF(int SUTNumber, String pricingModel, int clusterSize, int arrivalRateFactor) throws SQLException{
		double LUBF;
		String getSSR = "SELECT UBF_centsPerHour FROM benefits WHERE SUTNumber = ? AND pricingModel = ? and clusterSize = ? AND arrivalRateFactor = ?";
		
		Connection conn = DBConnect();
		
		PreparedStatement pstm = conn.prepareStatement(getSSR);
		pstm.setInt(1, SUTNumber);
		pstm.setString(2, pricingModel);
		pstm.setInt(3, clusterSize);
		pstm.setInt(4, arrivalRateFactor);
		ResultSet rs = pstm.executeQuery();
		
		rs.next();
		LUBF = rs.getDouble(1);
		
		rs.close();
		pstm.close();
		conn.close();
		
		return LUBF;
	}

	public static void showAllforMNN(int SUTNumber, String pricingModel, int arrivalRateFactor, double SSR_min) throws SQLException {
		int MNN = getPO_Metric1_MNN(SUTNumber, pricingModel, arrivalRateFactor, SSR_min);
		System.out.println("MNN: " + MNN);
		double SSR = getTO_Metric1_SSR(SUTNumber, pricingModel, MNN, arrivalRateFactor);
		System.out.println("SSR: " + SSR);
		double FTS = getTO_Metric2_FTS(SUTNumber, pricingModel, MNN, arrivalRateFactor);
		System.out.println("FTS: " + FTS);
		double TPAT = getTO_Metric3_TPAT(SUTNumber, pricingModel, MNN, arrivalRateFactor);
		System.out.println("TPAT: " + TPAT);
		double LUBF = getLUBF(SUTNumber, pricingModel, MNN, arrivalRateFactor);
		System.out.println("LUBF: " + LUBF);
	}
		
	public static void showAllforONN(int SUTNumber, String pricingModel, int arrivalRateFactor, double SSR_min) throws SQLException {
		int ONN = getPO_Metric2_ONN(SUTNumber, pricingModel, arrivalRateFactor, SSR_min);
		System.out.println("ONN: " + ONN);
		double SSR = getTO_Metric1_SSR(SUTNumber, pricingModel, ONN, arrivalRateFactor);
		System.out.println("SSR: " + SSR);
		double FTS = getTO_Metric2_FTS(SUTNumber, pricingModel, ONN, arrivalRateFactor);
		System.out.println("FTS: " + FTS);
		double TPAT = getTO_Metric3_TPAT(SUTNumber, pricingModel, ONN, arrivalRateFactor);
		System.out.println("TPAT: " + TPAT);
		double LUBF = getLUBF(SUTNumber, pricingModel, ONN, arrivalRateFactor);
		System.out.println("LUBF: " + LUBF);	
	}
	
	public static void showAllforHARF(int SUTNumber, String pricingModel, int clusterSize, double SSR_min) throws SQLException {
		int HARF = getPO_Metric1Bis_HARF(SUTNumber, pricingModel, clusterSize, SSR_min);
		System.out.println("HARF: " + HARF);
		double SSR = getTO_Metric1_SSR(SUTNumber, pricingModel, clusterSize, HARF);
		System.out.println("SSR: " + SSR);
		double FTS = getTO_Metric2_FTS(SUTNumber, pricingModel, clusterSize, HARF);
		System.out.println("FTS: " + FTS);
		double TPAT = getTO_Metric3_TPAT(SUTNumber, pricingModel, clusterSize, HARF);
		System.out.println("TPAT: " + TPAT);
		double LUBF = getLUBF(SUTNumber, pricingModel, clusterSize, HARF);
		System.out.println("LUBF: " + LUBF);
	}
	
	public static void showAllforOARF(int SUTNumber, String pricingModel, int clusterSize, double SSR_min) throws SQLException {
		int OARF = getPO_Metric2Bis_OARF(SUTNumber, pricingModel, clusterSize, SSR_min);
		System.out.println("OARF: " + OARF);
		double SSR = getTO_Metric1_SSR(SUTNumber, pricingModel, clusterSize, OARF);
		System.out.println("SSR: " + SSR);
		double FTS = getTO_Metric2_FTS(SUTNumber, pricingModel, clusterSize, OARF);
		System.out.println("FTS: " + FTS);
		double TPAT = getTO_Metric3_TPAT(SUTNumber, pricingModel, clusterSize, OARF);
		System.out.println("TPAT: " + TPAT);
		double LUBF = getLUBF(SUTNumber, pricingModel, clusterSize, OARF);
		System.out.println("LUBF: " + LUBF);
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
	
	public static void main(String[] args) throws SQLException {
//		for unit test
		int OARF = getPO_Metric2Bis_OARF(2, "QLSA", 5, 0.7);
		System.out.println("OARF: " + OARF);
	}
}
