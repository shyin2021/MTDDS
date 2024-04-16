package tools;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DBInitialization {
	// connection to a DBMS
	static Connection DBConnect() throws SQLException, ClassNotFoundException{
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
	
	public static void initDB() throws SQLException, ClassNotFoundException {
		String createInitialTraces = "CREATE TABLE IF NOT EXISTS InitialTraces(\r\n"
				+ "SUTNumber number(3),\r\n"
				+ "clusterSize number(10),\r\n"
				+ "arrivalRateFactor number(10),\r\n"
				+ "tenantName varchar(20), \r\n"
				+ "queryName varchar(20), \r\n"
				+ "timerName varchar(20), \r\n"
				+ "event varchar(20),\r\n"
				+ "timeStamp number(20),\r\n"
				+ "PRIMARY KEY(SUTNumber, clusterSize, arrivalRateFactor, timerName, event))";
		String createFormatedTraces = "CREATE TABLE IF NOT EXISTS FormatedTraces(\r\n"
				+ "SUTNumber number(3),\r\n"
				+ "clusterSize number(10),\r\n"
				+ "arrivalRateFactor number(10),\r\n"
				+ "tenantName varchar(20), \r\n"
				+ "queryName varchar(20), \r\n"
				+ "timerName varchar(20), \r\n"
				+ "launchTime number(20),\r\n"
				+ "startTime number(20),\r\n"
				+ "finishTime number(20),\r\n"
				+ "relativeLaunchTime number(20),\r\n"
				+ "waitingTime number(20),\r\n"
				+ "executionTime number(20),\r\n"
				+ "PRIMARY KEY (SUTNumber, clusterSize, arrivalRateFactor, timerName))";
		String createTenants = "CREATE TABLE IF NOT EXISTS tenants(tenantId varchar(20) PRIMARY KEY, DBSize varchar(20), Priority varchar(20))";
		String createDBSizesSF = "CREATE TABLE IF NOT EXISTS DBSizesSF(DBSize varchar(20), scaleFactor number(10), nbNodes number(10), PRIMARY KEY(DBSize))";
		String createPriorityTRT = "CREATE TABLE IF NOT EXISTS PriorityTRT(Priority varchar(20), TRT number(10,2), PRIMARY KEY(Priority))";
		String createRSPrices = "CREATE TABLE IF NOT EXISTS RSPrices(resourceType varchar(20), price number(10), unit varchar(20), PRIMARY KEY(resourceType))";
		String createPerfSLOs = "CREATE TABLE IF NOT EXISTS perfSLOs(\r\n"
				+ "		queryId varchar(20), \r\n"
				+ "		scaleFactor number(6),\r\n"
				+ "		expectedExecTime number(20),\r\n"
				+ "		expectedQCT number(20), \r\n"
				+ "		perfSLO_premium number(20), \r\n"
				+ "		perfSLO_standard number(20), \r\n"
				+ "		perfSLO_basic number(20),\r\n"
				+ "		PRIMARY KEY (queryId, scaleFactor))";
		String createPerfSLOs_per_tenant = "CREATE TABLE IF NOT EXISTS perfSLOs_per_tenant(\r\n"
				+ "		tenantId varchar(20),\r\n"
				+ "		queryId varchar(20),\r\n"
				+ "		expectedExecTime number(20),\r\n"
				+ "		expectedQCT number(20),\r\n"
				+ "		perfSLO number(20),\r\n"
				+ "		PRIMARY KEY(tenantId, queryId))";
		String createPricePerQuery = "CREATE TABLE IF NOT EXISTS Price_per_query(SUTNumber number(3), clusterSize number(10), arrivalRateFactor number(10), tenantId varchar(20), queryId varchar(20), timerId varchar(20), expectedExecTime number(20), realQCT number (20), price_millicents number(10,3), PRIMARY KEY(SUTNumber, clusterSize, arrivalRateFactor, tenantId, timerId))";
		String createTotalPerTenant = "CREATE TABLE IF NOT EXISTS TotalPerTenant(SUTNumber number(3), clusterSize number(10), arrivalRateFactor number(10), tenantId varchar(20), total_cents number(10, 3))";		
		String createBenefits = "CREATE TABLE IF NOT EXISTS Benefits(SUTNumber number(3),clusterSize number(5), arrivalRateFactor number(5), pricingModel varchar(20), depense number(10,3), income number(10, 3), "
				+ "benefit number(10,3), totalHours number(10,3), UBF_centsPerHour number(10,3), satisfactionRate number(10,3), fairness number(10,3), tpat number(10,3))";
		// specific for the IDS pricing model
		String createIDSTraces = "CREATE TABLE IF NOT EXISTS IDSTraces(\r\n"
				+ "SUTNumber number(3),\r\n"
				+ "clusterSize number(10),\r\n"
				+ "arrivalRateFactor number(10),\r\n"
				+ "tenantName varchar(20), \r\n"
				+ "queryName varchar(20), \r\n"
				+ "timerName varchar(20), \r\n"
				+ "totalInputDataSize number(20),\r\n"
				+ "PRIMARY KEY (SUTNumber, clusterSize, arrivalRateFactor, timerName))";
		
		// specific for the STB pricing model
		String createSTBSLOs = "CREATE TABLE IF NOT EXISTS STBSLOs(\r\n"
				+ "tierId number(3),\r\n"
				+ "nbNodes number(10),\r\n"
				+ "queryComplexity varchar(20),\r\n"
				+ "perfSLO number(20), \r\n" // in millisecond
				+ "price number(10), \r\n"
				+ "unit varchar(20), \r\n" // cents per hour
				+ "PRIMARY KEY (tierID, queryComplexity))";
		String createSTBTenantTier = "CREATE TABLE IF NOT EXISTS STBTenantTier(tenantId varchar(20), tierId number(3), PRIMARY KEY (tenantId, tierId))";
		String createQueryComplexity = "CREATE TABLE IF NOT EXISTS QueryComplexity(queryId number, queryComplexity varchar(20), PRIMARY KEY (queryId))";
		
		Connection conn = DBConnect();
		
		Statement stm = conn.createStatement();
		try {
			stm.execute(createInitialTraces);
			System.out.println("InitialTraces created.");
		} catch (SQLException se) {
			System.out.println(se);
		}

		try {
			stm.execute(createFormatedTraces);
			System.out.println("FormatedTraces created.");
		} catch (SQLException se) {
			System.out.println(se);
		}

		try {
			stm.execute(createTenants);
			System.out.println("Tenants created.");
		} catch (SQLException se) {
			System.out.println(se);
		}

		try {
			stm.execute(createDBSizesSF);
			System.out.println("DBSizesSF created.");
		} catch (SQLException se) {
			System.out.println(se);
		}

		try {
			stm.execute(createPriorityTRT);
			System.out.println("PriorityTRT created.");
		} catch (SQLException se) {
			System.out.println(se);
		}

		try {
			stm.execute(createRSPrices);
			System.out.println("RSPrices created.");
		} catch (SQLException se) {
			System.out.println(se);
		}

		try {
			stm.execute(createPerfSLOs);
			System.out.println("PerfSLOs created.");
		} catch (SQLException se) {
			System.out.println(se);
		}

		try {
			stm.execute(createPerfSLOs_per_tenant);
			System.out.println("PerfSLOs_per_tenant created.");
		} catch (SQLException se) {
			System.out.println(se);
		}

		try {
			stm.execute(createPricePerQuery);
			System.out.println("PricePerQuery created.");
		} catch (SQLException se) {
			System.out.println(se);
		} 

		try {
			stm.execute(createBenefits);
			System.out.println("Benefits created.");
		} catch (SQLException se) {
			System.out.println(se);
		} 
		
		try {
			stm.execute(createTotalPerTenant);
			System.out.println("TotalPerTenant created.");
		} catch (SQLException se) {
			System.out.println(se);
		} 
		
		try {
			stm.execute(createIDSTraces);
			System.out.println("IDSTraces created.");
		} catch (SQLException se) {
			System.out.println(se);
		}
		
		try {
			stm.execute(createSTBSLOs);
			System.out.println("STBSLOs created.");
		} catch (SQLException se) {
			System.out.println(se);
		}
		
		try {
			stm.execute(createSTBTenantTier);
			System.out.println("STBTenantTier created.");
		} catch (SQLException se) {
			System.out.println(se);
		}
		
		try {
			stm.execute(createQueryComplexity);
			System.out.println("QueryComplexity created.");
		} catch (SQLException se) {
			System.out.println(se);
		}
		
		stm.close();
		conn.close();
		System.out.println("Connection closed.");
	}
	
	public static void main(String[] args) throws SQLException, ClassNotFoundException {
		initDB();
	}
}
