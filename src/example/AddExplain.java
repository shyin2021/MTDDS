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
		
		int queryNb = 0;
		int nbBlank = 0;
		try{
			queriesReader = new BufferedReader(new FileReader(input_file));
			while((row = queriesReader.readLine()) != null){
				// analyze the row to see if a query starts just after
				String[] data = row.split(" ");
				if(data.length < 2 && data[0].isBlank()) {
					nbBlank ++;
				}
				else if (nbBlank > 0 && !data[0].isBlank()){ // TO CHECK
					nbBlank = 0;
					queryNb++;
					if(queryNb>1) {
						queriesWriter.append("-- end query " + (queryNb -1) + "\n");
					}
					queriesWriter.append("-- start query " + queryNb + "\n");
					queriesWriter.append("\\o "+ path_for_plans + "/" + output_file + "_q" + queryNb + ".plan.txt");
					queriesWriter.append("\n");
					queriesWriter.append("explain analyze ");
				}
				// copy the line into the output file
				queriesWriter.append(row);
				queriesWriter.append("\n");
			}
			queriesWriter.append("-- end query " + queryNb + "\n");
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

