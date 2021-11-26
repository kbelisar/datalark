#' RANGE CALC
#'
#' This function identifies numeric responses given as a range between two numbers as denoted by a dash symbol "-",
#' whilst maintaining both numeric and alpha-numeric responses that are not a range.
#' This allows for data integrity to be maintained, so that alpha-numeric responses can be cleaned
#' separately depending on the nature of the response.
#' @param x a vector
#' @examples
#' \dontrun{
#' x <- c("20-24","idk,10-15","o-40","15-20","10+")
#' range.calc(x)
#' print(x)
#' [1] "22"   "idk,10-15"   "o-40"  "17.5"  "10+"
#' }
#' @export

range_calc <- function(x){
  is.range <- (grepl("-",x))
  is.range <- ifelse(is.range==T & grepl("[aeiou]",x),F,is.range)
  is.num1 <- ifelse(grepl("^[[:digit:]]",x),T,F)
  is.num2 <- ifelse(grepl("[[:digit:]]$",x),T,F)
  is.range <- ifelse(is.num1==F | is.num2==F,F,is.range)
  xx <- as.data.frame(x)
  xx$is.range <- is.range
  xx$row <- 1:NROW(xx)
  range <- as.data.frame(xx[(xx$is.range==T),])
  range <- stringi::stri_split_fixed(range$x,"-",omit_empty = T)
  range1 <- as.numeric(lapply(range,`[[`, 1))
  range2 <- as.numeric(lapply(range,`[[`, 2))
  range.avg <- mapply("+", range1, range2, SIMPLIFY=F)
  range.avg <- as.numeric(range.avg)/2
  xx$x[xx$is.range==T] <- range.avg
  return(xx$x)
}




