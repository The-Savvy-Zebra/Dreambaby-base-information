source("R/Load Libraries.R")
source("R/References.R")


xtra <- # Save data to feather
  read_feather("../Feather Files/Sales XTRA file.feather")


### Extract the number of tickets
df <- 
  xtra %>%
  filter(!str_detect(productgroup,"D9901M")) %>%
  select(date=sales_date,shop,receipt_number) %>%
  unique() %>%
  group_by(date,shop) %>%
  summarise(nr_of_tickets = n()) %>%
  ungroup()


# Save data to feather
write_feather(df,"../Feather Files/Number of tickets by shop.feather")


### Extract the number of tickets
df <- 
  xtra %>%
  filter(!str_detect(productgroup,"D9901M")) %>%
  group_by(date=sales_date,shop) %>%
  summarise(avg_revenue_by_ticket = mean(turnoverexclvat)) %>%
  ungroup() 

# Save data to feather
write_feather(df,"../Feather Files/Avg revenue by ticket by shop.feather")



### Debug
if(FALSE) {
  
  mdm <-
    xtra %>%
    select(product_name_nl,productgroup) %>%
    unique() %>%
    arrange() %>%
    filter(str_detect(productgroup,"D9901M"))
  
}


