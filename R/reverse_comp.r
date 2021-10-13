#' Return the reverse compliment for a DNA sequence.
#' @keywords internal
rev_comp = function(x){
  return(seqinr::c2s(rev(seqinr::comp(seqinr::s2c(x)))))
}
