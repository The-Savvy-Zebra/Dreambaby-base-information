

startTextInBlue <- function(input_text) {
  cat(paste0("Extraction of ",input_text, " [",blue("Ongoing"),"]\r"))
}

stopTextInGreen <- function(input_text) {
  cat(paste0("Extraction of ",input_text, " [ ",green("Done"),"  ]\n"))
}