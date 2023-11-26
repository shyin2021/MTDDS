package example;

import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Iterator;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import java.io.BufferedReader;
import java.io.FileReader;

public class ExecTimeExtractor {
	public static void extractExecTime(String dir, String outputFile) throws IOException {
		FileWriter csvWriter = null;
		String planFile = null;
		BufferedReader planReader = null;
		try {
			try {
				csvWriter = new FileWriter(outputFile);
				//write the file header
				csvWriter.append("queryId");
				csvWriter.append(";");
				csvWriter.append("ExecTime");
				csvWriter.append("\n");
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}	
			Set<String> planFiles = listFiles(dir);
			Iterator<String> itr = planFiles.iterator();
			while(itr.hasNext()) {
				planFile = itr.next();
				planReader = new BufferedReader(new FileReader(dir+"\\"+planFile));
				String row;
				while ((row = planReader.readLine()) != null) {
				    String[] data = row.split(" ");
				    if(data.length<2) {
				    	continue;
				    }
				    else if(data[1].equals("Execution") && data[2].equals("time:")) {
				    	String[] fnameToken = planFile.split("[_.]");
				    	csvWriter.append(fnameToken[3].substring(1));
				    	csvWriter.append(";");
				    	String[] execTime = data[3].split("[.]");
				    	csvWriter.append(execTime[0]);
				    	csvWriter.append("\n");
				    }
				}
			}
			csvWriter.flush();
			csvWriter.close();
			planReader.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
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
		//args[0]: input directory
		//args[1]: output file (directory + file name)
		extractExecTime(args[0], args[1]);		
	}
}
