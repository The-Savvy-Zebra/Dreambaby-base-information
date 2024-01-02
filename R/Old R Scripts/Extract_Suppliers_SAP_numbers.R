source("R/Load Libraries.R")
source("R/References.R")

file_name <- "Data/leveranciers SAP nummers.xlsx"
sheet_name = "Report 1"

sheet_nr <- which(getSheetNames(file_name) ==
                    sheet_name)

raw_data <-
  read.xlsx(xlsxFile = file_name,
            sheet = sheet_nr) %>%
  as_tibble() %>%
  clean_names() %>%
  filter(!is.na(lead_supplier_name))

raw_data

# Save data to feather
write_feather(raw_data,"suppliers_SAP_number.feather")



