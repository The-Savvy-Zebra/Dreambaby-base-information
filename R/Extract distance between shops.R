source("R/Load Libraries.R")
source("R/References.R")

file_name <- "Data/shop distance xref.xlsx"
sheet_name = "Sheet 1"

sheet_nr <- which(getSheetNames(file_name) ==
                    sheet_name)



distance_between_shops <-
  read.xlsx(xlsxFile = file_name,
            sheet = sheet_nr,
            detectDates = TRUE) %>%
  as_tibble() %>%
  pivot_longer(cols = 2:NCOL(.),names_to = "to_shop", values_to = "distance") %>%
  rename(from_shop=x) %>%
  
  mutate(to_shop=str_replace(to_shop,"\\."," "))

# Safe to a feather file
startTextInBlue("Save the file")
write_feather(distance_between_shops,"../Feather Files/distance between shops.feather")
stopTextInGreen("Save the file")



