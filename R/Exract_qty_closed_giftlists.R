source("R/Load Libraries.R")
source("R/References.R")

file_name <- "Data/Rolling forward Expansie DB - update OKTOBER 2023 (versie Lowiese).xlsx"
sheet_name = "Giftlist"

sheet_nr <- which(getSheetNames(file_name) ==
                    sheet_name)


last_column = 143 # Oct 2023

raw_data <-
  read.xlsx(xlsxFile = file_name,
            sheet = sheet_nr,
            detectDates = TRUE,
            rows = 186:223,
            cols = 1:(last_column+1)) %>%
  as_tibble() %>%
  pivot_longer(cols = 4:last_column,names_to = "date", values_to = "qty_closed_giftlist") %>%
  
  # Convert the dates
  mutate(date = excel_numeric_to_date(as.numeric(as.character(date)), date_system = "modern")) %>%
  
  filter(!is.na(qty_closed_giftlist)) %>%
  mutate(shop = str_trim(str_remove(omschrijving,"DREAMBABY"),"both")) %>%
  
  # Make the names readable
  rename(kostenplaats = kplt,
         winkel = omschrijving,
         region = regio) %>%
  
  # Clean-up the rows (some shops are new, some are closed)
  left_join(xref_shops,by = join_by(shop)) %>%
  filter(!is.na(new_shop)) %>%
  
  group_by(kostenplaats,region,date,shop=new_shop) %>%
  summarise(qty_closed_giftlist=sum(qty_closed_giftlist,na.rm=TRUE)) %>%
  ungroup() %>%
  
  # Remove closed shops
  left_join(shops_activity,by = join_by(shop)) %>%
  filter(!(!actief|is.na(actief))) %>%
  
  # put the columns in a logical order
  select(date,kostenplaats, region, shop , qty_closed_giftlist)

raw_data

# Save data to feather
write_feather(raw_data,"qty_closed_giftlist_by_shop.feather")

# Debug
if(FALSE)
{
  mdm <- 
    raw_data %>%
    filter(str_detect(shop,"WATERLO")) %>%
    select(shop) %>%
    unique()
  
  
  raw_data %>%
    filter(is.na(omschrijving))
    select(shop,actief) %>%
    unique()
    
  
}