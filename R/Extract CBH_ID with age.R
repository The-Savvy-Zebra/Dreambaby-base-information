source("R/Load Libraries.R")
source("R/References.R")

#### Extract the relationship between cbh_id and their postcode
file_name <- "Data/cbh_info2.csv"

cbh_id_raw_data <- 
  fread(file_name) %>%
  tibble() %>%
  clean_names() %>%
  mutate(birth_date = as.Date(datum_geboorte)) %>%
  select(-datum_geboorte) %>%
  rename(cbh_id=cbhid)

# Save data to feather
write_feather(cbh_id_raw_data,"../Feather Files/cbh_id_birth_date.feather")
