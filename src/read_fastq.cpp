#include <Rcpp.h>
#include <iostream>
#include <fstream>
#include <vector>

using namespace Rcpp;
using namespace std;

//' Read in data from a fastq file.
//' 
//' @param filename The name of the fastq file to read data from.
//'
//' @examples
//' fastq_example_file = system.file('extdata/small_unittest.fastq', 
//'                                   package = 'bioreadr')
//' data = read_fastq(fastq_example_file)
//' @return returns a dataframe with the columns: 
//' "header", "sequence", "strand", "qual"
//'
// [[Rcpp::export]]
DataFrame read_fastq(std::string filename){

	//initiate string vectors to grab all the different components
	vector<string> header, sequence, strand, qual;

	//catch for empty vector
	std::ifstream input(filename);
	if(!input.good()){
		std::cerr << "Error opening file: " << filename << endl;		
	}


	// keep track of which line in the seqs we are on
	int num = 0;
	// initiate the strings for processing the input
	std::string line;

	// iterate through the file, getting lines y
	while( std::getline(input, line).good()){
		if(num == 0){
			header.push_back(line);
			num++;
		}else if(num == 1){
			sequence.push_back(line);
			num++;
		}else if(num == 2){
			strand.push_back(line);
			num++;
		}else if(num == 3){
			qual.push_back(line);
			num = 0;
		}
	}

	DataFrame out = DataFrame::create(
		_["header"] = header,
		_["sequence"] = sequence,
		_["strand"] = strand,
		_["qual"] = qual,		
		_["stringsAsFactors"] = false);
	
	return out;
}