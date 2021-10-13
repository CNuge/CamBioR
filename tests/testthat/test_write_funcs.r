
library(CamBioR)

test_that("Files are written properly.", {


df = data.frame(header = c("seq1", "seq2", "seq3"),
				sequence = c("ATGCA", "AAATGGCAAGC", "CTCTCTCTCTAAAAGGG"),
				stringsAsFactors = FALSE)

#for testing from the source code
#Rcpp::sourceCpp('src/write_fasta.cpp')


write_fasta(df, 'out.fa')


#for testing from the source code
#Rcpp::sourceCpp('src/write_fastq.cpp')

df = data.frame(header = c("seq1", "seq2", "seq3"),
				sequence = c("ATGCA", "AAATGGCAAGC", "CTCTCTCTCTAAAAGGG"),
				strand = c("+", "-", "+"),
				qual = c("##~!", "!!@@$^##%^", "!)!))@#@#!!"),
				stringsAsFactors = FALSE)


write_fastq(df, 'out.fq')
