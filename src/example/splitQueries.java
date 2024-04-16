package example;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;


public class splitQueries{
	public static void splitQ(String input_file, String output_path){
		BufferedReader queriesReader;
		FileWriter queryWriter = null;
		String row = null;
		
		// read the queries from the input file		
		try{
			queriesReader = new BufferedReader(new FileReader(input_file));
			while((row = queriesReader.readLine()) != null){
				// analyze the row to see if a query starts just after
				String[] data = row.split(" ");
				if(data.length > 1 && data[1].equals("start")){
					if(queryWriter != null){
						queryWriter.flush();
						queryWriter.close();
					}
					queryWriter = new FileWriter(output_path+"\\"+data[3]+".sql");
					queriesReader.readLine(); //skip the next line
				}// copy the line into the output file
				if(queryWriter != null){	
					queryWriter.append(row);
					queryWriter.append("\n");
				}	
			}
			queryWriter.flush();
			queryWriter.close();
			queriesReader.close();			
		} catch (IOException e2){
			e2.printStackTrace();
		}
	}
	
	public static void main(String[] args){
		// args[0]: the input file name with directory
		// args[1]: the output directory
		splitQ(args[0], args[1]);
	}
}
