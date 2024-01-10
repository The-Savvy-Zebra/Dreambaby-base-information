source("R/Load Libraries.R")
source("R/References.R")

file_name <- "Data/Rolling forward Expansie DB - update NOVEMBER 2023 Finaal.xlsx"
sheet_name = "personeelskost"

sheet_nr <- which(getSheetNames(file_name) ==
                    sheet_name)

last_column = 143 # Oct 2023

# Extract Fixed Employees FTE's
startTextInBlue("Extract Fixed Employees FTE's")
  
FTE_fixed_employees <-
  read.xlsx(xlsxFile = file_name,
            sheet = sheet_nr,
            detectDates = TRUE,
            rows = 186:223,
            cols = 1:(last_column+1)) %>%
  as_tibble() %>%
  pivot_longer(cols = 4:last_column,names_to = "date", values_to = "amount") %>%
  
  # Convert the dates
  mutate(date = excel_numeric_to_date(as.numeric(as.character(date)), date_system = "modern")) %>%
  
  filter(!is.na(amount)) %>%
  mutate(shop = str_trim(str_remove(omschrijving,"DREAMBABY"),"both")) %>%
  mutate(kind="FTE_fixed_employees") 

stopTextInGreen("Extract Fixed Employees FTE's")

# Extract Student FTE's
startTextInBlue("Extract Student FTE's")

FTE_students <-
  read.xlsx(xlsxFile = file_name,
            sheet = sheet_nr,
            detectDates = TRUE,
            rows = 232:269,
            cols = 1:(last_column+1)) %>%
  as_tibble() %>%
  pivot_longer(cols = 4:NCOL(.),names_to = "date", values_to = "amount") %>%
  
  # Convert the dates
  mutate(date = excel_numeric_to_date(as.numeric(as.character(date)), date_system = "modern")) %>%
  
  filter(!is.na(amount)) %>%
  mutate(shop = str_trim(str_remove(omschrijving,"DREAMBABY"),"both")) %>%
  mutate(kind="FTE_students") 

stopTextInGreen("Extract Student FTE's")

# Extract Interim FTE's
startTextInBlue("Extract Interim FTE's")

FTE_interims <-
  read.xlsx(xlsxFile = file_name,
            sheet = sheet_nr,
            detectDates = TRUE,
            rows = 278:315,
            cols = 1:(last_column+1)) %>%
  as_tibble() %>%
  pivot_longer(cols = 4:NCOL(.),names_to = "date", values_to = "amount") %>%
  
  # Convert the dates
  mutate(date = excel_numeric_to_date(as.numeric(as.character(date)), date_system = "modern")) %>%
  
  filter(!is.na(amount)) %>%
  mutate(shop = str_trim(str_remove(omschrijving,"DREAMBABY"),"both")) %>%
  mutate(kind="FTE_Interims") 

stopTextInGreen("Extract Interim FTE's")

# Compile the full dataframe and add the total FTE's
# pro shop

df <-
  rbind(FTE_fixed_employees,FTE_students) %>%
  rbind(FTE_interims) %>%
  
  # Add the totals
  pivot_wider(names_from = kind, values_from = amount, values_fill = 0) %>%
  mutate(total = FTE_fixed_employees+FTE_students+FTE_Interims) %>%
  pivot_longer(cols = c(FTE_fixed_employees,FTE_students,FTE_Interims,total),
               values_to = "amount",
               names_to = "kind") %>%
  
  # Clean-up the column names and create the final dataframe
  rename(sales_region=regio) %>%
  select(date,sales_region,shop,kind,amount) %>%
  arrange(date) %>%
  
  
  # Clean-up the rows (some shops are new)
  left_join(xref_subset,by = join_by(shop)) %>%
  group_by(date,sales_region,shop=new_shop,kind) %>%
  summarise(amount=sum(amount,na.rm=TRUE)) %>%
  ungroup() %>%
  
  
  # Remove the closed shops
  left_join(shops_activity,by = join_by(shop)) %>%
  filter(actief) %>%
  select(-actief)

# Safe to a feather file
startTextInBlue("Save the file")
write_feather(df,"../Feather Files/FTE by shop.feather")
stopTextInGreen("Save the file")


###### Debug
if(FALSE) {
  
  df %>%
    filter(str_detect(shop,"WILRIJK")) %>%
    filter(year(date)==2022) %>%
    filter(month(date)==8)
  
}

