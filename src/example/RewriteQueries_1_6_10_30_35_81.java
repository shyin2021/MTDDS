package example;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class RewriteQueries_1_6_10_30_35_81 {
	public static void rewrite(String input_path, String input_file, String output_file){
		BufferedReader queriesReader;
		BufferedReader queryFileReader;
		FileWriter queriesWriter = null;
		String row = null;
		
		// create and open the output file
		try{
			queriesWriter = new FileWriter(input_path+"/"+output_file);
		} catch (IOException e1){
			e1.printStackTrace();
		}
		
		try{
			queriesReader = new BufferedReader(new FileReader(input_path+"/"+input_file));
			while((row = queriesReader.readLine()) != null){
				// analyze the row to see if it is the query to deal with
				String[] data = row.split(" ");
				if(data.length > 1 && data[1].equals("start")) {
					int queryId = Integer.parseInt(data[3]);
					if(queryId == 1 || queryId == 6 || queryId == 10 || queryId == 30 || queryId == 35 || queryId == 81){
						// skip the original query
						while(true) {
							row = queriesReader.readLine();
							data = row.split(" ");
							if(data.length > 1 && data[1].equals("end")) {
								break;
							}
						}
						// copy the query from the separate file
						queryFileReader = new BufferedReader(new FileReader(input_path+"/q"+queryId+".sql"));
						while((row = queryFileReader.readLine()) != null){
							// copy the line into the output file
							queriesWriter.append(row);
							queriesWriter.append("\n");
						}
					} else {
						// copy the line into the output file
						queriesWriter.append(row);
						queriesWriter.append("\n");
					}
				} else {
					// copy the line into the output file
					queriesWriter.append(row);
					queriesWriter.append("\n");
				}
			}
			queriesWriter.flush();
			queriesWriter.close();
			queriesReader.close();			
		} catch (IOException e2){
			e2.printStackTrace();
		}
	}
}
