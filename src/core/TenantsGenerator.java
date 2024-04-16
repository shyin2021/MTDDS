package core;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Random;

public class TenantsGenerator {

	private static final DecimalFormat df = new DecimalFormat("0.00");
	private static int TnInterArv;
	
	public static void generateTenants(int NbTenants, String TnInterArvFile, String outputfile)
	{
		FileWriter csvWriter;
		// generate the arrival time of each tenant
		long y_pre = 0;
		long y = 0;
		int m = 10000; // the maximum value of y
		int a = 101; //
		int b = 7; //
		int lambda_t = 1; // the parameter lambda for tenant arrivals
		double z_pre = 0;
		double z = 0;
		
		BufferedReader TnInterArvReader;
		
		try {
			TnInterArvReader = new BufferedReader(new FileReader(TnInterArvFile)); // TnInterArv
						
			//skip the file header
			String row = TnInterArvReader.readLine();
			if ((row = TnInterArvReader.readLine()) != null) {
				String[] data = row.split(";");
				TnInterArv = Integer.parseInt(data[0]);
			}
			TnInterArvReader.close();
		} catch (IOException ie) {
			System.out.println(ie);
		}
		
		try {
			csvWriter = new FileWriter(outputfile);
			//write the file header
			csvWriter.append("TenantId");
			csvWriter.append(";");
			csvWriter.append("Priority");
			csvWriter.append(";");
			csvWriter.append("DBSize");
			csvWriter.append(";");
			csvWriter.append("QueriesComplexity");
			csvWriter.append(";");
			csvWriter.append("ArrivalTime");
			csvWriter.append(";");
			csvWriter.append("NbQueries");
			csvWriter.append(";");
			csvWriter.append("Lambda");
			csvWriter.append(";");
			csvWriter.append("IdleRatio");
			csvWriter.append(";");
			csvWriter.append("PeakRatio");
			csvWriter.append(";");
			csvWriter.append("f_peak");		
			csvWriter.append("\n");
			
			//generate the tenants
			Random randGen = new Random(8069); // put a seed for the reproducibility
			for(int i=1; i<=NbTenants;i++) {		
				double at = z*TnInterArv; // 1 tenant per TnInterArv time units in average
				int nq = (int)(randGen.nextDouble(1)*91) + 10; // number of queries between 10 and 100
				int lambda = (int)(randGen.nextDouble(1)*10)+1; // lambda between 1 and 10		
				int ir = (int)(randGen.nextDouble(1)*50)+1; // idle ratio<=50			
				int pr = (int)(randGen.nextDouble(1)*(100-ir))+1; // peak ratio<= 100 - idle ratio				
				int f_peak = (int)(randGen.nextDouble(1)*2)+2; // peak factor			
				int dbsize = (int)(randGen.nextDouble(1)*6);
				String DB_Size = null;
				switch(dbsize) {
					case 0:
					case 1:
					case 2:
						DB_Size = "Small";
						break;
					case 3:
					case 4:
						DB_Size = "Medium";
						break;
					case 5:
						DB_Size = "Large";
						break;
					default:
						break;
				}
				int complexity = (int)(randGen.nextDouble(1)*6);
				String comp = null;
				switch(complexity) {
					case 0:
					case 1:
						comp = "Simple";
						break;
					case 2:
						comp = "Complex";
						break;
					case 3:
					case 4:
					case 5:
						comp = "Mixed";
						break;
					default:
						break;
				}
				int priority = (int)(randGen.nextDouble(1)*4);
				String prior = null;
				switch(priority) {
					case 0:
						prior = "Basic";
						break;
					case 1:
					case 2:
						prior = "Standard";
						break;
					case 3:
						prior = "Premium";
						break;
					default:
						break;
				}
				
				// write the generated data into the file
				csvWriter.append(Integer.toString(i));
				csvWriter.append(";");
				csvWriter.append(prior);
				csvWriter.append(";");
				csvWriter.append(DB_Size);
				csvWriter.append(";");
				csvWriter.append(comp);
				csvWriter.append(";");
				csvWriter.append(df.format(at));
				csvWriter.append(";");
				csvWriter.append(Integer.toString(nq));
				csvWriter.append(";");
				csvWriter.append(Integer.toString(lambda));
				csvWriter.append(";");
				csvWriter.append(Integer.toString(ir));
				csvWriter.append(";");
				csvWriter.append(Integer.toString(pr));
				csvWriter.append(";");
				csvWriter.append(Integer.toString(f_peak));
				csvWriter.append(";");
				
				csvWriter.append("\n");
				
				// generate the arrival time of the next tenant
				// uniformly distributed values generation
				do {
					if(y==0) {
						y_pre++; // to avoid the division by 0
					}
					y = (a* y_pre + b) - ((a* y_pre + b)/m)*m;
				} while(y==0);
				
				double u= (double)y/(double)m;
				// transformation to exponentially distributed values
				double x;
				x = Math.log(u)/(0-lambda_t);

				// simulate the arrival times of a Poisson process
				z = z_pre + x;
			
				y_pre = y;
				z_pre = z;
			}
			
			//flush the data and close the file
			csvWriter.flush();
			csvWriter.close();
			
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	public static void main(String[] args)
	{
		// args[0]: number of tenants
		// args[1]: outputfile (directory + file name)
		TenantsGenerator.generateTenants(Integer.parseInt(args[0]), args[1], args[2]);
		System.out.println(args[0] + " tenants generated.");
	}
}
