source("R/Load Libraries.R")
source("R/References.R")

file_name <- "Data/Rolling forward Expansie DB - update OKTOBER 2023 (versie Lowiese).xlsx"
sheet_name = "BW OPER"

sheet_nr <- which(getSheetNames(file_name) ==
                    sheet_name)

last_column = 143 # Oct 2023

raw_data <-
  read.xlsx(xlsxFile = file_name,
            sheet = sheet_nr,
            detectDates = TRUE,
            rows=  2:39,
            cols = 1:(last_column+1)) %>%
  as_tibble() %>%
  pivot_longer(cols = 4:last_column,names_to = "date", values_to = "op_bw") %>%
  
  # Convert the dates
  mutate(date = excel_numeric_to_date(as.numeric(as.character(date)), date_system = "modern")) %>%
  
  filter(!is.na(op_bw)) %>%
  mutate(shop = str_trim(str_remove(omschrijving,"DREAMBABY"),"both")) %>%
  
  # Clean-up the rows (some shops are new)
  left_join(xref_subset,by = join_by(shop)) %>%
  group_by(date,sales_region=regio,shop=new_shop) %>%
  summarise(op_bw=sum(op_bw,na.rm=TRUE)) %>%
  ungroup() %>%
  
  # Remove closed shops
  left_join(shops_activity,by = join_by(shop)) %>%
  filter(actief & (!is.na(actief))) %>%
  
  # put the columns in a logical order
  select(date,sales_region, shop , op_bw)

raw_data

# Save data to feather
write_feather(raw_data,"../Feather Files/op bw by shop.feather")



