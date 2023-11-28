package example;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class MTTestsScriptWriter {
	private static final String[] nodes = {"DN1", "DN2", "DN3", "DN4"};
	public static void generateScripts(int runId, String generatedTenantsFile, String sourceScriptDir, String outputDir) {
		BufferedReader tenantsReader;
		BufferedReader ssReader; // to read the source script
		FileWriter ctnWriter = null; // script for creating tenants
		FileWriter ctbWriter = null; // script for creating tables
		FileWriter ldWriter = null; // script for loading data

		try {
			ctnWriter = new FileWriter(outputDir + "\\createTenants.sql");
		} catch (IOException e1) {
			e1.printStackTrace();
		}	
		
		try {
			tenantsReader = new BufferedReader(new FileReader(generatedTenantsFile));			
			//skip the file header
			String row = tenantsReader.readLine();
		    int index_small = 3;
		    int index_medium = 0;
		    int index_large = 0;
			while ((row = tenantsReader.readLine()) != null) {
			    String[] data = row.split(";");
			    // retrieve the tenant's information
			    String tenantId = data[0];
			    String DB_size = data[2];
			    // add lines in the create tenants file
			    ctnWriter.append("create user tenant" + tenantId + " with password \'tenant" + tenantId + "\';\n");
			    ctnWriter.append("alter user tenant" + tenantId + " with createrole createdb;\n");
			    ctnWriter.append("create database tenant" + tenantId + ";\n");
			    ctnWriter.append("alter database tenant" + tenantId + " owner to \"tenant" + tenantId + "\";\n");
			    // generate the create tables file
			    ctbWriter = new FileWriter(outputDir + "\\createTables_tenant" + tenantId +".sql");
			    ssReader = new BufferedReader(new FileReader(sourceScriptDir + "\\creation.sql"));
			    String rowSS = null;
			    // only works for scale factors 1, 2, 3
			    while ((rowSS = ssReader.readLine()) != null) {
			    	String[] dataSS = rowSS.split(" ");
			    	if(dataSS.length < 3) {
			    		// copy the line
			    		ctbWriter.append(rowSS + "\n");
			    		continue;
			    	}
			    	if(dataSS[1].equals("TO") && dataSS[2].equals("NODE")) {
			    		// allocate nodes for the tenant
			    		if(DB_size.equals("Small")) {
			    			ctbWriter.append(") TO NODE (" + nodes[index_small] +");\n");
			    		} else if(DB_size.equals("Medium")) {
			    			ctbWriter.append(") TO NODE (" + nodes[index_medium] + ", " + nodes[index_medium+2] +");\n");
			    		} else {// if(DB_size.equals("Large"))
			    			ctbWriter.append(") TO NODE (" + nodes[index_large] + ", " + nodes[index_large+1] + ", " + nodes[index_large+2] +");\n");
			    		}
			    	} else {
			    		// copy the line
			    		ctbWriter.append(rowSS + "\n");
			    	}
			    }
			    if(DB_size.equals("Small")) {
	    			if(index_small == 0) {
	    				index_small = 1;
	    			} else {
	    				index_small--;
	    			}
	    		} else if(DB_size.equals("Medium")) {
	    			if(index_medium == 1) {
	    				index_medium = 0;
	    			} else {
	    				index_medium = 1;
	    			}
	    		} else {// if(DB_size.equals("Large"))
	    			index_large = 0;
	    		}
			    ctbWriter.flush();
				ctbWriter.close();
			    // generate the load data script (.sh)
				ldWriter = new FileWriter(outputDir + "\\loaddata_" + tenantId +".sh");
			    if(DB_size.equals("Small")) {
			    	ldWriter.append("cd /home/postgres/tpcds-kit/tools/tmp_s\n");
			    } else if (DB_size.equals("Medium")) {
			    	ldWriter.append("cd /home/postgres/tpcds-kit/tools/tmp_m\n");
			    } else { // if(DB_size.equals("Large"))
			    	ldWriter.append("cd /home/postgres/tpcds-kit/tools/tmp_l\n");
			    }
			    ldWriter.append("for i in *.dat; do\n");
			    ldWriter.append("    table=${i/.dat/}\n");
			    ldWriter.append("    echo \"Loading $table...\"\n");
			    ldWriter.append("    sed 's/|$//' $i > /tmp/$i\n");
			    ldWriter.append("    psql -h master -p 30001 -U tenant" + tenantId + " -d tenant" + tenantId + " -q -c \"TRUNCATE $table\"\n");
			    ldWriter.append("    psql -h master -p 30001 -U tenant" + tenantId + " -d tenant" + tenantId + " -c \"\\\\copy $table FROM '/tmp/$i' CSV DELIMITER '|'\"\n");
			    ldWriter.append("done\n");
			    ldWriter.flush();
				ldWriter.close();
			}
			//flush the data and close the files
			ctnWriter.flush();
			ctnWriter.close();
			tenantsReader.close();
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public static void main(String[] args) {
		// for unit test
		generateScripts(Integer.parseInt(args[0]), args[1], args[2], args[3]);
	}
}
