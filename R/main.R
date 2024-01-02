source("R/Load Libraries.R")
source("R/References.R")
source("R/Supporting Functions.R")

# Constants

column_latest_month <- 143

############################################################################
# Extract Rental and Depreciation by Shop
startTextInBlue("Rental and Depreciation by Shop")

df <- 
  get_excel_data_numeric(
  file_name = "Data/Rolling forward Expansie DB - update OKTOBER 2023 (versie Lowiese).xlsx",
  sheet_name = "gebouwkosten",
  column_name = "rental_depreciation",
  start_row = 2,
  stop_row = 39,
  start_column =  1,
  stop_column = column_latest_month 
) %>%
  mutate(rental_depreciation=abs(rental_depreciation)) %>%
  write_feather("../Feather Files/shop_rental_depreciation.feather")

# source("R/Extract Rental and Depr by Shop.R")
stopTextInGreen("Rental and Depreciation by Shop")
############################################################################


############################################################################
# Extract Shop Surface
startTextInBlue("Shop Surface")

df <- 
  get_excel_data_numeric(
    file_name = "Data/Rolling forward Expansie DB - update OKTOBER 2023 (versie Lowiese).xlsx",
    sheet_name = "m²",
    column_name = "surface_m2",
    start_row = 2,
    stop_row = 39,
    start_column =  1,
    stop_column = column_latest_month 
  ) %>%
  write_feather("../Feather Files/shop_surface.feather")

stopTextInGreen("Shop Surface")
############################################################################


############################################################################
# Extract Shop Surface
startTextInBlue("Shop-Region base data")

df <-
  get_excel_data_raw(file_name = "Data/Region-shop data.xlsx",
                     sheet_name = "Regio - Winkels",
                     shop_column = "Winkel") %>%
  write_feather("../Feather Files/Region-shops.feather")

stopTextInGreen("Shop-Region base data")
############################################################################


############################################################################
# Extract Personnel Cost
startTextInBlue("Personnel Cost")

df <-
  get_excel_data_numeric(
    file_name = "Data/Rolling forward Expansie DB - update OKTOBER 2023 (versie Lowiese).xlsx",
    sheet_name = "personeelskost",
    column_name = "personnel_cost",
    start_row = 2,
    stop_row = 39,
    start_column =  1,
    stop_column = column_latest_month 
  ) %>%
  write_feather("../Feather Files/personnel_cost_by_shop.feather")

stopTextInGreen("Personnel Cost")
############################################################################


############################################################################
# Extract Personnel Cost
startTextInBlue("Personnel Hours")

df <-
  get_excel_data_numeric(
    file_name = "Data/Rolling forward Expansie DB - update OKTOBER 2023 (versie Lowiese).xlsx",
    sheet_name = "personeelskost",
    column_name = "personnel_hours",
    start_row = 48,
    stop_row = 85,
    start_column =  1,
    stop_column =  141
  ) %>%
  write_feather("../Feather Files/personnel_hours_by_shop.feather")

stopTextInGreen("Personnel Hours")
############################################################################

############################################################################
# Extract Net Revenue by Shop
startTextInBlue("Net Revenue")

df <-
  get_excel_data_numeric(
    file_name = "Data/Rolling forward Expansie DB - update OKTOBER 2023 (versie Lowiese).xlsx",
    sheet_name = "Omzet OPER",
    column_name = "revenue",
    start_row = 2,
    stop_row = 39,
    start_column =  1,
    stop_column = column_latest_month
  ) %>%
  write_feather("../Feather Files/revenue_by_shop.feather")

stopTextInGreen("Net Revenue")
############################################################################

############################################################################
# Extract Net Revenue Giftlists by Shop
startTextInBlue("Revenue Giftlists")

df <-
  get_excel_data_numeric(
    file_name = "Data/Rolling forward Expansie DB - update OKTOBER 2023 (versie Lowiese).xlsx",
    sheet_name = "Giftlist",
    column_name = "revenue_giftlist",
    start_row = 2,
    stop_row = 39,
    start_column =  1,
    stop_column = column_latest_month
  ) %>%
  write_feather("../Feather Files/revenue_giftlist_by_shop.feather")

