

shops_activity <- tribble(
  ~shop, ~actief,
  "NAMUR", TRUE,
  "HUY",  FALSE,
  "TIENEN", FALSE,
  "WATERLO", TRUE,
  "KUURNE", TRUE,
  "HALLE", TRUE,
  "MECHELEN", TRUE,
  "BREE", TRUE,
  "HERSTAL", TRUE,
  "ZEMST", FALSE,
  "GENT", TRUE,
  "OOSTEND", TRUE,
  "DENDERLEEUW", TRUE,
  "LOCHRISTI", TRUE,
  "BRUGGE", TRUE,
  "LIER", TRUE,             
  "TOURNAI", TRUE,
  "LEUVEN", TRUE,
  "MESLIN", TRUE,
  "AALST", TRUE,
  "MERKSEM", TRUE,
  "TURNHOU", TRUE,
  "WILRIJK", TRUE,
  "ROESELARE", TRUE,
  "BEVEREN", FALSE,
  "MOL", TRUE,
  "CHARLEROI", TRUE,
  "DILBEEK", TRUE,
  "DROGENBOS", FALSE,
  "JEMAPPES", TRUE,
  "HALLE NEW", TRUE,
  "WILRIJK NEW", TRUE,
  "WATERLO (TIJD)", TRUE,
  "LEDE", TRUE,
  "LA LOUVIERE", TRUE,
  "VILVOORDE", FALSE,
  "ZAVENTEM", TRUE)


xref_shops <- 
  tribble(
  ~shop, ~new_shop, ~new_shop_nr, ~shop_nr, ~shop_open,
  "NAMUR", "NAMUR", 2296, 2296, TRUE,
  "KUURNE","KUURNE", 3981, 3981, TRUE,
  "HALLE","HALLE", 7623, 7623, TRUE,
  "HALLE N","HALLE", 7623, 7623, TRUE,
  "MECHELEN","MECHELEN", 4349, 4349,  TRUE,
  "MECHELE", "MECHELEN", 4349, 4349, TRUE,
  "BREE","BREE", 4389, 4389, TRUE,
  "HERSTAL","HERSTAL", 4391, 4391, TRUE,
  "ZEMST","ZEMST", 4405, 4405,FALSE,
  "GENT","GENT", 4409, 4409, TRUE,
  "OOSTEND","OOSTEND", 4463, 4463, TRUE,
  "DENDERL","DENDERLEEUW", 5149, 5149, TRUE,
  "DENDERLEEUW","DENDERLEEUW", 5149, 5149, TRUE,
  "LOCHRIS","LOCHRISTI", 5162, 5162, TRUE,
  "LOCHRISTI","LOCHRISTI", 5162, 5162, TRUE,
  "BRUGGE","BRUGGE", 5184, 5184, TRUE,
  "LIER","LIER", 5213, 5213,  TRUE,
  "TOURNAI","TOURNAI", 5321, 5321, TRUE,
  "LEUVEN","LEUVEN", 5326, 5326, TRUE,
  "MESLIN","MESLIN", 5332, 5332, TRUE,
  # "AALST","AALST", 5339, 5339,  FALSE,
  "MERKSEM","MERKSEM", 5343,5343,  TRUE,
  "TURNHOU","TURNHOU", 5346, 5346, TRUE,
  "DB WILRIJK NEW","WILRIJK", 8219, 5368,  TRUE,
  "WILRIJK","WILRIJK", 8219, 8219,  TRUE,
  "WILRIJK NEW","WILRIJK", 8219, 8219,  TRUE,
  "ROESELARE","ROESELARE", 5369, 5369, TRUE,
  "ROESELA","ROESELARE", 5369, 5369, TRUE,
  "MOL","MOL", 7196, 7196,  TRUE,
  "CHARLEROI","CHARLEROI", 7197, 7197, TRUE,
  "CHARLER","CHARLEROI", 7197, 7197,  TRUE,
  "DILBEEK","DILBEEK", 7480, 7480, TRUE,
  "JEMAPPE","JEMAPPES", 7602, 7602, TRUE,
  "JEMAPPES","JEMAPPES", 7602, 7602,  TRUE,
  "HALLE","HALLE", 7623, 7623, TRUE,
  "HALLE NEW","HALLE", 7623, 7623, TRUE,
  "WATERLO (TIJD)","WATERLO", 8222, 8222, TRUE,
  "WATERLO", "WATERLO", 8222, 8222, TRUE,
  "WATERLO", "WATERLO", 8222, 3959, TRUE,
  "LEDE","LEDE", 8233, 8233, TRUE,
  "AALST","LEDE", 8233, 8233, TRUE,
  "LOUVIER","LA LOUVIERE", 8287, 8287, TRUE,
  "LA LOUVIERE","LA LOUVIERE", 8287, 8287, TRUE,
  "ZAVENTE","ZAVENTEM", 8495, 8495, TRUE,
  "ZAVENTEM","ZAVENTEM", 8495,8495, TRUE,
  "VILVOOR","VILVOORDE", 8493, 8493, FALSE,
  "VILVOORDE","VILVOORDE", 8493, 8493, FALSE,
  "HUY","HUY", 3712,3712, FALSE,
  "BEVEREN","BEVEREN",7078,7078,FALSE,
  "DROGENB", "DROGENBOS", 7492,7492, FALSE,
  "DROGENBOS", "DROGENBOS", 7492,7492, FALSE,
  "TIENEN",  "TIENEN", 3955, 3955, FALSE
)


