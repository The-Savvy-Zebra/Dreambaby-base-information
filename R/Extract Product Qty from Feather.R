source("R/Load Libraries.R")
source("R/References.R")


file_names <-
  list.files("Temp/Data") %>%
  tibble() %>%
  clean_names() 


file_name <- "Temp/Data/Raw data stockevolutie november 2022.xlsx-Extract D110.feather"

extract_webshop <- function(file_name)
{
df <- 
  read_feather(file_name) %>%
  tibble() %>%
  rename(date = X1,
         shop_nr = X2,
         shop = X3,
         pg_hierarchy_1 = X4,
         pg_hierarchy_1_desc = X5,
         product_nr = X6,
         product_name = X7,
         qty = X8,
         value = X9
         )

# We detect if the first row contains the column names,
# if it does, erase that first row.
if(str_detect(df[1,1],"Stock date")) {
  df <- df[-1,]
}

return(df)
}


extract_shop <- function(file_name)
{
  df <- 
    read_feather(file_name) %>%
    tibble() %>%
    rename(date = X1,
           shop_nr = X2,
           shop = X3,
           pg_hierarchy_1 = X4,
           pg_hierarchy_1_desc = X5,
           product_nr = X6,
           product_name = X7,
           qty = X8,
           value = X9
    ) %>%
    mutate(shop = rm_number(shop)) %>%
    mutate(shop = str_trim(str_remove(shop,"DREAMBABY")),"both")
  
  # We detect if the first row contains the column names,
  # if it does, erase that first row.
  if(str_detect(df[1,1],"Stock date")) {
    df <- df[-1,]
  }
  
  return(df)
}



## Extract Webshop en DC data

webshop_dc_file_names <-
  file_names %>%
  filter(str_detect(x,"5388")|
           str_detect(x,"D110")|
           str_detect(x,"D120")) %>%
  mutate(x = paste0("Temp/Data/",x))

for(i in 1:NROW(webshop_dc_file_names)) {
  
  startTextInBlue(paste0("Processing file ",webshop_dc_file_names$x[i]))
  
  df <- 
    extract_webshop(webshop_dc_file_names$x[i]) %>%
    select(date,
           shop,
           product_nr,
           qty,
           value) 
  
  if(i==1) {
    product_inventory <- df
  } else {
    product_inventory <- 
      rbind(product_inventory,df) 
  }
  
  stopTextInGreen(paste0("Processing file ",webshop_dc_file_names$x[i]))
  
}


## Extract shop data

shop_file_names <-
  file_names %>%
  filter(str_detect(x,"winkels")) %>%
  mutate(x = paste0("Temp/Data/",x))

for(i in 1:NROW(shop_file_names)) {
  
  startTextInBlue(paste0("Processing file ",shop_file_names$x[i]))
  
  df <- 
    extract_shop(shop_file_names$x[i]) %>%
    select(date,
           shop,
           product_nr,
           qty,
           value) 
  
  
    product_inventory <- 
      rbind(product_inventory,df) 

  
  stopTextInGreen(paste0("Processing file ",shop_file_names$x[i]))
  
}


# Save data to feather
write_feather(product_inventory,"../Feather Files/product_inventory.feather")
