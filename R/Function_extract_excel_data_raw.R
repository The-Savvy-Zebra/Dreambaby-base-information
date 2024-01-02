source("R/Load Libraries.R")
source("R/References.R")


get_excel_data_raw <- function(file_name = NULL,
                               sheet_name = NULL,
                               shop_column = NULL) {


  # Get the sheet_nr from the excel sheet based on the sheet_name
  sheet_nr <- which(getSheetNames(file_name) ==
                      sheet_name)
  
  # get the xref_shops but only the names.
  # need to run unique to make sure we do not end-up with 
  # doubles after eliminating the nrs and the boolean
  # indicating if a shop is still open
  xref_subset <-
    xref_shops %>%
    select(shop, new_shop) %>%
    unique()
  
  # Get the excel sheet
  # The assumption is that the top row is a date.
  raw_data <-
    read.xlsx(
      xlsxFile = file_name,
      sheet = sheet_nr,
      detectDates = TRUE
      ) %>%
    as_tibble() %>%


    mutate(shop = str_trim(str_remove(!!ensym(shop_column), "DREAMBABY"), "both")) %>%
    select(-!!ensym(shop_column)) %>%
    
    # Remove the closed shops
    left_join(shops_activity, by = join_by(shop)) %>%
    filter(!(!actief | is.na(actief))) %>%
    select(-actief)
  
  return(raw_data)
}

### Debug
if (FALSE)
{
  file_name = "Data/Region-shop data.xlsx"
  sheet_name = "Regio - Winkels"
  shop_column <- "Winkel"

}
