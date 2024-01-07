source("R/Load Libraries.R")
source("R/References.R")

file_name <- "Data/Rolling forward Expansie DB - update OKTOBER 2023 (versie Lowiese).xlsx"
sheet_name = "Omzet OPER"

sheet_nr <- which(getSheetNames(file_name) ==
                    sheet_name)


xref_subset <-
  xref_shops %>%
  select(shop,new_shop) %>%
  unique()

last_column = 143 # Oct 2023

raw_data <-
  read.xlsx(xlsxFile = file_name,
            sheet = sheet_nr,
            detectDates = TRUE,
            cols = 1:(last_column+1),
            rows = 2:39
            ) %>%
  as_tibble() %>%
  pivot_longer(cols = 4:NCOL(.),names_to = "date", values_to = "revenue") %>%
  
  # Convert the dates
  mutate(date = excel_numeric_to_date(as.numeric(as.character(date)), date_system = "modern")) %>%
  
  filter(!is.na(revenue)) %>%
  mutate(shop = str_trim(str_remove(omschrijving,"DREAMBABY"),"both")) %>%
  
  # Remove closed shops
  left_join(shops_activity,by = join_by(shop)) %>%
  filter(!(!actief|is.na(actief))) %>% 
  
  filter(revenue>0) %>%
  
  # Make the names readable
  rename(kostenplaats = kplt,
         winkel = omschrijving,
         sales_region = regio) %>%
  
  # Clean-up the rows (some shops are new)
  left_join(xref_subset,by = join_by(shop)) %>%
  group_by(kostenplaats,winkel,sales_region,date,shop=new_shop) %>%
  summarise(revenue=sum(revenue,na.rm=TRUE)) %>%
  ungroup() %>%
  
  # Remove the closed shops
  left_join(shops_activity,by = join_by(shop)) %>%
  filter(actief) %>%
  select(-actief) %>%
  
  # put the columns in a logical order
  select(date, sales_region, shop , revenue) 

# Save data to feather
write_feather(raw_data,"../Feather Files/Revenue by Shop.feather")

### Debug
if(FALSE)
{

  raw_data %>%
    filter(str_detect(winkel,"DREAMBABY WILRIJK")) %>%
    filter(year(date)==2022)
  
  
}

