package example;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class MTTestsScriptWriter {
	public static void generateScripts(int runId, int nbNodes, int nbNodes_s, int nbNodes_m, int nbNodes_l, String generatedTenantsFile, String sourceScriptDir, String outputDir) {
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
		    int node_index= 1;
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
			    // 
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
			    			ctbWriter.append(") TO NODE (DN" + node_index);
			    			for(int i=1;i<nbNodes_s;i++) {
			    				int next = (node_index+i)%nbNodes;
			    				if(next == 0) {
			    					next = nbNodes;
			    				}
			    				ctbWriter.append(", DN" + next);
			    			}
			    			ctbWriter.append(");\n");
			    		} else if(DB_size.equals("Medium")) {
			    			ctbWriter.append(") TO NODE (DN" + node_index);
			    			for(int i=1;i<nbNodes_m;i++) {
			    				int next = (node_index+i)%nbNodes;
			    				if(next == 0) {
			    					next = nbNodes;
			    				}
			    				ctbWriter.append(", DN" + next);
			    			}
			    			ctbWriter.append(");\n");
			    		} else {// if(DB_size.equals("Large"))
			    			ctbWriter.append(") TO NODE (DN" + node_index);
			    			for(int i=1;i<nbNodes_l;i++) {
			    				int next = (node_index+i)%nbNodes;
			    				if(next == 0) {
			    					next = nbNodes;
			    				}
			    				ctbWriter.append(", DN" + next);
			    			}
			    			ctbWriter.append(");\n");
			    		}
			    	} else {
			    		// copy the line
			    		ctbWriter.append(rowSS + "\n");
			    	}
			    }
			    if(DB_size.equals("Small")) {
			    	node_index = (node_index + nbNodes_s)%nbNodes;
			    	if(node_index == 0) {
			    		node_index = nbNodes;
    				}
	    		} else if(DB_size.equals("Medium")) {
	    			node_index = (node_index + nbNodes_m)%nbNodes;
	    			if(node_index == 0) {
			    		node_index = nbNodes;
    				}
	    		} else {// if(DB_size.equals("Large"))
	    			node_index = (node_index + nbNodes_l)%nbNodes;
	    			if(node_index == 0) {
			    		node_index = nbNodes;
    				}
	    		}
			    ctbWriter.flush();
				ctbWriter.close();
			    // generate the load data script (.sh)
				ldWriter = new FileWriter(outputDir + "\\loaddata_" + tenantId +".sh");
			    if(DB_size.equals("Small")) {
			    	ldWriter.append("cd /root/home/postgres/mtdds/tmp/s\n");
			    } else if (DB_size.equals("Medium")) {
			    	ldWriter.append("cd /root/home/postgres/mtdds/tmp/m\n");
			    } else { // if(DB_size.equals("Large"))
			    	ldWriter.append("cd /root/home/postgres/mtdds/tmp/l\n");
			    }
			    ldWriter.append("for i in *.dat; do\n");
			    ldWriter.append("    table=${i/.dat/}\n");
			    ldWriter.append("    echo \"Loading $table...\"\n");
			    ldWriter.append("    sed 's/|$//' $i > /tmp/$i\n");
			    ldWriter.append("    psql -h 172.16.66.12 -p 20004 -U tenant" + tenantId + " -d tenant" + tenantId + " -q -c \"TRUNCATE $table\"\n");
			    ldWriter.append("    psql -h 172.16.66.12 -p 20004 -U tenant" + tenantId + " -d tenant" + tenantId + " -c \"\\\\copy $table FROM '/tmp/$i' CSV DELIMITER '|'\"\n");
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
		generateScripts(Integer.parseInt(args[0]), Integer.parseInt(args[1]), Integer.parseInt(args[2]), Integer.parseInt(args[3]), Integer.parseInt(args[4]), args[5], args[6], args[7]);
	}
}
