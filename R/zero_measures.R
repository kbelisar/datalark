#' ZERO MEASURE
#'
#' This function transcribes responses of "zero", "none", or "null" to the numeric equivalent of "0".
#' It also includes the argument 'include.na' to transcribe responses of "NA" to zero, whilst maintaining NA for true missing values.
#' @param x a vector
#' @param include.na a logical vector. If TRUE, responses entered as NA responses will be removed.
#' @export

zero_measures <- function(x, include.na){

  x <- tolower(x)

  if(include.na==F)
    zeroes <- stringi::stri_replace_all_fixed(x,
                                              pattern=c("zero","none","null"),
                                              replacement="0",vectorize_all=F)
  if(include.na==T)
    zeroes <- stringi::stri_replace_all_fixed(x,
                                              pattern=c("zero","none","null",
                                                        "n.a.","n.a","n/a","na"),
                                              replacement="0",vectorize_all=F)
  return(zeroes)
}
