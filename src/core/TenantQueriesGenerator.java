package core;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.lang.Math;
import java.text.DecimalFormat;
import java.util.Random;

public class TenantQueriesGenerator {
	
	private static final DecimalFormat df = new DecimalFormat("0.00");
	private static final int SimpleQueries[] = {28,93,3,12,20,41,42,43,52,55,86,98,15,21,22,36,37,53,63,80,81,82,89,96,97}; //25 queries
	private static final int ComplexQueries[] = {4, 8, 9, 11, 13, 14, 17, 18, 23, 24, 25, 29, 31, 33, 39, 44, 46, 48, 49, 54, 56, 58, 59, 60, 61, 64, 65, 66, 69, 72, 74, 75, 76, 77, 78, 83, 85, 87, 88}; //39 queries
	
	public static void generateQueries(int TenantId, double TenantArrivalTime, int NbQueries, int lamda, int IdleRatio, int PeakRatio, int f_peak, String queryComplexity, FileWriter csvWriter) {
		
		// generate the arrival time of each query
		long y_pre = TenantId;
		long y = TenantId;
		int m = 10000; // the maximum value of y
		int a = 101; //
		int b = 7; //
		double z_pre = TenantArrivalTime;
		double z = TenantArrivalTime;
		
		//compute the number of idle intervals
		int NbIdleItvl = IdleRatio*NbQueries/(lamda*(100-IdleRatio));
		//compute the peak intervals
		int NbPeakItvl = PeakRatio*NbQueries/(lamda*(100-PeakRatio));
		boolean peakTime = false;
		
		Random randGen = new Random(TenantId); // put a seed for the reproducibility
		for(int i=1; i<=NbQueries; i++) {
			// add an idle interval
			if(peakTime)
			{
				//it is a peak interval
			}
			else if(NbIdleItvl>0 && randGen.nextDouble(1)<=(double)IdleRatio/100) {
				z_pre++;
				NbIdleItvl--;
			} else if (NbPeakItvl>0 && randGen.nextDouble(1)<=(double)PeakRatio/100)
			{
				peakTime = true;
				NbPeakItvl--;
			}
			
			//write the query's information into the file
			try {
				// TenantId
				csvWriter.append(Integer.toString(TenantId));
				csvWriter.append(";");
				// QueryId
				int index = 0;
				int QueryId = 0;
				switch(queryComplexity) {
					case "Simple":
						index = (int)(randGen.nextDouble(1)*25);
						QueryId = SimpleQueries[index];
						break;
					case "Complex":
						index = (int)(randGen.nextDouble(1)*24);
						QueryId = ComplexQueries[index];
						break;
					default:
						QueryId = (int)(randGen.nextDouble(1)*99)+1;
						break;
				}
				csvWriter.append(Integer.toString(QueryId));
				csvWriter.append(";");
				//Arrival order
				csvWriter.append(Integer.toString(i));
				csvWriter.append(";");
				//Arrival time
				csvWriter.append(df.format(z));
				csvWriter.append(";");
				//Arrival time interval
				csvWriter.append(Integer.toString((int)z));
				csvWriter.append("\n");
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// generate the arrival time of the next query
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
			if(!peakTime) {
				x = Math.log(u)/(0-lamda);
			} else {
				x = Math.log(u)/(0-lamda*f_peak); //
			}
			// simulate the arrival times of a Poisson process
			z = z_pre + x;
			//System.out.println(df.format(z));
		
			y_pre = y;
			if(peakTime && (int)z != (int)z_pre) {
				//peak interval finished
				peakTime = false;
			}
			z_pre = z;				
		}
		
		// 
	}
	
	public static void generateAllQueries(String inputFile, String outputDir) {
		BufferedReader csvReader;
		FileWriter csvWriter = null;
			
		try {
			csvReader = new BufferedReader(new FileReader(inputFile));
			
			//skip the file header
			String row = csvReader.readLine();
			while ((row = csvReader.readLine()) != null) {
			    String[] data = row.split(";");
			    // retrieve the tenant's information
			    int TenantId = Integer.parseInt(data[0]);
			    String queryComplexity = data[3];
			    double ArrivalTime = Double.parseDouble(data[4].replace(",", "."));
			    int NbQueries = Integer.parseInt(data[5]);
			    int lamda = Integer.parseInt(data[6]);
			    int idleRatio = Integer.parseInt(data[7]);
			    int peakRatio = Integer.parseInt(data[8]);
			    int f_peak = Integer.parseInt(data[9]);

				csvWriter = new FileWriter(outputDir +"\\Tenant_"+TenantId+ "_Queries.csv");
				//write the file header
				csvWriter.append("TenantId");
				csvWriter.append(";");
				csvWriter.append("QueryId");
				csvWriter.append(";");
				csvWriter.append("ArrivalOrder");
				csvWriter.append(";");
				csvWriter.append("ArrivalTime");
				csvWriter.append(";");
				csvWriter.append("ArrivalTimeInterval");
				csvWriter.append("\n");

			    generateQueries(TenantId, ArrivalTime, NbQueries, lamda, idleRatio, peakRatio, f_peak, queryComplexity, csvWriter);
				csvWriter.flush();
				csvWriter.close();
			}
			//flush the data and close the files
			csvReader.close();
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public static void generateAllQueries_OneFile(String inputFile, String outputDir) {
		BufferedReader csvReader;
		FileWriter csvWriter = null;
			
		try {
			csvReader = new BufferedReader(new FileReader(inputFile));
			csvWriter = new FileWriter(outputDir +"\\Tenant_Queries.csv");
			//write the file header
			csvWriter.append("TenantId");
			csvWriter.append(";");
			csvWriter.append("QueryId");
			csvWriter.append(";");
			csvWriter.append("ArrivalOrder");
			csvWriter.append(";");
			csvWriter.append("ArrivalTime");
			csvWriter.append(";");
			csvWriter.append("ArrivalTimeInterval");
			csvWriter.append("\n");
			
			//skip the file header
			String row = csvReader.readLine();
			while ((row = csvReader.readLine()) != null) {
			    String[] data = row.split(";");
			    // retrieve the tenant's information
			    int TenantId = Integer.parseInt(data[0]);
			    String queryComplexity = data[3];
			    double ArrivalTime = Double.parseDouble(data[4].replace(",", "."));
			    int NbQueries = Integer.parseInt(data[5]);
			    int lamda = Integer.parseInt(data[6]);
			    int idleRatio = Integer.parseInt(data[7]);
			    int peakRatio = Integer.parseInt(data[8]);
			    int f_peak = Integer.parseInt(data[9]);

			    generateQueries(TenantId, ArrivalTime, NbQueries, lamda, idleRatio, peakRatio, f_peak, queryComplexity, csvWriter);
			}
			//flush the data and close the files
			csvWriter.flush();
			csvWriter.close();
			csvReader.close();
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public static void main(String[] args)
	{
		//args[0]: input file name (directory + "tenants.csv")
		//args[1]: output directory
		TenantQueriesGenerator.generateAllQueries_OneFile(args[0], args[1]);
		System.out.println("Queries generated.");
	}
}
