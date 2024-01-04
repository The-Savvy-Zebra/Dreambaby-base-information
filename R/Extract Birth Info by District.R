source("R/Load Libraries.R")
source("R/References.R")


# # get arrondissement data
# loc_xref <- read_feather("../Feather Files/gemeente_arrondissment_provincie.feather")
# 

file_name <- "Data/Stat_Month_Birth_NL_2020.xlsx"
sheet_name = "2020"

sheet_nr <- which(getSheetNames(file_name) ==
                    sheet_name)

# Load closing data

df <-
  read.xlsx(xlsxFile = file_name,
            sheet = sheet_nr,
            startRow = 6,
            detectDates = TRUE) %>%
  as_tibble() %>%
  clean_names() %>%
  pivot_longer(cols= 2:49,names_to = "date", values_to = "births") %>%
  mutate(date=dmy(paste0("1_",date))) %>%
  rename(district_nl=x1) %>%
  filter(str_detect(district_nl,"Arrondissement")) %>%

  # Put the columns in the prefered order
  select(date,district_nl,births) 


# Save data to feather
write_feather(df,"../Feather Files/Birth by district.feather")
