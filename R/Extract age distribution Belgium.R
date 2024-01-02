source("R/Load Libraries.R")
source("R/References.R")


types <- tribble(
  ~ type,
  ~ comment,
  "type_A",
  "Belg met Belgische achtergrond geboren in België",
  "type_B",
  "Belg met Belgische achtergrond niet geboren in België",
  "type_C",
  "Belg met een buitenlandse achtergrond Belgische eerst geregistreerde nationaliteit, eén ouder met een buitenlandse eerst geregistreerde nationaliteit, geboren in België
",
  "type_D",
  "Belg met een buitenlandse achtergrond Belgische eerst geregistreerde nationaliteit, eén ouder met een buitenlandse eerst geregistreerde nationaliteit, niet geboren in België
",
  "type_E",
  "Belg met een buitenlandse achtergrond Belgische eerst geregistreerde nationaliteit, beide ouders met een buitenlandse eerst geregistreerde nationaliteit, geboren in België
",
  "type_F",
  "Belg met een buitenlandse achtergrond Belgische eerst geregistreerde nationaliteit, beide ouders met een buitenlandse eerst geregistreerde nationaliteit, niet geboren in België
",
  "type_G",
  "Belg met een buitenlandse achtergrond, buitenlandse eerst geregistreerde, geboren in België ",
  "type_H",
  "Belg met een buitenlandse achtergrond, buitenlandse eerst geregistreerde, niet geboren in België ",
  "type_I",
  "Belg met een buitenlandse achtergrond, totaal Belg met een buitenlandse achtergrond, geboren in België",
  "type_J",
  "Belg met een buitenlandse achtergrond, totaal Belg met een buitenlandse achtergrond, niet geboren in België",
  "type_K",
  "Niet-Belg, geboren in België",
  "type_L",
  "Niet-Belg, niet geboren in België"
)

#### extraction function

get_single_sheet <- function(sheet_name)
{
  sheet_nr <- which(getSheetNames(file_name) ==
                      sheet_name)
  
  
  df <-
    read.xlsx(
      xlsxFile = file_name,
      sheet = sheet_nr,
      detectDates = TRUE,
      startRow = 7
    ) %>%
    as_tibble() %>%
    clean_names()
  
  woonplaats <- df$woonplaats[1]
  nis_code <- df$nis_code[1]
  geslacht <- df$geslacht[1]
  
  for (i in 2:NROW(df)) {
    if (is.na(df$woonplaats[i])) {
      df$woonplaats[i]  = woonplaats
    } else
    {
      woonplaats = df$woonplaats[i]
    }
    
    if (is.na(df$nis_code[i])) {
      df$nis_code[i]  = nis_code
    } else
    {
      nis_code = df$nis_code[i]
    }
    
    if (is.na(df$geslacht[i])) {
      df$geslacht[i]  = geslacht
    } else
    {
      geslacht = df$geslacht[i]
    }
    
  }
  
  # Remove the totals and keep the "Man" & "Vrouw" rows
  pop <-
    df %>%
    select(-x7,-x10,-x13,-x16,-x19,-x22) %>%
    filter(geslacht %in% c("Man", "Vrouw")) %>%
    rename(
      type_A = x5,
      type_B = x6,
      type_C = x8,
      type_D = x9,
      type_E = x11,
      type_F = x12,
      type_G = x14,
      type_H = x15,
      type_I = x17,
      type_J = x18,
      type_K = x20,
      type_L = x21,
      tot_born_belgium = x23,
      tot_not_born_belgium = x24,
      grand_total_born = x25,
      location = woonplaats,
      gender = geslacht
    ) %>%
    pivot_longer(
      cols = c(type_A:grand_total_born),
      names_to = "type",
      values_to = "values"
    ) %>%
    
    # Translate gender in english
    
    mutate(gender = ifelse(gender == "Man", "male", "female")) %>%
    left_join(types, by = join_by(type))
}


# load postal code xref
file_name <-
  "Data/Herkomst naar leeftijd en geslacht per gemeente.xlsx"

sheetnames <- 
  getSheetNames(file_name) %>%
  tibble() %>%
  clean_names() %>%
  filter(str_detect(x,"20"))


for(i in 1:NROW(sheetnames)) {
  
  
  print(paste0(sheetnames$x[i]))
  
  pop <- 
    get_single_sheet(sheetnames$x[i]) %>%
    mutate(year = sheetnames$x[i]) %>%
    select(year,everything())
  
  
  if(i==1) {
    overview_pop <- pop
  } else {
    overview_pop <- rbind(overview_pop,pop)
  }
  
  overview_pop <- 
    overview_pop %>%
    arrange(year)

}

# Save data to feather
write_feather(overview_pop,"../Feather Files/Birth Rates.feather")

