source("R/Load Libraries.R")
source("R/References.R")


# load postal code xref
file_name <- "Data/Conversion Postal code_Refnis code_va01012019.xlsx"
sheet_name = "Blad1"

sheet_nr <- which(getSheetNames(file_name) ==
                    sheet_name)

post_code_nis_xref <-
  read.xlsx(xlsxFile = file_name,
            sheet = sheet_nr,
            detectDates = TRUE) %>%
  as_tibble() %>%
  clean_names() %>%
  mutate(postal_code = as.integer(postal_code),
         code_nis = (refnis_code)) %>%
  select(-refnis_code) %>%
  select(code_nis,postal_code,gemeentenaam,nom_commune)



# Load datastructure


file_name <- "Data/REFNIS_2019.xlsx"
sheet_name = "REFNIS"

sheet_nr <- which(getSheetNames(file_name) ==
                    sheet_name)

raw_data <-
  read.xlsx(xlsxFile = file_name,
            sheet = sheet_nr,
            detectDates = TRUE) %>%
  as_tibble() %>%
  clean_names() %>%
  select(-langue,-code_ins) %>%
  select(code_nis,taal,administratieve_eenheden,entites_administratives) 

### Extract 

arrondissement <-
  raw_data %>%
  filter(str_detect(administratieve_eenheden,"Arrondissement")) %>%
  mutate(first_number = str_sub(code_nis,1,1)) %>%
  mutate(first_two_numbers = str_sub(code_nis,1,2)) %>%
  select(-taal) %>%
  rename(code_nis_arrondissement = code_nis,
         arrondissement_nl=administratieve_eenheden,
         arrondissement_fr=entites_administratives)
  


gemeente <-
  raw_data %>%
  filter(!is.na(taal)) %>%
  select(-administratieve_eenheden,-entites_administratives) %>%
  left_join(post_code_nis_xref,by = join_by(code_nis)) %>%
  select(code_nis,postal_code,language=taal,everything()) %>%
  mutate(first_two_numbers = str_sub(code_nis,1,2))


df <- 
  left_join(gemeente,arrondissement,by = join_by(first_two_numbers)) %>%
  left_join(xref_provincie,by = join_by(first_two_numbers)) %>%
  select(-first_two_numbers,-first_number) %>%
  
  # Remove doubles
  filter(!str_detect(gemeentenaam,"Brussel")) %>%
  
  # Clean some names to remain consequent
  rename(municipality_nl = gemeentenaam,
         municipality_fr = nom_commune,
         zipcode = postal_code,
         district_nl=arrondissement_nl,
         district_fr=arrondissement_fr,
         district_nis=code_nis_arrondissement,
         province_nis=code_nis_provincie,
         province_nl= provincie,
         province_fr=province,
         municipality_nis=code_nis) %>%
  mutate(municipality_nis=as.integer(municipality_nis),
         district_nis=as.integer(district_nis),
         province_nis=as.integer(province_nis))

# Save data to feather
write_feather(df,"../Feather Files/gemeente_arrondissment_provincie.feather")


####
## DEBUG
if(FALSE) {
  
 df %>%
    filter(str_detect(municipality_nl,"Aalst"))
  
}
