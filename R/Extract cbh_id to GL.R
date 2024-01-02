source("R/Load Libraries.R")
source("R/References.R")


file_name <- "Data/cbh_id to giftlist.csv"
file_name <- "Data/cbh_id2gl_v3.csv"


cbh_id_raw_data <- 
  fread(file_name) %>%
  tibble() %>%
  clean_names() %>%
  rename(owner_cbh_id=cbhid_eigenaar_geschenklijst,
         buyer_cbh_id=cbhid_schenker,
         date_creation_gl=datum_creatie_geschenklijst,
         gl_number=geschenklijst_nummer,
         value=som_prijs_verkocht_donatie_item) %>%
  # select(-som_prijs_verkocht_donatie_item2) %>%
  filter(buyer_cbh_id!="!") %>%
  filter(buyer_cbh_id!="?") %>%
  mutate(value=str_remove(value,",")) %>%
  mutate(value=as.numeric(value)) %>%
  mutate(buyer_cbh_id = as.integer(buyer_cbh_id)) %>%
  filter(!is.na(value))



# Save data to feather
write_feather(cbh_id_raw_data,"../Feather Files/cbh_id_owners_buyers.feather")


#######
# DEBUG
if(FALSE) {
  
  cbh_id_raw_data %>%
    filter(is.na(value))

}


