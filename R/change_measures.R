#' CHANGE MEASURES
#'
#' This function identifies measurements in different units and transforms them accordingly.
#' Specifically, when participants are given instructions to give their response in a specific unit,
#' and they give another (by denoting this other unit), this function identifies these responses,
#' and transforms them accordingly (1-unit magnitudes only, ex. months to years or weeks, not to minutes).
#' @param x a vector
#' @param from the current unit of x. One of: c("years","months","weeks","days","minutes","hours","kg","lbs","grams","ounces")
#' @param to the unit to change to. One of: c("years","months","weeks,"days","minutes","hours","kg","lbs","grams","ounces")
#' @export


change_measures <- function(x, from, to){

  x <- tolower(x)

  if(from=="years" & to=="months"){
    df1 <- as.data.frame(x)
  df1$is.year <- grepl("years|year",df1$x)
  df1$is.year <- ifelse(grepl("[bcdfghijklmnopqtuvwxz]",df1$x),F,df1$is.year)
  df1$x[df1$is.year==T] <- gsub("years|year","",df1$x[df1$is.year==T])
  df1$x[df1$is.year==T] <- gsub(" ","",df1$x[df1$is.year==T])
  df1$row <- 1:NROW(df1)
  change1 <- df1[(df1$is.year==T),]
  change1$val <- as.numeric(change1$x)*12
  df1$x[df1$is.year==T] <- change1$val
  return(df1$x)
  } else if(from=="months" & to=="years"){
    df2 <- as.data.frame(x)
  df2$is.month <- grepl("months|month",df2$x)
  df2$is.month <- ifelse(grepl("[abcdefgijklpqruvwxyz]",df2$x),F,df2$is.month)
  df2$x[df2$is.month==T] <- gsub("months|month","",df2$x[df2$is.month==T])
  df2$x[df2$is.month==T] <- gsub(" ","",df2$x[df2$is.month==T])
  df2$row <- 1:NROW(df2)
  change2 <- df2[(df2$is.month==T),]
  change2$val <- as.numeric(change2$x)/12
  df2$x[df2$is.month==T] <- change2$val
  return(df2$x)
  } else if(from=="minutes" & to=="hours"){
    df3 <- as.data.frame(x)
  df3$is.minute <- grepl("minutes|minute|min.|min",df3$x)
  df3$is.minute <- ifelse(grepl("[abcdfghjklnopqrvwxyz]",df3$x),F,df3$is.minute)
  df3$x[df3$is.minute==T] <- gsub("minutes|minute|min.|min","",df3$x[df3$is.minute==T])
  df3$x[df3$is.minute==T] <- gsub(" ","",df3$x[df3$is.minute==T])
  df3$row <- 1:NROW(df3)
  change3 <- df3[(df3$is.minute==T),]
  change3$val <- as.numeric(change3$x)/60
  df3$x[df3$is.minute==T] <- change3$val
  return(df3$x)
  } else if(from=="hours" & to=="minutes") {
      df4 <- as.data.frame(x)
    df4$is.hour <- grepl("hours|hour|hrs.|hrs|hr",df4$x)
    df4$is.hour <- ifelse(grepl("[abcdefgijklmnpqtvwxyz]",df4$x),F,df4$is.hour)
    df4$x[df4$is.hour==T] <- gsub("hours|hour|hrs.|hrs|hr","",df4$x[df4$is.hour==T])
    df4$x[df4$is.hour==T] <- gsub(" ","",df4$x[df4$is.hour==T])
    df4$row <- 1:NROW(df4)
    change4 <- df4[(df4$is.hour==T),]
    change4$val <- as.numeric(change4$x)*60
    df4$x[df4$is.hour==T] <- change4$val
    return(df4$x)
  } else if(from=="days" & to=="weeks") {
      df5 <- as.data.frame(x)
    df5$is.day <- grepl("days|day",df5$x)
    df5$is.day <- ifelse(grepl("[bcefghijklmnopqrtuvwxz]",df5$x),F,df5$is.day)
    df5$x[df5$is.day==T] <- gsub("days|day","",df5$x[df5$is.day==T])
    df5$x[df5$is.day==T] <- gsub(" ","",df5$x[df5$is.day==T])
    df5$row <- 1:NROW(df5)
    change5 <- df5[(df5$is.day==T),]
    change5$val <- as.numeric(change5$x)/7
    df5$x[df5$is.day==T] <- change5$val
    return(df5$x)
  } else if(from=="weeks" & to=="days") {
      df6 <- as.data.frame(x)
    df6$is.week <- grepl("weeks|week",df6$x)
    df6$is.week <- ifelse(grepl("[abcdfghijlmnopqrtuvxyz]",df6$x),F,df6$is.week)
    df6$x[df6$is.week==T] <- gsub("weeks|week","",df6$x[df6$is.week==T])
    df6$x[df6$is.week==T] <- gsub(" ","",df6$x[df6$is.week==T])
    df6$row <- 1:NROW(df6)
    change6 <- df6[(df6$is.week==T),]
    change6$val <- as.numeric(change6$x)*7
    df6$x[df6$is.week==T] <- change6$val
    return(df6$x)
  } else if(from=="kg" & to=="lbs") {
      df7 <- as.data.frame(x)
    df7$is.kg <- grepl("kgs|kg",df7$x)
    df7$is.kg <- ifelse(grepl("[abcdefhijlmnopqrtuvwxyz]",df7$x),F,df7$is.kg)
    df7$x[df7$is.kg==T] <- gsub("kgs|kg","",df7$x[df7$is.kg==T])
    df7$x[df7$is.kg==T] <- gsub(" ","",df7$x[df7$is.kg==T])
    df7$row <- 1:NROW(df7)
    change7 <- df7[(df7$is.kg==T),]
    change7$val <- as.numeric(change7$x)*2.2
    df7$x[df7$is.kg==T] <- change7$val
    return(df7$x)
  } else if(from=="lbs" & to=="kg") {
    df8 <- as.data.frame(x)
    df8$is.lb <- grepl("lbs|lb",df8$x)
    df8$is.lb <- ifelse(grepl("[acdefghijkmnopqrtuvwxyz]",df8$x),F,df8$is.lb)
    df8$x[df8$is.lb==T] <- gsub("lbs|lb","",df8$x[df8$is.lb==T])
    df8$x[df8$is.lb==T] <- gsub(" ","",df8$x[df8$is.lb==T])
    df8$row <- 1:NROW(df8)
    change8 <- df8[(df8$is.lb==T),]
    change8$val <- as.numeric(change8$x)/2.2
    df8$x[df8$is.lb==T] <- change8$val
    return(df8$x)
  } else if(from=="grams" & to=="ounces") {
    df9 <- as.data.frame(x)
    df9$is.gram <- grepl("grams|gram|g",df9$x)
    df9$is.gram <- ifelse(grepl("[bcdefhijklnopqtuvwxyz]",df9$x),F,df9$is.gram)
    df9$x[df9$is.gram==T] <- gsub("grams|gram|g","",df9$x[df9$is.gram==T])
    df9$x[df9$is.gram==T] <- gsub(" ","",df9$x[df9$is.gram==T])
    df9$row <- 1:NROW(df9)
    change9 <- df9[(df9$is.gram==T),]
    change9$val <- as.numeric(change9$x)/28.34952
    df9$x[df9$is.gram==T] <- change9$val
    return(df9$x)
  } else if(from=="ounces" & to=="grams") {
    df10 <- as.data.frame(x)
    df10$is.oz <- grepl("ounces|ounce|oz",df10$x)
    df10$is.oz <- ifelse(grepl("[abdfghijklmpqrtvwxy]",df10$x),F,df10$is.oz)
    df10$x[df10$is.oz==T] <- gsub("ounces|ounce|oz","",df10$x[df10$is.oz==T])
    df10$x[df10$is.oz==T] <- gsub(" ","",df10$x[df10$is.oz==T])
    df10$row <- 1:NROW(df10)
    change10 <- df10[(df10$is.oz==T),]
    change10$val <- as.numeric(change10$x)*28.34952
    df10$x[df10$is.oz==T] <- change10$val
    return(df10$x)
  } else if(from=="months" & to=="weeks"){
    df11 <- as.data.frame(x)
    df11$is.month <- grepl("months|month",df11$x)
    df11$is.month <- ifelse(grepl("[abcdefgijklpqruvwxyz]",df11$x),F,df11$is.month)
    df11$x[df11$is.month==T] <- gsub("months|month","",df11$x[df11$is.month==T])
    df11$x[df11$is.month==T] <- gsub(" ","",df11$x[df11$is.month==T])
    df11$row <- 1:NROW(df11)
    change2 <- df11[(df11$is.month==T),]
    change2$val <- as.numeric(change2$x)*4.333333
    df11$x[df11$is.month==T] <- change2$val
    return(df11$x)
  } else if(from=="weeks" & to=="months"){
    df12 <- as.data.frame(x)
    df12$is.week <- grepl("weeks|week",df12$x)
    df12$is.week <- ifelse(grepl("[abcdfghijlmnopqrtuvxyz]",df12$x),F,df12$is.week)
    df12$x[df12$is.week==T] <- gsub("weeks|week","",df12$x[df12$is.week==T])
    df12$x[df12$is.week==T] <- gsub(" ","",df12$x[df12$is.week==T])
    df12$row <- 1:NROW(df12)
    change2 <- df12[(df12$is.week==T),]
    change2$val <- as.numeric(change2$x)/4.333333
    df12$x[df12$is.week==T] <- change2$val
    return(df12$x)
  } else if(from=="days" & to=="hours"){
    df13 <- as.data.frame(x)
    df13$is.day <- grepl("days|day",df13$x)
    df13$is.day <- ifelse(grepl("[bcefghijklmnopqrtuvwxz]",df13$x),F,df13$is.day)
    df13$x[df13$is.day==T] <- gsub("days|day","",df13$x[df13$is.day==T])
    df13$x[df13$is.day==T] <- gsub(" ","",df13$x[df13$is.day==T])
    df13$row <- 1:NROW(df13)
    change2 <- df13[(df13$is.day==T),]
    change2$val <- as.numeric(change2$x)*24
    df13$x[df13$is.day==T] <- change2$val
    return(df13$x)
  } else if(from=="hours" & to=="days"){
    df14 <- as.data.frame(x)
    df14$is.hour <- grepl("hours|hour|hrs.|hrs|hr",df14$x)
    df14$is.hour <- ifelse(grepl("[abcdefgijklmnpqtvwxyz]",df14$x),F,df14$is.hour)
    df14$x[df14$is.hour==T] <- gsub("hours|hour|hrs.|hrs|hr","",df14$x[df14$is.hour==T])
    df14$x[df14$is.hour==T] <- gsub(" ","",df14$x[df14$is.hour==T])
    df14$row <- 1:NROW(df14)
    change2 <- df14[(df14$is.hour==T),]
    change2$val <- as.numeric(change2$x)/24
    df14$x[df14$is.hour==T] <- change2$val
    return(df14$x)
  } else if(from=="inches" & to=="cms"){
    df15 <- as.data.frame(x)
    df15$is.inch <- grepl("inches|inch|in.|in",df15$x)
    df15$is.inch <- ifelse(grepl("[abdfgjklmopqrtuvwxyz]",df15$x),F,df15$is.inch)
    df15$x[df15$is.inch==T] <- gsub("inches|inch|in.|in","",df15$x[df15$is.inch==T])
    df15$x[df15$is.inch==T] <- gsub(" ","",df15$x[df15$is.inch==T])
    df15$row <- 1:NROW(df15)
    change2 <- df15[(df15$is.inch==T),]
    change2$val <- as.numeric(change2$x)*2.5
    df15$x[df15$is.inch==T] <- change2$val
    return(df15$x)
  } else if(from=="cms" & to=="inches"){
    df16 <- as.data.frame(x)
    df16$is.cm <- grepl("centimeters|cms.|cms|cm.|cm",df16$x)
    df16$is.cm <- ifelse(grepl("[abdfghjklopquvwxyz]",df16$x),F,df16$is.cm)
    df16$x[df16$is.cm==T] <- gsub("centimeters|cms.|cms|cm.|cm","",df16$x[df16$is.cm==T])
    df16$x[df16$is.cm==T] <- gsub(" ","",df16$x[df16$is.cm==T])
    df16$row <- 1:NROW(df16)
    change2 <- df16[(df16$is.cm==T),]
    change2$val <- as.numeric(change2$x)/2.5
    df16$x[df16$is.cm==T] <- change2$val
    return(df16$x)
  }
}
