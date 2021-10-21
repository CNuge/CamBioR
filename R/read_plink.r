library(tidyverse)

readPedMap_tsv_fmt = function(ped_file, map_file = "", headers = FALSE){
  if(headers == TRUE){
    #
    map_data = read_tsv(map_file, skip = 1, col_names = c("chromosome", "snp" , "genetic_distance", "physical_distance"))

    header_data = c('#family', 'individual', 'sire', 'dam', 'sex', 'pheno')
    header_data = c(header_data, map_data$snp)

    snp_data = read_tsv(ped_file, skip = 1, col_names = header_data)
    return(snp_data)

  }else{

    map_data = read_tsv(map_file, col_names = c("chromosome", "snp" , "genetic_distance", "physical_distance"))

    header_data = c('#family', 'individual', 'sire', 'dam', 'sex', 'pheno')
    header_data = c(header_data, map_data$snp)

    snp_data = read_tsv(ped_file, col_names = header_data)
    return(snp_data)
  }

}


#TODO - make a unit test of this
#ped_file = 'plink_file_revisit/poly_nl_dat.ped'
#map_file = 'plink_file_revisit/poly_nl_dat.map'

#snp_data = readPedMap_tsv_fmt(ped_file, map_file)
