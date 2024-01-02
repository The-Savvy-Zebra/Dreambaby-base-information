source("R/Load Libraries.R")
source("R/References.R")

file_name <- "Data/Rolling forward Expansie DB - update OKTOBER 2023 (versie Lowiese).xlsx"
sheet_name = "personeelskost"

sheet_nr <- which(getSheetNames(file_name) ==
                    sheet_name)

last_column = 141 # Oct 2023

raw_data <-
  read.xlsx(xlsxFile = file_name,
            sheet = sheet_nr,
            detectDates = TRUE,
            rows = 48:85,
            cols = 1:(last_column+1)) %>%
  as_tibble() %>%
  pivot_longer(cols = 4:last_column,names_to = "date", values_to = "personnel_hours") %>%
  
  # Convert the dates
  mutate(date = excel_numeric_to_date(as.numeric(as.character(date)), date_system = "modern")) %>%
  
  filter(!is.na(personnel_hours)) %>%
  mutate(shop = str_trim(str_remove(omschrijving,"DREAMBABY"),"both")) %>%
  
  # Remove closed shops
  left_join(shops_activity,by = join_by(shop)) %>%
  filter(actief|!is.na(actief)) %>%
  
  # Make the names readable
  rename(kostenplaats = kplt,
         winkel = omschrijving,
         region = regio) %>%
  
  # Clean-up the rows (some shops are new)
  left_join(xref_shops,by = join_by(shop)) %>%
  group_by(kostenplaats,winkel,region,date,shop=new_shop) %>%
  summarise(personnel_hours=sum(personnel_hours,na.rm=TRUE)) %>%
  ungroup() %>%
  
  # put the columns in a logical order
  select(date,kostenplaats, region,  winkel, shop , personnel_hours)

raw_data

# Save data to feather
write_feather(raw_data,"personnel_hours_by_shop.feather")


