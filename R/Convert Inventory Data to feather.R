source("R/Load Libraries.R")
source("R/References.R")



file_names <-
  list.files("Data") %>%
  tibble() %>%
  clean_names() %>%
  filter(str_detect(x, "Raw data")) %>%
  filter(!str_detect(x, "~")) %>%
  mutate(x = paste0("Data/", x))

for (x in 1:NROW(file_names)) {
  
  cat(paste0("Looking at the tabs in file ",file_names$x[x],"\b"))
  
  file_name <- file_names$x[x]
  sheet_names = getSheetNames(file_name)
  
  
  for (i in 1:NROW(sheet_names)) {
    startTextInBlue(paste0("File->",file_name," - Extracting Sheet:", sheet_names[i]))

    
    sheet_nr <- which(getSheetNames(file_name) ==
                        sheet_names[i])
    
    
    raw_data <-
      read.xlsx(
        xlsxFile = file_name,
        sheet = sheet_nr,
        colNames = FALSE,
        detectDates = TRUE
      ) %>%
      as_tibble(.name_repair = "universal")
    
    output_filename <- str_remove(file_name, ".xlsx")
    
    feather::write_feather(raw_data,
                           paste0("Temp/", file_name, "-", sheet_names[i], ".feather"))
    stopTextInGreen(paste0("File->",file_name," - Extracting Sheet:", sheet_names[i]))
    
  }
  
}

#######
# Debug
if (FALSE) {

  list.files("Data") %>%
    tibble() %>%
    clean_names() %>%
    filter(str_detect(x,"Raw data")) %>%
    filter(!str_detect(x,"~"))
  
}
