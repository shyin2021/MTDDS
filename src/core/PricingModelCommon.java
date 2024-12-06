package core;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class PricingModelCommon {
	// compute the successfully executed queries for each run (called by each pricing model for internal use)
	static void computeSuccesses(int SUTNumber, int clusterSize, int arrivalRateFactor) throws SQLException{
		String dropNbQueries = "DROP TABLE IF EXISTS NbQueries";
		String createNbQueries = "CREATE TABLE IF NOT EXISTS NbQueries(tenantId varchar(20), NbQueries number(10))";
		String insertNbQueries = " INSERT INTO NbQueries SELECT tenantName, count(*) FROM formatedTraces WHERE SUTNumber = ? AND clusterSize=? AND arrivalRateFactor=? GROUP BY tenantName";
		String dropNbSuccesses = "DROP TABLE IF EXISTS NbSuccesses";
		String createNbSuccesses = "CREATE TABLE IF NOT EXISTS NbSuccesses(tenantId varchar(20), NbSuccesses number(10))";
		String insertNbSuccesses = "INSERT INTO NbSuccesses SELECT tenantId, count(*) FROM formatedTraces, perfSLOs_per_tenant "
				+ "WHERE tenantName = tenantId AND queryName=queryId AND (finishTime-launchTime) <= perfSLO AND SUTNumber = ? AND clusterSize=? AND arrivalRateFactor=? GROUP BY tenantId";
		
		Statement stm = null;
		PreparedStatement pstm = null;
		Connection conn = null;
		
		try {
			conn = DBConnect();
			stm = conn.createStatement();
			try {
				stm.execute(dropNbQueries);
				System.out.println("NbQueries dropped.");
			} catch(SQLException se){
				System.out.println(se);
			} 
			try {
				stm.execute(createNbQueries);
				System.out.println("NbQueries created.");
			} catch(SQLException se){
				System.out.println(se);
			} 
			try {
				pstm = conn.prepareStatement(insertNbQueries);
				pstm.setInt(1, SUTNumber);
				pstm.setInt(2, clusterSize);
				pstm.setInt(3, arrivalRateFactor);
				pstm.executeUpdate();
				System.out.println("NbQueries inserted.");
			} catch(SQLException se){
				System.out.println(se);
			} finally{
				pstm.close();
			}
			try {
				stm.execute(dropNbSuccesses);
				System.out.println("NbSuccesses dropped.");
			} catch(SQLException se){
				System.out.println(se);
			} 
			try {
				stm.execute(createNbSuccesses);
				System.out.println("NbSuccesses created.");
			} catch(SQLException se){
				System.out.println(se);
			} 
			try {
				pstm = conn.prepareStatement(insertNbSuccesses);
				pstm.setInt(1, SUTNumber);
				pstm.setInt(2, clusterSize);
				pstm.setInt(3, arrivalRateFactor);
				pstm.executeUpdate();
				System.out.println("NbSuccesses inserted.");
			} catch(SQLException se){
				System.out.println(se);
			} finally{
				pstm.close();
			}
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			stm.close();
			conn.close();
			System.out.println("Connection closed.");
		}
	}
	
	// compute the total payment per tenant (called by each pricing model for internal use)
	public static void computeTotalPerTenant() throws SQLException {
		String deleteTotalPerTenant = "DELETE FROM TotalPerTenant";
		String computeTotalPerTenant = "INSERT INTO TotalPerTenant SELECT SUTNumber, clusterSize, arrivalRateFactor, tenantId, sum(price_millicents)/1000 FROM Price_per_query GROUP BY SUTNumber, clusterSize, arrivalRateFactor, tenantId ORDER BY SUTNumber, clusterSize, arrivalRateFactor, tenantId";
		Statement stm = null;
		Connection conn = null;
			
		try {
			conn = DBConnect();
			
			stm = conn.createStatement();
			stm.executeUpdate(deleteTotalPerTenant);
			System.out.println("TotalPerTenant deleted.");
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			stm.close();
			conn.close();
			System.out.println("Connection closed.");
		}
		
		try {
			conn = DBConnect();
			
			stm = conn.createStatement();
			stm.executeUpdate(computeTotalPerTenant);
			System.out.println("TotalPerTenant computed.");
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			stm.close();
			conn.close();
			System.out.println("Connection closed.");
		}
	}
	
	// compute some important intermediate metrics and the final metrics
	public static void computeBenefit(int SUTNumber, int clusterSize, int arrivalRateFactor, String pricingModel, boolean isolatedExecution) throws SQLException{
		String dropTmp = "DROP TABLE IF EXISTS tmp";
		String createTmp = "CREATE TABLE IF NOT EXISTS tmp(SUTNumber number(3),clusterSize number(5), arrivalRateFactor number(5), pricingModel varchar(20), depense number(10,3), income number(10, 3), "
				+ "benefit number(10,3), totalHours number(10,3), UBF_centsPerHour number(10,3), satisfactionRate number(10,3), fairness number(10,3), tpat number(10,3))";
		String initTmp = "INSERT INTO tmp VALUES(?, ?, ?, ?, 0, 0, 0, 0, 0, 0, 0, 0)";
		String setTotalDepense = "UPDATE tmp SET depense = (SELECT max(finishTime) - min(launchTime) FROM formatedTraces WHERE SUTNumber = ? AND clusterSize=? AND arrivalRateFactor=?) * (SELECT price FROM RSPrices WHERE resourceType='node')*" + clusterSize +"*1.0/3600000";
		String setTotalIncome = "UPDATE tmp SET income = (SELECT sum(total_cents)*1.0 FROM TotalPerTenant WHERE SUTNumber = ? AND clusterSize=? AND arrivalRateFactor=?)";
		String setBenefit = "UPDATE tmp SET benefit = income - depense";
		String setTotalTime = "UPDATE tmp SET totalHours =(SELECT (max(finishTime) - min(launchTime))/1000*1.0 FROM formatedTraces WHERE SUTNumber = ? AND clusterSize=? AND arrivalRateFactor=?)/3600";
		String setUBF_centsPerHour = "UPDATE tmp SET UBF_centsPerHour = benefit*1.0/totalHours";
		String setsatisfactionRate = "UPDATE tmp SET satisfactionRate = (SELECT sum(nbSuccesses)*1.0/sum(nbQueries) FROM NbSuccesses, nbQueries WHERE NbSuccesses.tenantId=nbQueries.tenantId)";
		String setFairness = "UPDATE tmp SET fairness =(SELECT (1-STDEV(nbSuccesses*1.0/nbQueries)) FROM NbSuccesses, nbQueries WHERE NbSuccesses.tenantId=nbQueries.tenantId)";
		String setTPAT = "UPDATE tmp SET tpat = (SELECT sum(total_cents) FROM totalPerTenant WHERE SUTNumber = ? AND clusterSize = ? AND arrivalRateFactor = ?)";
		String deleteTuple = "DELETE FROM Benefits WHERE SUTNumber = ? AND clusterSize=? AND arrivalRateFactor=? AND pricingModel=?";
		String insertTuple = "INSERT INTO Benefits SELECT * FROM tmp";

		PreparedStatement pstm = null;
		Statement stm = null;
		Connection conn = null;
		
		try {
			conn = DBConnect();
			
			stm = conn.createStatement();
			stm.execute(dropTmp);
			stm.execute(createTmp);
			stm.close();
			pstm = conn.prepareStatement(initTmp);
			pstm.setInt(1, SUTNumber);
			pstm.setInt(2, clusterSize);
			pstm.setInt(3, arrivalRateFactor);
			pstm.setString(4, pricingModel);
			pstm.executeUpdate();
			pstm.close();
			
			if(!isolatedExecution)
			{
				pstm = conn.prepareStatement(setTotalDepense);
				pstm.setInt(1, SUTNumber);
				pstm.setInt(2, clusterSize);
				pstm.setInt(3, arrivalRateFactor);
				pstm.executeUpdate();
				pstm.close();
				System.out.println("depense computed.");
			}else {
				Statement stm1 = conn.createStatement();
				try {
					stm1.execute("DROP TABLE TotalTimePerTenant");
					System.out.println("TotalTimePerTenant dropped.");
				} catch(SQLException se){
					System.out.println(se);
				} 
				
				String createTotalTimePerTenant = "CREATE TABLE TotalTimePerTenant AS SELECT tenantName, (max(finishTime) - min(launchTime)) as totalTime FROM formatedTraces WHERE SUTNumber = ? AND clusterSize=? AND arrivalRateFactor=? GROUP BY tenantName";
				PreparedStatement preparedStatement = conn.prepareStatement(createTotalTimePerTenant);
				preparedStatement.setInt(1, SUTNumber);
				preparedStatement.setInt(2, clusterSize);
				preparedStatement.setInt(3, arrivalRateFactor);
				preparedStatement.execute();
				preparedStatement.close();
				String setTotalDepenseIso = "UPDATE tmp SET depense = (SELECT SUM(totalTime*nbNodes) FROM TotalTimePerTenant TTPT, tenants TN, DBSizesSF DS WHERE TTPT.tenantName=TN.tenantId AND TN.DBSize=DS.DBSize)*(SELECT price FROM RSPrices WHERE resourceType='node')*1.0/3600000";
				stm1.execute(setTotalDepenseIso);
				System.out.println("depense computed.");
				stm1.close();
			}
			
			pstm = conn.prepareStatement(setTotalIncome);
			pstm.setInt(1, SUTNumber);
			pstm.setInt(2, clusterSize);
			pstm.setInt(3, arrivalRateFactor);
			pstm.executeUpdate();
			pstm.close();
			System.out.println("income computed.");
			
			stm = conn.createStatement();
			stm.executeUpdate(setBenefit);
			stm.close();
			System.out.println("benefit computed.");
			
			pstm = conn.prepareStatement(setTotalTime);
			pstm.setInt(1, SUTNumber);
			pstm.setInt(2, clusterSize);
			pstm.setInt(3, arrivalRateFactor);
			pstm.executeUpdate();
			pstm.close();
			System.out.println("totalTime computed.");
			
			stm = conn.createStatement();
			stm.executeUpdate(setUBF_centsPerHour);
			stm.close();
			System.out.println("UBF_centsPerHour computed.");
			
			stm = conn.createStatement();
			stm.executeUpdate(setsatisfactionRate);
			stm.close();
			System.out.println("satisfactionRate computed.");
			
			stm = conn.createStatement();
			stm.executeUpdate(setFairness);
			stm.close();
			System.out.println("fairness computed.");
			
			pstm = conn.prepareStatement(setTPAT);
			pstm.setInt(1, SUTNumber);
			pstm.setInt(2, clusterSize);
			pstm.setInt(3, arrivalRateFactor);
			pstm.executeUpdate();
			pstm.close();
			System.out.println("TPAT computed.");
			
			pstm = conn.prepareStatement(deleteTuple);
			pstm.setInt(1, SUTNumber);
			pstm.setInt(2, clusterSize);
			pstm.setInt(3, arrivalRateFactor);
			pstm.setString(4, pricingModel);
			
			pstm.executeUpdate();
			pstm.close();
			
			System.out.println("Previous benefit deleted.");

			stm = conn.createStatement();
			stm.executeUpdate(insertTuple);
			stm.close();
			
			System.out.println("New benefit inserted.");
			
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			conn.close();
			System.out.println("Connection closed.");
		}
		
	}
	
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
}
