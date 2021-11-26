#' Clean Money
#'
#' This function cleans alpha-numeric financial responses of common notation used when participants are approximating their responses.
#' @param x a vector
#' @param transform a logical statement. If TRUE, this will transcribe responses with 'k' into thousands
#' @export

clean_money <- function(x,transform){

  x <- tolower(x)

  if(transform==F)
  clean <- stringi::stri_replace_all_fixed(x,
      pattern=c("$","<",">","~","+","?","??",
                "less than","greater than","minimum","min.","min","maximum","max.","max",
                "approximately","aproximately","approx.","aprox.","approx","aprox",
                "about","around","roughly"),
      replacement="",vectorize_all=F)
  if(transform==T)
  cleaned <- gsub("[k]$","000",x,ignore.case=T)
  clean <- stringi::stri_replace_all_fixed(cleaned,
    pattern=c("$","<",">","~","+","?","??",
              "less than","greater than","minimum","min.","min","maximum","max.","max",
              "approximately","aproximately","approx.","aprox.","approx","aprox",
              "about","around","roughly"),
    replacement="",vectorize_all=F)

  clean <- gsub(" ","",clean)
  is.str.dat <- stringi::stri_detect_regex(clean, "[:alpha:]")
  clean <- ifelse(is.str.dat==FALSE, clean, x)
  return(clean)
}
