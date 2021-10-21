# table 1 here - https://www.researchgate.net/publication/281176574_Influence_of_Feature_Encoding_and_Choice_of_Classifier_on_Disease_Risk_Prediction_in_Genome-Wide_Association_Studies/figures?lo=1
# there are three ways to do it
# for gwas, 0,1,2 seems best

#####################################
# Encode SNP data for machine learning
#####################################


get_unique_alleles = function(snp_table){
  unique_alleles = list()

  for(x in names(snp_table)){

    for (a in strsplit(x, " ")[[1]]){
      if( a %in% names(unique_alleles)){
        unique_alleles[[a]] =  unique_alleles[[a]] + snp_table[[x]]
      }else{
        unique_alleles[[a]] =  snp_table[[x]]
      }
    }

  }
  if(length(unique_alleles) > 2){
    stop("SNP is not biallelic")
  }
  if(length(unique_alleles) == 1){
    stop("SNP is homozygous")
  }
  if(unique_alleles[[1]] >= unique_alleles[[2]]){
    return(list("p" = names(unique_alleles)[[1]], "q" = names(unique_alleles)[[2]]))
  }else{
    return(list("p" = names(unique_alleles)[[2]], "q" = names(unique_alleles)[[1]]))
  }

}

#' Homozygous for major allele encoded as 0, heterozygoous = 1, Homozygous minor allele = 2
#' method - make it so you can do one hot, dosage, or presence/absence. currently just dosage
#' missing_data - can put in the mode or NA
encode_dosage_snp_vec = function(snp_vec, method = "dosage", missing_val = "0 0", replace_missing_method = "mode"){
  #determine the major and minor alleles

  if(replace_missing_method == "mode"){

    #replace the missing
    counts = table(snp_vec)

    mode = names(counts[length(counts)])
    if(mode == missing_val){
      warning("most common allele is a missing genotype!")
      mode = names(counts[length(counts)-1])
    }
    snp_vec = replace(snp_vec, snp_vec == missing_val, mode)

  }

  snp_counts = table(snp_vec)
  print(snp_counts)
  alleles = get_unique_alleles(snp_counts)
  p = alleles$p
  q = alleles$q

  AA = paste(p, p)
  AB = paste(p, q)
  BA = paste(q, p) #do this in either order to account for when the major allele here != the major allele from plink
  BB = paste(q, q)

  encodings = c(0, 1, 1, 2)
  names(encodings) = c(AA, AB, BA, BB)

  return(unlist(lapply(snp_vec, function(x){encodings[[x]] })))

}



#'
#' method - make it so you can do one hot, dosage, or presence/absence. currently just dosage
encode_ped = function(snp_data, snp_columns, method = "dosage" ){
  #x = snp_columns[[2]]
  for(x in snp_columns){
    print(x)
    snp_data[[x]] = encode_dosage_snp_vec(snp_data[[x]])
  }

  return(snp_data)
}



#TODO - make a unit test of this

#read in the example data
#ped_file = 'example_plink.ped'
#map_file = 'example_plink.map'
#snp_data = readPedMap_tsv_fmt(ped_file, map_file)
#snp_columns = names(snp_data)[7:length(names(snp_data))]
#snp_data = encode_ped(snp_data, snp_columns)

#snp_data$`AX-181936597`
#
#snp_data$`AX-181936597`
