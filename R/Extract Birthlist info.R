source("R/Load Libraries.R")
source("R/References.R")

file_name <- "Data/GL bedrag en omzet per winkel vanaf 2020.xlsx"
sheet_name = "alle afgesloten Gl per filiaal "

sheet_nr <- which(getSheetNames(file_name) ==
                    sheet_name)

raw_data <-
  read.xlsx(xlsxFile = file_name,
            sheet = sheet_nr,
            detectDates = TRUE) %>%
  as_tibble() %>%
  clean_names() %>%
  mutate(date_bl_opening = ymd(paste0(jaarmaand_sluiting_geschenklijst,"01"))) %>%
  rename(date_bl_closing = datum_creatie_geschenklijst,
         gl_id=geschenklijst_nummer,
         shop=filiaalnaam_dt,
         shop_nr=filiaalnummer,
         revenue=som_prijs_verkocht_donatie_item) %>%
  select(shop_nr,shop,gl_id,date_bl_opening,date_bl_closing, revenue) %>%
  mutate(shop = str_trim(str_remove(shop,"DREAMBABY"),"both"))
raw_data

# Save data to feather
write_feather(raw_data,"../Feather Files/revenue_giftlist_by_shop.feather")

# Debug
if(FALSE)
{
  mdm <- 
    raw_data %>%
    filter(shop=="NAMUR") %>%
    arrange(date)
  
  
}