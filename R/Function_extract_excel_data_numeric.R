source("R/Load Libraries.R")
source("R/References.R")


get_excel_data_numeric <- function(file_name = NULL,
                                   sheet_name = NULL,
                                   column_name = NULL,
                                   start_row = NULL,
                                   stop_row = NULL,
                                   start_column =  NULL,
                                   stop_column = NULL) {

  
  if(is.null(start_column)) {
    start_column <- 1
  }
  
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
      detectDates = TRUE,
      cols = start_column:(stop_column + 1),
      rows = start_row:stop_row
    ) %>%
    as_tibble() %>%
    pivot_longer(
      cols = 4:stop_column,
      names_to = "date",
      values_to = column_name
    ) %>%
    
    # Convert the shitty excel dates into an R date column
    mutate(date = excel_numeric_to_date(as.numeric(as.character(date)), date_system = "modern")) %>%
    
    
    # Eliminate all the rows that contain an NA.
    # Use this complicates statement because we are using 
    # a variable passed to the function 
    filter(!is.na(!!ensym(column_name))) %>%
    mutate(shop = str_trim(str_remove(omschrijving, "DREAMBABY"), "both")) %>%
    
    # Remove the closed shops
    left_join(shops_activity, by = join_by(shop)) %>%
    filter(!(!actief | is.na(actief))) %>%
    
    # Make the names readable
    rename(kostenplaats = kplt,
           winkel = omschrijving,
           region = regio) %>%
    
    # Clean-up the rows (some shops changed name and locations)
    # Summarise the numerical column 
    # The effect is that the "new" shop gets all the current and
    # historcal value.
    left_join(xref_subset, by = join_by(shop)) %>%
    group_by(kostenplaats, winkel, region, date, shop = new_shop) %>%
    mutate(across(all_of(column_name), sum, na.rm = TRUE)) %>%
    ungroup() %>%
    
    # put the columns in a logical order
    select(date,
           kostenplaats,
           region,
           winkel,
           shop ,
           !!ensym(column_name))
  
  return(raw_data)
}

### Debug
if (FALSE)
{
  file_name = "Data/Rolling forward Expansie DB - update OKTOBER 2023 (versie Lowiese).xlsx"
  sheet_name = "personeelskost"
  column_name = "personnel_hours"
  start_row = 48
  stop_row = 85
  start_column =  1
  stop_column =  141
  
}
