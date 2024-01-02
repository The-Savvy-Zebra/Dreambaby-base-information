######## 

source("R/Function_extract_excel_data_numeric.R")
source("R/Function_extract_excel_data_raw.R")

######## Communication to te users
startTextInBlue <- function(input_text) {
  cat(paste0("Extraction of ",input_text, " [",blue("Ongoing"),"]\r"))
}

stopTextInGreen <- function(input_text) {
  cat(paste0("Extraction of ",input_text, " [ ",green("Done"),"  ]\n"))
}