#include <Rcpp.h>
#include <iostream>
#include <fstream>
#include <vector>
#include <string>

using namespace Rcpp;
using namespace std;

//' Write data to a fastq file.
//' 
//' @param df The dataframe of sequence data to write to file. The dataframe must
//' contain the columns: "header", "sequence", "strand", and "qual". 
//' Other columns in the dataframe are permitted but will be ignored.
//' @param path Path or connection to write to.
//' 
//' @examples
//' fastq_ex_dat = data.frame(
//'     header = c("seq1", "seq2", "seq3"),
//'     sequence = c("ATGC", "AATTGGCC", "TGACTGAC"),
//'     strand = c("+", "+","+"),
//'     qual = c("~~ua", "~AZ~ngZO", "lvykl~Qv"),
//'     stringsAsFactors = FALSE)
//' data = write_fastq(fastq_ex_dat, "example_output.fastq")
//' @return NULL
//' 
// [[Rcpp::export]]
void write_fastq(DataFrame df, std::string path){

	StringVector headers = df["header"];
	StringVector sequences = df["sequence"];
	StringVector strands = df["strand"];
	StringVector quals = df["qual"];

	ofstream out; // define and empty output stream, not associated with a file
	out.open(path); //can then use open to assoicate with a file

	// a call to open may fail, so need to have a check of out before doing work on it
	if (out){
		for(int i = 0; i < headers.size(); i++){

			string outstring;
			
			outstring = "@" + headers[i] + "\n" +
						sequences[i] + "\n" +
						strands[i] + "\n" +
						quals[i] + "\n";

			out << outstring;
		}
	}
	//need to close at the end to associate with other files
	out.close();
}