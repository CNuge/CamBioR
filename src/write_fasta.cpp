#include <Rcpp.h>
#include <iostream>
#include <fstream>
#include <vector>
#include <string>

using namespace Rcpp;
using namespace std;

//' Write data to a fasta file.
//' 
//' @param df The dataframe of sequence data to write to file. The dataframe must
//' contain the columns: "header" and "sequence". Other columns in the dataframe
//' are permitted but will be ignored.
//' @param path Path or connection to write to.
//'
//' @examples
//' fasta_ex_dat = data.frame(
//'     header = c("seq1", "seq2", "seq3"),
//'     sequence = c("ATGC", "AATTGGCC", "TGACTGAC"),
//'     stringsAsFactors = FALSE
//'     )
//' data = write_fasta(fasta_ex_dat, "example_output.fasta")
//' @return NULL
//' 
// [[Rcpp::export]]
void write_fasta(DataFrame df, std::string path){

	//add checks here to make sure the df has the sequence and header columns
	StringVector headers = df["header"];
	StringVector seqs = df["sequence"];

	ofstream out; // define and empty output stream, not associated with a file
	out.open(path); //can then use open to assoicate with a file

	// a call to open may fail, so need to have a check of out before doing work on it
	if (out){
		for(int i = 0; i < headers.size(); i++){

			string outstring;

			outstring = ">" + headers[i] + "\n" + seqs[i] + "\n";

			out << outstring;
		}
	}
	//need to close at the end to associate with other files
	out.close();
}