source("R/Load Libraries.R")
source("R/References.R")


get_xtra_data <- function(file_name, convert_comma=FALSE) {
  
  xtra_raw_data <- 
    fread(file_name) %>%
    tibble() %>%
    clean_names()
  
  if(convert_comma) {
    xtra_raw_data <-
      xtra_raw_data %>%
      mutate(turnoverexclvat=str_replace(turnoverexclvat,",","\\.")) %>% 
      mutate(turnoverinclvat=str_replace(turnoverinclvat,",","\\.")) %>%
      mutate(turnover_costprice_excl_vat=
               str_replace(turnover_costprice_excl_vat,",","\\.")) %>% 
      mutate(vatpercentage=str_replace(vatpercentage,",","\\.")) %>% 
      mutate(grossmargin_brutowinst=str_replace(grossmargin_brutowinst,",","\\.")) %>%
      mutate(cost_price=str_replace(cost_price,",","\\."))
  }
    
  xtra_raw_data <-
    xtra_raw_data %>%
    # Remove the empty sales lines
    filter(turnoverexclvat>0) %>%
    
    # Clean-up the data
    mutate(sales_date = as.Date(sales_date)) %>%
    mutate(plantname=str_to_upper(plantname)) %>%
    rename(shop=plantname) %>%
    rename(shop_nr = plant) %>%
    rename(grossmargin=grossmargin_brutowinst,
           identifier=herekenning) %>%
    mutate(shop = str_trim(str_remove(shop,"DREAMBABY"),"both")) %>%
    mutate(grossmargin = as.numeric(grossmargin),
           turnover_costprice_excl_vat = as.numeric(turnover_costprice_excl_vat)) %>%
    mutate(turnoverexclvat = as.numeric(turnoverexclvat) ,
           turnoverinclvat = as.numeric(turnoverinclvat)) %>%

    # Add the zipcode that is associated with the cbh_id
    left_join(cbh_id_raw_data,by = join_by(cbh_id)) %>%
    select(-producthierarchy) %>%
    left_join(bd_raw,by = join_by(cbh_id))
  
  return(  xtra_raw_data )
}

bd_raw <- 
  read_feather("../Feather Files/cbh_id_birth_date.feather") 

#### Extract the relationship between cbh_id and their postcode
file_name <- "Data/cbh_id.csv"

cbh_id_raw_data <- 
  fread(file_name) %>%
  tibble() %>%
  clean_names() %>%
  mutate(cbh_id = as.integer(str_remove(cbh_id,"\""))) %>%
  mutate(zipcode = as.integer(str_remove_all(postcode,"\""))) %>%
  
  select(-postcode)

# Save data to feather
write_feather(cbh_id_raw_data,"../Feather Files/cbh_id2zipcode.feather")


###############

xtra_raw_data_p1 <-
  get_xtra_data("Data/Dreambaby_Xtra_v2.csv") %>%
  filter(sales_date < ymd("2023-11-02")) %>%
  mutate(product=as.integer(product))

xtra_raw_data_p2 <- 
  get_xtra_data("Data/dm_storecheckoutsales_DB_202311_202311.csv",
                convert_comma=TRUE) %>%
  rename(postcode=postcode.x) %>%
  select(-postcode.y) %>%
  mutate(vatpercentage = as.numeric(vatpercentage)) %>%
  mutate(totalowndiscount = as.numeric(totalowndiscount)) %>%
  mutate(totaldiscountamount = as.numeric(totaldiscountamount)) %>%
  mutate(discountpercentage = as.numeric(discountpercentage)) %>%
  mutate(supplierdiscount = as.numeric(supplierdiscount)) %>%
  mutate(owndiscount = as.numeric(owndiscount)) %>%
  mutate(publidiscount = as.numeric(publidiscount)) %>%
  mutate(globalmanualdiscount = as.numeric(globalmanualdiscount))
 
xtra_raw_data <-
  bind_rows(xtra_raw_data_p1,xtra_raw_data_p2) 

# Save data to feather
write_feather(xtra_raw_data,"../Feather Files/Sales XTRA file.feather")

# Debug
if(FALSE)
{

  xtra_raw_data_p1$vatpercentage[1]
  xtra_raw_data_p2$vatpercentage[1]
  
  xtra_raw_data <-  xtra_raw_data %>%
    arrange(sales_date)
  
}