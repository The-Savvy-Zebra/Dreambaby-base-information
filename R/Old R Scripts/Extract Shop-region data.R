source("R/Load Libraries.R")
source("R/References.R")

file_name <- "Data/Region-shop data.xlsx"
sheet_name = "Regio - Winkels"

sheet_nr <- which(getSheetNames(file_name) ==
                    sheet_name)
raw_data <-
  read.xlsx(xlsxFile = file_name,
            sheet = sheet_nr,
            detectDates = TRUE) %>%
  as_tibble() %>%
  clean_names() %>%
  mutate(shop = str_trim(str_remove(winkel,"DREAMBABY"),"both")) %>%
  
  # Remove closed shops
  left_join(shops_activity,by = join_by(shop)) %>%
  filter(actief) %>%
  
  # Rename columns
  rename(region = regio) %>%
  
  select(nv,kostenplaats,region,winkel,shop,shop)

# Save feather file

write_feather(raw_data,"Region-shops.feather")

