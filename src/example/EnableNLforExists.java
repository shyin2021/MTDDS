package example;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

public class EnableNLforExists {
	
	private static final Integer[] queryIds = {16, 69, 94};
	
	public static void addCmd(String input_file, String output_file){
		BufferedReader queriesReader;
		FileWriter queriesWriter = null;
		String row = null;
		
		// create and open the output file
		try{
			queriesWriter = new FileWriter(output_file);
		} catch (IOException e1){
			e1.printStackTrace();
		}
		
		List<Integer> listQueryIds = Arrays.asList(queryIds);
		
		try{
			queriesReader = new BufferedReader(new FileReader(input_file));
			while((row = queriesReader.readLine()) != null){
				// copy the line into the output file
				queriesWriter.append(row);
				queriesWriter.append("\n");
				// analyze the row to see if it is the query to deal with
				String[] data = row.split(" ");
				if(data.length > 1 && data[1].equals("start")) {
					int queryId = Integer.parseInt(data[3]);
					if(listQueryIds.contains(queryId)){
						queriesWriter.append("set enable_nestloop = on;\n");
					}
				} else if(data.length > 1 && data[1].equals("end")) {
					int queryId = Integer.parseInt(data[3]);
					if(listQueryIds.contains(queryId)){
						queriesWriter.append("set enable_nestloop = off;\n");
					}
				}
			}
			queriesWriter.flush();
			queriesWriter.close();
			queriesReader.close();			
		} catch (IOException e2){
			e2.printStackTrace();
		}
	}
	
	public static void main(String[] args){
		// args[0]: input query file (after correcting the syntax errors and adding "explain analyze ")
		// args[1]: output query file for execution
		addCmd(args[0], args[1]);
	}
}
