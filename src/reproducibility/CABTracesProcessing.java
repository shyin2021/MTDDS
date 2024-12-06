package reproducibility;
/***
 * This program is only used to merge the individual execution traces of all tenants after a CAB run. 
 * The driver programs used to run CAB experiments are in the folder "files/CABTests_SparkSQL".
 * The final results are calculated within an excel file ("files/excelFilesforFigures/Figure14.xlsx"), based on the merged traces.
***/
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.SQLException;

public class CABTracesProcessing {
	public static void MergeCABTraces(int SUTNumber, String inputDir, int NbTraces, String outputDir) throws SQLException {
		// accelerationFactor : to multiply the ARF by a certain factor for some SUTs which are much more powerful
		BufferedReader csvReader;
		FileWriter csvWriter = null;
		
		// merge the traces of all tenants
		// write the header in the file of the merge traces
		try {
			csvWriter = new FileWriter(inputDir+"\\CAB_traces_SUT"+Integer.toString(SUTNumber)+".csv"); //query_stream_id,query_id,start,relative_start,query_duration,query_duration_with_queue,start_delay
			//write the file header
			csvWriter.append("query_stream_id");
			csvWriter.append(";");
			csvWriter.append("query_id");
			csvWriter.append(";");
			csvWriter.append("start");
			csvWriter.append(";");
			csvWriter.append("relative_start");
			csvWriter.append(";");
			csvWriter.append("query_duration");
			csvWriter.append(";");
			csvWriter.append("query_duration_with_queue");
			csvWriter.append(";");
			csvWriter.append("start_delay");
			csvWriter.append("\n");
		} catch (IOException ie) {
			System.out.println(ie);
		} finally {

		}
		
		for(int i=0; i<NbTraces; i++) {
			// add the traces of each tenant into the merged file	
			try {
				// load data from the input file into the relation InitialTraces
				csvReader = new BufferedReader(new FileReader(inputDir+"Seperated\\CAB_traces"+i+".csv"));
				
				//skip the file header
				String row = csvReader.readLine();
				while ((row = csvReader.readLine()) != null) {
					row = row.replaceAll(",", ";");
					csvWriter.append(row);
					csvWriter.append("\n");
				}
				csvReader.close();
			}catch (IOException ie) {
				System.out.println(ie);
			} 
		}
		
		try {
			csvWriter.flush();
			csvWriter.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void main(String args[]) throws SQLException {
		MergeCABTraces(3, "files\\CABTraces\\SUT3", 20, "files\\CABTraces\\SUT3");
		System.out.println("Traces for SUT3 merged.");
		MergeCABTraces(4, "files\\CABTraces\\SUT4", 20, "files\\CABTraces\\SUT4");
		System.out.println("Traces for SUT4 merged.");
	}
}