stopTextInGreen("Revenue Giftlists")
############################################################################

############################################################################
# Extract Visits by shop
startTextInBlue("Number of Customer Visits by shop")

df <-
  get_excel_data_numeric(
    file_name = "Data/Rolling forward Expansie DB - update OKTOBER 2023 (versie Lowiese).xlsx",
    sheet_name = "klanten en volume",
    column_name = "customer_visits",
    start_row = 2,
    stop_row = 39,
    start_column =  1,
    stop_column = column_latest_month
  ) %>%
  select(-winkel) %>%
  write_feather("../Feather Files/number_of_customer_visits_by_shop.feather")

stopTextInGreen("Number of Customer Visits by shop")
############################################################################


############################################################################
# Extract BW by shop
startTextInBlue("BW by shop")

df <-
  get_excel_data_numeric(
    file_name = "Data/Rolling forward Expansie DB - update OKTOBER 2023 (versie Lowiese).xlsx",
    sheet_name = "BW OPER",
    column_name = "op_bw",
    start_row = 2,
    stop_row = 39,
    start_column =  1,
    stop_column = column_latest_month
  ) %>%
  select(-winkel) %>%
  write_feather("../Feather Files/op_bw_by_shop.feather")

stopTextInGreen("BW by shop")
############################################################################

############################################################################
# Extract Qty of Giftlists by shop
startTextInBlue("Qty of Giftlists product by shop")

df <-
  get_excel_data_numeric(
    file_name = "Data/Rolling forward Expansie DB - update OKTOBER 2023 (versie Lowiese).xlsx",
    sheet_name = "Giftlist",
    column_name = "qty_giftlist",
    start_row = 94,
    stop_row = 131,
    start_column =  1,
    stop_column = column_latest_month
  ) %>%
  select(-winkel) %>%
  write_feather("../Feather Files/qty_giftlist_products_by_shop.feather")

stopTextInGreen("Qty of Giftlists product by shop")
############################################################################

############################################################################
# Extract Qty of Giftlists by shop
startTextInBlue("Qty of opened Giftlists")

df <-
  get_excel_data_numeric(
    file_name = "Data/Rolling forward Expansie DB - update OKTOBER 2023 (versie Lowiese).xlsx",
    sheet_name = "Giftlist",
    column_name = "qty_opened_giftlist",
    start_row = 140,
    stop_row = 177,
    start_column =  1,
    stop_column = column_latest_month
  ) %>%
  select(-winkel) %>%
  write_feather("../Feather Files/qty_opened_giftlist_by_shop.feather")

stopTextInGreen("Qty of opened Giftlists")
############################################################################

############################################################################
# Extract Qty of Giftlists by shop
startTextInBlue("Qty of closed Giftlists")

df <-
  get_excel_data_numeric(
    file_name = "Data/Rolling forward Expansie DB - update OKTOBER 2023 (versie Lowiese).xlsx",
    sheet_name = "Giftlist",
    column_name = "qty_closed_giftlist",
    start_row = 186,
    stop_row = 223,
    start_column =  1,
    stop_column = column_latest_month
  ) %>%
  select(-winkel) %>%
  write_feather("../Feather Files/qty_closed_giftlist_by_shop.feather")

stopTextInGreen("Qty of closed Giftlists")
############################################################################

############################################################################
# Extract Arrondissement - gemeente
startTextInBlue("Arrondissement gemeente data")
source(("R/Extract arrondissement - gemeente.R"))
stopTextInGreen("Arrondissement gemeente data")
############################################################################

############################################################################
# Extract Arrondissement - gemeente
startTextInBlue("Birth Info by Arrondissement")
source(("R/Extract Birth Info by Arrondissement.R"))
stopTextInGreen("Birth Info by Arrondissement")
############################################################################

############################################################################
# Extract Arrondissement - gemeente
startTextInBlue("Extract SAP Supplier numbers")
source(("R/Extract_Suppliers_SAP_numbers.R"))
stopTextInGreen("Extract SAP Supplier numbers")
############################################################################




