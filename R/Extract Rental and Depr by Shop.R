source("R/Load Libraries.R")
source("R/References.R")

file_name <- "Data/Rolling forward Expansie DB - update OKTOBER 2023 (versie Lowiese).xlsx"
sheet_name = "gebouwkosten"

sheet_nr <- which(getSheetNames(file_name) ==
                    sheet_name)

last_column = 143 # Oct 2023

raw_data <-
  read.xlsx(xlsxFile = file_name,
            sheet = sheet_nr,
            detectDates = TRUE,
            startRow = 2,
            cols = 1:(last_column+1)) %>%
  as_tibble() %>%
  pivot_longer(cols = 4:last_column,names_to = "date", values_to = "rental_depreciation") %>%
  
  # Convert the dates
  mutate(date = excel_numeric_to_date(as.numeric(as.character(date)), date_system = "modern")) %>%
  
  # Make the cost numbers all positive
  mutate(rental_depreciation = abs(rental_depreciation)) %>%
  
  filter(!is.na(rental_depreciation)) %>%
  mutate(shop = str_trim(str_remove(omschrijving,"DREAMBABY"),"both")) %>%
  
  # Remove closed shops
  left_join(shops_activity,by = join_by(shop)) %>%
  filter(actief|!is.na(actief)) %>%
  
  # Make the names readable
  rename(kostenplaats = kplt,
         winkel = omschrijving,
         region = regio) %>%
  
  # put the columns in a logical order
  select(date,kostenplaats, region,  winkel, shop , rental_depreciation)

raw_data


write_feather(raw_data,"shop_rental_depreciation.feather")


