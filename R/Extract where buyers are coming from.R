source("R/Load Libraries.R")
source("R/References.R")

####
# Get the feather file to translate the arrondissement to the province
xref <- 
  feather::read_feather("../Feather Files/gemeente_arrondissment_provincie.feather") %>%
  mutate(arrondissement_nl = ifelse(str_detect(arrondissement_nl,"Brussel"),"Arrondissement Brussel-Hoofdstad",arrondissement_nl)) %>%
  select(arrondissement_nl,gemeentenaam, postal_code) %>%
  mutate(gemeentenaam = paste0(str_to_upper(gemeentenaam),"-",postal_code))
 
  


#### Transform the XTRA data and add the postcode of the
# people who purchased there
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
  left_join(cbh_id_raw_data,by = join_by(cbh_id)) %>%
  select(date=sales_date,
         cbh_id,
         shop,
         postal_code=postcode,
         value=turnoverexclvat) %>%
  filter(!is.na(postal_code)) %>%
  group_by(date,cbh_id,shop,postal_code) %>%
  summarise(value=sum(value,na.rm=TRUE)) %>%
  ungroup() %>%
  left_join(xref,by = join_by(postal_code)) %>%
  rename(postal_code_buyer=postal_code,
         arrondissement_buyer=arrondissement_nl,
         gemeentenaam_buyer=gemeentenaam,
         revenue = value)


# Save data to feather
write_feather(xtra_raw_data,"../Feather Files/postcode_buyers.feather")


###########
## DEBUG
if(FALSE) {
  
  mdm <- 
  xref %>%
    filter(postal_code == 1050)
  
  
  
  
  xtra_raw_data %>%
    left_join(xref,by = join_by(postal_code))
  
  
  xtra_raw_data[956,]
  
}



