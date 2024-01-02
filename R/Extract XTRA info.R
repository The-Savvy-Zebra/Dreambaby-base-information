source("R/Load Libraries.R")
source("R/References.R")

file_name <- "Data/cbh_id.csv"

cbh_id_raw_data <- 
  fread(file_name) %>%
  tibble() %>%
  clean_names() %>%
  mutate(cbh_id = as.integer(str_remove(cbh_id,"\""))) %>%
  mutate(postcode = as.integer(str_remove_all(postcode,"\"")))


file_name <- "Data/Dreambaby_Xtra_v2.csv"


xtra_raw_data <- 
  fread(file_name) %>%
  tibble() %>%
  clean_names() %>%
  mutate(sales_date = as.Date(sales_date)) %>%
  mutate(plantname=str_to_upper(plantname)) %>%
  rename(shop=plantname) %>%
  mutate(shop = str_trim(str_remove(shop,"DREAMBABY"),"both")) %>%
  left_join(cbh_id_raw_data,by = join_by(cbh_id))
  


# Save data to feather
write_feather(xtra_raw_data,"../Feather Files/Sales XTRA file.feather")

# Debug
if(FALSE)
{
  xtra_raw_data %>%
    filter(is.na(postcode)) %>%
    select(cbh_id,postcode) %>%
    unique()
  
  cbh_id_raw_data %>%
    filter(cbh_id==24087979)
  
}