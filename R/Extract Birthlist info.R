source("R/Load Libraries.R")
source("R/References.R")

file_name <- "Data/GL Closing Birthlist.xlsx"
sheet_name = "alle afgesloten Gl per filiaal "

sheet_nr <- which(getSheetNames(file_name) ==
                    sheet_name)

# Load closing data

closing_data <-
  read.xlsx(xlsxFile = file_name,
            sheet = sheet_nr,
            detectDates = TRUE) %>%
  as_tibble() %>%
  clean_names() %>%
  mutate(date_bl_closing = ymd(paste0(jaarmaand_sluiting_geschenklijst,"01"))) %>%
  rename(date_bl_opening = datum_creatie_geschenklijst,
         gl_id=geschenklijst_nummer,
         shop=filiaalnaam_dt,
         shop_nr=filiaalnummer,
         revenue=som_prijs_verkocht_donatie_item) %>%
  select(shop_nr,shop,gl_id,date_bl_opening,date_bl_closing, revenue) %>%
  mutate(shop = str_trim(str_remove(shop,"DREAMBABY"),"both"))
closing_data

# Load creation data

file_name <- "Data/GL Opening Birthlist.xlsx"
sheet_name = "alle afgesloten Gl per filiaal "

sheet_nr <- which(getSheetNames(file_name) ==
                    sheet_name)

opening_data <-
  read.xlsx(xlsxFile = file_name,
            sheet = sheet_nr,
            detectDates = TRUE) %>%
  as_tibble() %>%
  clean_names() %>%
  select(shop_nr=filiaalnummer,
         date_bl_opening_2=datum_creatie_geschenklijst,
         date_bl_closing_2=datum_sluiting,
         gl_id=geschenklijst_nummer,
         revenue_2=som_prijs_verkocht_donatie_item)
opening_data

# Join Both data sets
df_intermediate <- 
  full_join(opening_data,closing_data,by = join_by(shop_nr, gl_id)) 


# Test for errors
test <- 
  df_intermediate %>%
  mutate(test=date_bl_opening==date_bl_opening_2) %>%
  filter(!test)

if(NROW(test) >0) {
  stop("ERROR. Mismatch in the opening dates between the 2 files!")
}
# End of Test Section

# Clean up dataframe in prep of Save
df <-
  df_intermediate %>%
  mutate(date_bl_opening = if_else(is.na(date_bl_opening),date_bl_opening_2,date_bl_opening)) %>%
  select(-date_bl_opening_2, -date_bl_closing) %>%
  rename(date_bl_closing=date_bl_closing_2) %>%
  
  # Clean-up the rows (some shops are new, some are closed)
  left_join(xref_shops, by = join_by(shop_nr,shop)) %>%
  mutate(shop_nr=ifelse(!is.na(new_shop_nr),new_shop_nr,shop_nr)) %>%
  select(shop_nr,gl_id,date_bl_opening,date_bl_closing,revenue,revenue_2) %>%
  # left_join(clean_up
  #           , by = join_by(shop_nr)) %>%
  left_join(xref_shops %>%
              select(new_shop,shop_nr,new_shop_nr,shop_open) %>%
              unique(),
                     by = join_by(shop_nr==shop_nr)) %>%
  
  # Remove all closed shops
  filter(shop_open) %>%
  
  # Add the revenue of the gl not closed yet
  mutate(revenue = ifelse(is.na(revenue),revenue_2,revenue)) %>%
  
  select(shop_nr=new_shop_nr,
         shop=new_shop,
         gl_number=gl_id,
         date_gl_opening=date_bl_opening,
         date_gl_closing=date_bl_closing,
         revenue) %>%
  arrange(date_gl_opening) %>%
  
  # Clean up the types of data
  mutate(gl_number = as.character(gl_number))

# Save data to feather
write_feather(df,"../Feather Files/revenue_giftlist_by_shop_open_closed.feather")
print("File written to the feather file directory.")

# Debug
if(FALSE)
{

  mdm <-
    df %>%
    filter(year(date_bl_closing)==9999)
  
  
  
}
