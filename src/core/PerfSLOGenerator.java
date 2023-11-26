package core;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

//input 1: directory(execTimeDir) with execTime_*.csv (queryId, execTime) for the three scale factors, for example, execTime_2.csv for scale factor 2 
//input 2: query_types.csv (queryId, type)
//output: perfSLOs.csv (queryId, scaleFactor, expectedQCT, perfSLO_premium, perfSLO_standard, perfSLO_basic)
public class PerfSLOGenerator {
	private static Set<Integer> reportingQueries;
	private static double trp; // tolerance rate threshold of premium tenants
	private static double trs; // tolerance rate threshold of standard tenants
	private static double trb; // tolerance rate threshold of basic tenants

	public static void generatePerfSLO(String execTimeDir, String queryTypesFile, String PriorityTRTFile, String outputFile) {
		BufferedReader execTimeReader;
		BufferedReader queryTypesReader;
		BufferedReader priorityTRTReader;
		FileWriter csvWriter = null;
		reportingQueries = null;
		long execTime = 0;
		long perfSLO_premium = 0;
		long perfSLO_standard = 0;
		long perfSLO_basic = 0;
		long QCT_EXP = 0;
		
		try {
			csvWriter = new FileWriter(outputFile);
			//write the file header
			csvWriter.append("queryId");
			csvWriter.append(";");
			csvWriter.append("scaleFactor");
			csvWriter.append(";");
			csvWriter.append("execTime");
			csvWriter.append(";");
			csvWriter.append("expectedQCT");
			csvWriter.append(";");
			csvWriter.append("perfSLO_premium");
			csvWriter.append(";");
			csvWriter.append("perfSLO_standard");
			csvWriter.append(";");
			csvWriter.append("perfSLO_basic");
			csvWriter.append("\n");
		} catch (IOException e1) {
			e1.printStackTrace();
		}	
		
		try {
			reportingQueries = new HashSet<Integer>();
			queryTypesReader = new BufferedReader(new FileReader(queryTypesFile));
			String row = queryTypesReader.readLine();
			while ((row = queryTypesReader.readLine()) != null) {
			    String[] data = row.split(";");
			    // retrieve the type of each query
			    int queryId = Integer.parseInt(data[0]);
			    String queryType = data[1];
			    if(queryType.equals("reporting")) {
			    	reportingQueries.add(queryId);
			    }
			}
			
		try {
			priorityTRTReader = new BufferedReader(new FileReader(PriorityTRTFile)); // Priority, TTR
						
			//skip the file header
			row = priorityTRTReader.readLine();
			while ((row = priorityTRTReader.readLine()) != null) {
				String[] data = row.split(";");
				String Priority = data[0];
				double TTR = Double.parseDouble(data[1]);
				if(Priority.equals("Basic")) {
					trb = TTR;
				} else if (Priority.equals("Standard")) {
					trs = TTR;
				} else if (Priority.equals("Premium")) {
					trp = TTR;
				}
			}
			priorityTRTReader.close();
		} catch (IOException ie) {
			System.out.println(ie);
		}
			Set<String> execTimeFiles = listFiles(execTimeDir);
			Iterator<String> itr = execTimeFiles.iterator();
			while(itr.hasNext()) {
				String execTimeFile = itr.next();
				execTimeReader = new BufferedReader(new FileReader(execTimeDir+"\\"+execTimeFile));			
				//skip the file header
				row = execTimeReader.readLine();
				while ((row = execTimeReader.readLine()) != null) {
				    String[] data = row.split(";");
				    // retrieve the registered execution time of each query
				    int queryId = Integer.parseInt(data[0]);
				    csvWriter.append("q" + Integer.toString(queryId));
					csvWriter.append(";");
					//the name of the execTime file follows the format: execTime_scaleFactor_.csv
					String[] fileNameToken = execTimeFile.split("[_.]");
					csvWriter.append(fileNameToken[1]); // write the scale factor
					csvWriter.append(";");
				    execTime = Long.parseLong(data[1]);
				    // if the execution time is less than 1 ms, then consider it as 1 ms
				    if(execTime == 0) {
				    	execTime = 1;
				    }
				    if(reportingQueries.contains(queryId)) {
				    	// it is a reporting
				    	QCT_EXP = execTime * 1000;
				    	perfSLO_premium = execTime * 1000;
				    	perfSLO_standard = execTime * 1000;
				    	perfSLO_basic = execTime * 1000;				    	
				    } else {
				    	// it is an ad-hoc query
				    	QCT_EXP = execTime;
				    	perfSLO_premium = (long)(execTime * trp);
				    	perfSLO_standard = (long)(execTime * trs);
				    	perfSLO_basic = (long)(execTime* trb);
				    }
				    csvWriter.append(Long.toString(execTime));
				    csvWriter.append(";");
				    csvWriter.append(Long.toString(QCT_EXP));
				    csvWriter.append(";");
				    csvWriter.append(Long.toString(perfSLO_premium));
				    csvWriter.append(";");
				    csvWriter.append(Long.toString(perfSLO_standard));
				    csvWriter.append(";");
				    csvWriter.append(Long.toString(perfSLO_basic));
					csvWriter.append("\n");
				}
				execTimeReader.close();
			}
			//flush the data and close the files
			csvWriter.flush();
			csvWriter.close();
			queryTypesReader.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public static Set<String> listFiles(String dir) throws IOException {
	    try (Stream<Path> stream = Files.list(Paths.get(dir))) {
	        return stream
	          .filter(file -> !Files.isDirectory(file))
	          .map(Path::getFileName)
	          .map(Path::toString)
	          .collect(Collectors.toSet());
	    }
	}
	
	public static void main(String[] args) throws IOException {
		generatePerfSLO(args[0], args[1], args[2], args[3]);
	}
}
