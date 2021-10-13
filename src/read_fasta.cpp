#include <Rcpp.h>
#include <iostream>
#include <fstream>
#include <vector>
#include <string>

using namespace Rcpp;
using namespace std;

//' Read in raw data from a fasta file.
//' 
//' @param filename The name of the fasta file to read data from.
//'
//' @examples
//' fastq_example_file = system.file('extdata/small_unittest.fasta', 
//'                                   package = 'bioreadr')
//' data = read_fastq(fastq_example_file)
//' @return returns a dataframe with the columns: 
//' "header", "sequence"
//' 
// [[Rcpp::export]]
DataFrame read_fasta(std::string filename){

	//StringVector is an Rcpp class, can also use vanilla cpp string vectors too!
	vector<string> headers;
	vector<string> sequences;

	std::ifstream input(filename);
	if(!input.good()){
		std::cerr << "Error opening file: " << filename << endl;		
	}

	// initiate the strings for processing the input
	std::string line, name, content;
	// iterate through the file, getting lines y
	while( std::getline(input, line).good()){
		// check if currently no entry, or if newline has the start flag
		if(line.empty() || line[0] == '>'){
			// if existing entry, send it to the needed location
			if( !name.empty()){
				//two components are added to two vectors separately (will be df cols)
				headers.push_back(name);
				sequences.push_back(content);
			}
			// set the name to the current line, less the leading >
			if( !line.empty()){
				name = line.substr(1); // after building record, take newline and override the field
			}
		} else if (!name.empty()){ // append sequence, only if there is a name it goes with
			if (line.find(' ') != std::string::npos){// halt if spaces in sequence
				name.clear();
				content.clear();
			}else {
				content += line;
			}	
		} 
	}
	// this block handles the last entry remaining when end of file is reached
	if ( !name.empty() ){
		headers.push_back(name);
		sequences.push_back(content);
	}

	//this creates an R dataframe from the two vectors of strings.
	//also includes the stringsAsFactors = flase flag to control the r data type
	DataFrame out = DataFrame::create(
		_["header"] = headers,
		_["sequence"] = sequences,
		_["stringsAsFactors"] = false);
	
	return out;
}

/*
//note this is equivalent to above, not sure on preferred syntax yet:

DataFrame out = DataFrame::create(
	Named("header") = headers,
	Named("sequence") = sequences,
	Named("stringsAsFactors") = false);
*/