xref_provincie <- 
  tribble(
~code_nis_provincie,~provincie,~province,~first_two_numbers,
"04000","BRUSSELS HOOFDSTEDELIJK GEWEST","RÉGION DE BRUXELLES-CAPITALE", "21",
"10000",              "Provincie Antwerpen",       "Province d'Anvers",   "11",
"10000",              "Provincie Antwerpen",       "Province d'Anvers",   "12",
"10000",              "Provincie Antwerpen",       "Province d'Anvers",   "13",
 "20001",              "Provincie Vlaams-Brabant",  "Province du Brabant Flamand",     "23",
"20001",              "Provincie Vlaams-Brabant",  "Province du Brabant Flamand",     "24",
 "30000",              "Provincie West-Vlaanderen", "Province de Flandre Occidentale", "31",
"30000",              "Provincie West-Vlaanderen", "Province de Flandre Occidentale", "33",
"30000",              "Provincie West-Vlaanderen", "Province de Flandre Occidentale", "34",
"30000",              "Provincie West-Vlaanderen", "Province de Flandre Occidentale", "32",
"30000",              "Provincie West-Vlaanderen", "Province de Flandre Occidentale", "38",
"30000",              "Provincie West-Vlaanderen", "Province de Flandre Occidentale", "35",
"30000",              "Provincie West-Vlaanderen", "Province de Flandre Occidentale", "36",
"30000",              "Provincie West-Vlaanderen", "Province de Flandre Occidentale", "37",
 "40000",              "Provincie Oost-Vlaanderen", "Province de Flandre Orientale",   "41",
"40000",              "Provincie Oost-Vlaanderen", "Province de Flandre Orientale",   "42",
"40000",              "Provincie Oost-Vlaanderen", "Province de Flandre Orientale",   "43",
"40000",              "Provincie Oost-Vlaanderen", "Province de Flandre Orientale",   "44",
"40000",              "Provincie Oost-Vlaanderen", "Province de Flandre Orientale",   "45",
"40000",              "Provincie Oost-Vlaanderen", "Province de Flandre Orientale",   "46",
 "70000",              "Provincie Limburg",         "Province du Limbourg",            "71",
"70000",              "Provincie Limburg",         "Province du Limbourg",            "72",
"70000",              "Provincie Limburg",         "Province du Limbourg",            "73",
 "20002",              "Provincie Waals-Brabant",   "Province du Brabant Wallon",      "25",
 "50000",              "Provincie Henegouwen",      "Province du Hainaut",             "51",
"50000",              "Provincie Henegouwen",      "Province du Hainaut",             "52",
"50000",              "Provincie Henegouwen",      "Province du Hainaut",             "53",
"50000",              "Provincie Henegouwen",      "Province du Hainaut",             "55",
"50000",              "Provincie Henegouwen",      "Province du Hainaut",             "56",
"50000",              "Provincie Henegouwen",      "Province du Hainaut",             "57",
"50000",              "Provincie Henegouwen",      "Province du Hainaut",             "58",
 "60000" ,             "Provincie Luik",            "Province de Liège",               "61",
"60000" ,             "Provincie Luik",            "Province de Liège",               "62",
"60000" ,             "Provincie Luik",            "Province de Liège",               "63",
"60000" ,             "Provincie Luik",            "Province de Liège",               "64",
 "80000",              "Provincie Luxemburg",       "Province du Luxembourg",          "81",
"80000",              "Provincie Luxemburg",       "Province du Luxembourg",          "82",
"80000",              "Provincie Luxemburg",       "Province du Luxembourg",          "83",
"80000",              "Provincie Luxemburg",       "Province du Luxembourg",          "84",
"80000",              "Provincie Luxemburg",       "Province du Luxembourg",          "85",
"90000",              "Provincie Namen",           "Province de Namur",               "91",
"90000",              "Provincie Namen",           "Province de Namur",               "92",
"90000",              "Provincie Namen",           "Province de Namur",               "93"
)



# Debug
if(FALSE) {
  
  mdm <- 
    xref_shops %>%
    filter(shop_open) %>%
    select(new_shop) %>%
    unique() %>%
    arrange(new_shop)
  
  print(mdm,n=nrow(mdm))
  
}
