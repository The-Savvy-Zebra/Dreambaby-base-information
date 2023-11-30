source("R/Load Libraries.R")
source("R/References.R")

file_name <- "Data/Dreambaby_Xtra_v2.csv"


raw_data <- 
  fread(file_name) %>%
  tibble() %>%
  clean_names() %>%
  mutate(sales_date = as.Date(sales_date)) %>%
  mutate(plantname=str_to_upper(plantname)) %>%
  rename(shop=plantname) %>%
  mutate(shop = str_trim(str_remove(shop,"DREAMBABY"),"both")) 

  
  
# Save data to feather
write_feather(raw_data,"../Feather Files/Sales XTRA file.feather")

# Debug
if(FALSE)
{

  
}