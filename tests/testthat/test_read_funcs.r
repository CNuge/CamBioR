test_that("Files are read in properly.", {

  fq_exp_df = data.frame(
    header = c("example_read_1", "example_read_2"),
    sequence = c("gttcaacaaatcataaagatattggaattctatacttt", "attcaaccaatcataaagatattggaactctatattttattttcggagcatgatctggaataattgg"),
    strand = c("+", "+"),
    qual = c("~~y~~~~~~Q~~~~~~q~~~~~~~~~`~~~~~~~~~~i", "~Ts~~~~~~~~~p~~~~~~~a~~~~~~~~~~~~~~~~~~z~~~~~~y~~~~~~~~~~~~~~~~~~~~"),
    stringsAsFactors = FALSE)

  fastq_test_file = system.file('extdata/small_unittest.fastq', package = 'CamBioR')
  fq_test = read_fastq(fastq_test_file)

  #all.equal(dim(fq_test), c(2,4))
  expect_equal(all.equal(dim(fq_test), c(2,4)), TRUE)

  #all.equal(names(fq_test) ,  c("header", "sequence", "strand", "qual"))
  expect_equal(all.equal(names(fq_test) ,  c("header", "sequence", "strand", "qual")), TRUE)

  #all.equal(fq_test, fq_exp_df)
  expect_equal(all.equal(fq_test, fq_exp_df))

  fa_exp_df = data.frame(
    header = c("example_read_1","example_read_2"),
    sequence = c("ggggggtggagacccaattctttatcaacatctattctgattttttggacatccatgaagttta", "tattttttatatcaacatctattttgattttttggtcaccctgaagttta"),
    stringsAsFactors = FALSE)

  fasta_test_file = system.file('extdata/small_unittest.fasta', package = 'CamBioR')
  fa_test = read_fasta(fasta_test_file)

  #all.equal(dim(fa_test), c(2,2))
  expect_equal(all.equal(dim(fa_test), c(2,2)), TRUE)

  #all.equal(names(fa_test) ,  c("header", "sequence"))
  expect_equal(all.equal(names(fq_test) ,  c("header", "sequence")), TRUE)

  #all.equal(fq_test, fq_exp_df)
  expect_equal(all.equal(fa_test, fa_exp_df))

})
