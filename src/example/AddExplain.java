package example;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;


public class AddExplain{
	public static void addExplain_(String input_file, String output_path, String output_file, String path_for_plans){
		BufferedReader queriesReader;
		FileWriter queriesWriter = null;
		String row = null;
		
		// create and open the output file
		try{
			queriesWriter = new FileWriter(output_path+"/"+output_file+".sql");
		} catch (IOException e1){
			e1.printStackTrace();
		}
		
		try{
			queriesReader = new BufferedReader(new FileReader(input_file));
			while((row = queriesReader.readLine()) != null){
				// copy the line into the output file
				queriesWriter.append(row);
				queriesWriter.append("\n");
				// analyze the row to see if a query starts just after
				String[] data = row.split(" ");
				if(data.length > 1 && data[1].equals("start")){
					queriesWriter.append("\\o "+ path_for_plans + "/" + output_file + "_q" + data[3] + ".pl");
					queriesWriter.append("\n");
					queriesWriter.append("explain analyze ");
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
		addExplain_(args[0], args[1], args[2], args[3]);
	}
}

