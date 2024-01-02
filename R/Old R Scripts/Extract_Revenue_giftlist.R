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
            startRow = 2,
            rows = 2:39,
            cols = 1:(last_column+1)) %>%
  as_tibble() %>%
  pivot_longer(cols = 4:last_column,names_to = "date", values_to = "revenue_giftlist") %>%
  
  # Convert the dates
  mutate(date = excel_numeric_to_date(as.numeric(as.character(date)), date_system = "modern")) %>%
  
  filter(!is.na(revenue_giftlist)) %>%
  mutate(shop = str_trim(str_remove(omschrijving,"DREAMBABY"),"both")) %>%
  
  # Remove closed shops
  left_join(shops_activity,by = join_by(shop)) %>%
  filter(!(!actief|is.na(actief))) %>%
  
  # Make the names readable
  rename(kostenplaats = kplt,
         winkel = omschrijving,
         region = regio) %>%
  
  # Clean-up the rows (some shops are new)
  left_join(xref_shops,by = join_by(shop)) %>%
  group_by(kostenplaats,winkel,region,date,shop=new_shop) %>%
  summarise(revenue_giftlist=sum(revenue_giftlist,na.rm=TRUE)) %>%
  ungroup() %>%
  
  # put the columns in a logical order
  select(date,kostenplaats, region,  winkel, shop , revenue_giftlist)

raw_data

# Save data to feather
write_feather(raw_data,"revenue_giftlist_by_shop.feather")

# Debug
if(FALSE)
{
  mdm <- 
  raw_data %>%
    filter(shop=="NAMUR") %>%
    arrange(date)
  
  
}