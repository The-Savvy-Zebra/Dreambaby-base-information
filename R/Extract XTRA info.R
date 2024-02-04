source("R/Load Libraries.R")
source("R/References.R")


bd_raw <- 
  read_feather("../Feather Files/cbh_id_birth_date.feather") 

#### Extract the relationship between cbh_id and their postcode
file_name <- "Data/cbh_id.csv"

cbh_id_raw_data <- 
  fread(file_name) %>%
  tibble() %>%
  clean_names() %>%
  mutate(cbh_id = as.integer(str_remove(cbh_id,"\""))) %>%
  mutate(zipcode = as.integer(str_remove_all(postcode,"\""))) %>%
  
  select(-postcode)

# Save data to feather
write_feather(cbh_id_raw_data,"../Feather Files/cbh_id2zipcode.feather")


###############
file_name <- "Data/Dreambaby_Xtra_v2.csv"


xtra_raw_data <- 
  fread(file_name) %>%
  tibble() %>%
  clean_names() %>%
  
  # Remove the empty sales lines
  filter(turnoverexclvat>0) %>%
  
  # Clean-up the data
  mutate(sales_date = as.Date(sales_date)) %>%
  mutate(plantname=str_to_upper(plantname)) %>%
  rename(shop=plantname) %>%
  rename(shop_nr = plant) %>%
  rename(grossmargin=grossmargin_brutowinst,
         identifier=herekenning) %>%
  mutate(shop = str_trim(str_remove(shop,"DREAMBABY"),"both")) %>%
  mutate(grossmargin = as.numeric(grossmargin),
         turnover_costprice_excl_vat = as.numeric(turnover_costprice_excl_vat)) %>%
  
  # Add the zipcode that is associated with the cbh_id
  left_join(cbh_id_raw_data,by = join_by(cbh_id)) %>%
  select(-producthierarchy) %>%
  left_join(bd_raw,by = join_by(cbh_id))
  


# Save data to feather
write_feather(xtra_raw_data,"../Feather Files/Sales XTRA file.feather")

# Debug
if(FALSE)
{

  mdm <-
    xtra_raw_data %>%
    select(sales_date,cbh_id, zipcode) %>%
    filter(is.na(zipcode)) %>%
    filter(!is.na(cbh_id)) %>%
    select(-zipcode) %>%
    group_by(cbh_id) %>%
    mutate(first = min(sales_date)==sales_date) %>%
    ungroup() %>% 
    filter(first) %>%
    select(-first) %>%
    unique()
  
  
  cbh_id_raw_data %>%
    filter(cbh_id==22607473)
  
}