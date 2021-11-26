#' CLEAN MEASURES
#'
#' This function cleans responses of written units of measurement - specifically
#' units of type minutes, hours, months, years, ounces, grams, kilograms, or pounds. Participants, when given
#' the option of providing an alpha-numeric response, sometimes give their written response with the unit of
#' measurement included. This function includes the argument 'symbols' which will clean the most common notion
#' used by participants when approximating their responses.
#' @param x a vector
#' @param type one of c("minutes", "hours", "days", "weeks", "months", "years", "grams", "ounces", "kg", "lbs", "cms", "inches")
#' @param symbols a logical statement. If true, symbols of measurement such as '>','<','+' or '~', will be cleaned
#' @export


clean_measures <- function(x, type, symbols){

  x <- tolower(x)

  if(type =="minutes" & symbols == T)
    clean <- stringi::stri_replace_all_fixed(x,
      pattern = c("minutes","minute","mins.","mins","minimum","min.","min",
      "<",">","~","+","?","??","less than","greater than","maximum","max.","max",
      "approximately","aproximately","approx.","aprox.","approx","aprox",
      "about","around","roughly"),
       replacement="", vectorize_all=F)
  if(type == "hours" & symbols == T)
    clean <- stringi::stri_replace_all_fixed(x,
        pattern = c("hours","hour","hrs.","hrs","hr.","hr",
                    "<",">","~","+","?","??","less than","greater than",
                    "minimum","min.","min","maximum","max.","max",
                    "approximately","aproximately","approx.","aprox.","approx","aprox",
                    "about","around","roughly"),
        replacement = "", vectorize_all = F)
  if(type == "months" & symbols == T)
      clean <- stringi::stri_replace_all_fixed(x,
      pattern = c("months","month","mo.","mo",
                  "<",">","~","+","?","??","less than","greater than",
                  "minimum","min.","min","maximum","max.","max",
                  "approximately","aproximately","approx.","aprox.","approx","aprox",
                  "about","around","roughly"),
      replacement = "",vectorize_all = F)
  if(type == "years" & symbols == T)
    clean <- stringi::stri_replace_all_fixed(x,
     pattern = c("years","year","yrs.","yrs","yr.","yr",
                 "<",">","~","+","?","??","less than","greater than",
                 "minimum","min.","min","maximum","max.","max",
                 "approximately","aproximately","approx.","aprox.","approx","aprox",
                 "about","around","roughly"),
     replacement = "", vectorize_all = F)
  if(type =="weeks" & symbols == T)
    clean <- stringi::stri_replace_all_fixed(x,
      pattern = c("weeks","week","wks.","wks","wk.","wk",
                "<",">","~","+","?","??","less than","greater than",
                "minimum","min.","min","maximum","max.","max",
                "approximately","aproximately","approx.","aprox.","approx","aprox",
                "about","around","roughly"),
      replacement="", vectorize_all=F)
  if(type =="days" & symbols == T)
    clean <- stringi::stri_replace_all_fixed(x,
      pattern = c("days","day",
                "<",">","~","+","?","??","less than","greater than",
                "minimum","min.","min","maximum","max.","max",
                "approximately","aproximately","approx.","aprox.","approx","aprox",
                "about","around","roughly"),
      replacement = "", vectorize_all = F)
  if(type =="ounces" & symbols == T)
    clean <- stringi::stri_replace_all_fixed(x,
    pattern = c("ounces","ounce","oz.","oz",
              "<",">","~","+","?","??","less than","greater than",
              "minimum","min.","min","maximum","max.","max",
              "approximately","aproximately","approx.","aprox.","approx","aprox",
              "about","around","roughly"),
     replacement = "", vectorize_all = F)
  if(type =="grams" & symbols == T)
    clean <- stringi::stri_replace_all_fixed(x,
    pattern = c("grams","gram","g",
              "<",">","~","+","?","??","less than","greater than",
              "minimum","min.","min","maximum","max.","max",
              "approximately","aproximately","approx.","aprox.","approx","aprox",
              "about","around","roughly"),
    replacement = "", vectorize_all = F)
  if(type =="kg" & symbols == T)
    clean <- stringi::stri_replace_all_fixed(x,
    pattern = c("kilograms","kilogram","kilos","kilo","kgs.","kg",
              "<",">","~","+","?","??","less than","greater than",
              "minimum","min.","min","maximum","max.","max",
              "approximately","aproximately","approx.","aprox.","approx","aprox",
              "about","around","roughly"),
    replacement = "", vectorize_all = F)
  if(type =="lbs" & symbols == T)
    clean <- stringi::stri_replace_all_fixed(x,
    pattern = c("pounds","pound","lbs.","lbs","lb.","lb",
              "<",">","~","+","?","??","less than","greater than",
              "minimum","min.","min","maximum","max.","max",
              "approximately","aproximately","approx.","aprox.","approx","aprox",
              "about","around","roughly"),
              replacement = "", vectorize_all = F)
  if(type =="inches" & symbols == T)
    clean <- stringi::stri_replace_all_fixed(x,
     pattern = c("inches","inch","in.","in",
              "<",">","~","+","?","??","less than","greater than",
              "minimum","min.","min","maximum","max.","max",
              "approximately","aproximately","approx.","aprox.","approx","aprox",
              "about","around","roughly"),
      replacement = "", vectorize_all = F)
  if(type =="cms" & symbols == T)
    clean <- stringi::stri_replace_all_fixed(x,
      pattern = c("centimetres","centimeters","cms.","cms","cm.","cm",
                "<",">","~","+","?","??","less than","greater than",
                "minimum","min.","min","maximum","max.","max",
                "approximately","aproximately","approx.","aprox.","approx","aprox",
                "about","around","roughly"),
      replacement = "", vectorize_all = F)
  if(type == "minutes" & symbols == F)
    clean <- stringi::stri_replace_all_fixed(x,
      pattern = c("minutes","minute","mins.","mins","min.","min"),
      replacement = "", vectorize_all = F)
  if(type == "hours" & symbols == F)
      clean <- stringi::stri_replace_all_fixed(x,
      pattern = c("hours","hour","hrs.","hrs","hr.","hr"), replacement = "", vectorize_all = F)
  if(type == "months" & symbols == F)
      clean <- stringi::stri_replace_all_fixed(x,
      pattern = c("months","month","mo.","mo"), replacement = "", vectorize_all = F)
  if(type == "years" & symbols == F)
    clean <- stringi::stri_replace_all_fixed(x,
    pattern = c("years","year","yrs.","yrs","yr.","yr"), replacement = "", vectorize_all = F)
  if(type == "weeks" & symbols == F)
    clean <- stringi::stri_replace_all_fixed(x,
    pattern = c("weeks","week","wks.","wks","wk.","wk"), replacement = "", vectorize_all = F)
  if(type == "days" & symbols == F)
    clean <- stringi::stri_replace_all_fixed(x,
    pattern = c("days","day"), replacement = "", vectorize_all = F)
  if(type == "ounces" & symbols == F)
    clean <- stringi::stri_replace_all_fixed(x,
    pattern = c("ounces","ounce","oz.","oz"), replacement = "", vectorize_all = F)
  if(type == "grams" & symbols == F)
    clean <- stringi::stri_replace_all_fixed(x,
    pattern = c("grams","gram","g"), replacement = "", vectorize_all = F)
  if(type == "kg" & symbols == F)
    clean <- stringi::stri_replace_all_fixed(x,
    pattern = c("kilograms","kilogram","kilos","kilo","kgs.","kg"), replacement = "", vectorize_all = F)
  if(type == "lbs" & symbols == F)
    clean <- stringi::stri_replace_all_fixed(x,
    pattern = c("pounds","pound","lbs.","lbs","lb.","lb"), replacement = "", vectorize_all = F)
  if(type == "inches" & symbols == F)
    clean <- stringi::stri_replace_all_fixed(x,
    pattern = c("inches","inch","in.","in"), replacement = "", vectorize_all = F)
  if(type == "cms" & symbols == F)
    clean <- stringi::stri_replace_all_fixed(x,
    pattern = c("centimeters","centimetres","cms.","cms","cm.","cm"), replacement = "", vectorize_all = F)

  # Need to identify strings that cannot be cleaned so that they remain unchanged
  clean <- gsub(" ","",clean)
  is.str.dat <- stringi::stri_detect_regex(clean, "[:alpha:]")
  clean <- ifelse(is.str.dat==FALSE, clean, x)
  return(clean)
}

