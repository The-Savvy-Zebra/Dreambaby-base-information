

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
  ~shop, ~new_shop, ~new_shop_nr, ~shop_nr, ~shop_open, ~location,  ~zipcode,
  "NAMUR", "NAMUR", 2296, 2296, TRUE, "NAMEN", 5100, 
  "KUURNE","KUURNE", 3981, 3981, TRUE, "KUURNE", 8520,
  "HALLE","HALLE", 7623, 7623, TRUE, "HALLE", 1500,
  "HALLE N","HALLE", 7623, 7623, TRUE, "HALLE", 1500,
  "MECHELEN","MECHELEN", 4349, 4349,  TRUE, "MECHELEN", 2800,
  "MECHELE", "MECHELEN", 4349, 4349, TRUE, "MECHELEN", 2800,
  "BREE","BREE", 4389, 4389, TRUE, "BREE", 3960,
  "HERSTAL","HERSTAL", 4391, 4391, TRUE, "HERSTAL", 4040,
  "ZEMST","ZEMST", 4405, 4405,FALSE, "ZEMST", 1804,
  "GENT","GENT", 4409, 4409, TRUE, "GENT", 9000,
  "OOSTEND","OOSTEND", 4463, 4463, TRUE, "OOSTENDE", 8400,
  "DENDERL","DENDERLEEUW", 5149, 5149, TRUE, "DENDERLEEUW", 9470,
  "DENDERLEEUW","DENDERLEEUW", 5149, 5149, TRUE, "DENDERLEEUW", 9470,
  "LOCHRIS","LOCHRISTI", 5162, 5162, TRUE, "LOCHRISTI", 9080,
  "LOCHRISTI","LOCHRISTI", 5162, 5162, TRUE, "LOCHRISTI", 9080,
  "BRUGGE","BRUGGE", 5184, 5184, TRUE, "BRUGGE", 8000,
  "LIER","LIER", 5213, 5213,  TRUE, "LIER", 2500,
  "TOURNAI","TOURNAI", 5321, 5321, TRUE, "DOORNIK", 7500,
  "LEUVEN","LEUVEN", 5326, 5326, TRUE, "LEUVEN", 3000,
  "MESLIN","MESLIN", 5332, 5332, TRUE, "MESLIN-L'ÉVEQUE", 7822,
  # "AALST","AALST", 5339, 5339,  FALSE,
  "MERKSEM","MERKSEM", 5343,5343,  TRUE, "MERKSEM", 2170, 
  "TURNHOU","TURNHOU", 5346, 5346, TRUE, "TURNHOUT", 2300,
  "DB WILRIJK NEW","WILRIJK", 8219, 5368,  TRUE, "WILRIJK", 2610,
  "WILRIJK","WILRIJK", 8219, 8219,  TRUE, "WILRIJK", 2610,
  "WILRIJK NEW","WILRIJK", 8219, 8219,  TRUE, "WILRIJK", 2610,
  "ROESELARE","ROESELARE", 5369, 5369, TRUE, "ROESELARE", 8800,
  "ROESELA","ROESELARE", 5369, 5369, TRUE, "ROESELARE", 8800,
  "MOL","MOL", 7196, 7196,  TRUE, "MOL", 2400,
  "CHARLEROI","CHARLEROI", 7197, 7197, TRUE, "MARCINELLE", 6001,
  "CHARLER","CHARLEROI", 7197, 7197,  TRUE, "MARCINELLE", 6001,
  
  "DILBEEK","DILBEEK", 7480, 7480, TRUE, "DILBEEK", 1700,
  
  "JEMAPPE","JEMAPPES", 7602, 7602, TRUE, "JEMAPPES", 7012,
  "JEMAPPES","JEMAPPES", 7602, 7602,  TRUE, "JEMAPPES", 7012,
  "HALLE","HALLE", 7623, 7623, TRUE, "HALLE", 1500,
  "HALLE NEW","HALLE", 7623, 7623, TRUE, "HALLE", 1500,
  "WATERLO (TIJD)","WATERLO", 8222, 8222, TRUE, "WATERLOO", 1410,
  "WATERLO", "WATERLO", 8222, 8222, TRUE, "WATERLOO", 1410,
  "WATERLO", "WATERLO", 8222, 3959, TRUE, "WATERLOO", 1410,
  "LEDE","LEDE", 8233, 8233, TRUE, "LEDE", 9340,
  "AALST","LEDE", 8233, 8233, TRUE, "LEDE", 9340,
  "LOUVIER","LA LOUVIERE", 8287, 8287, TRUE, "LA LOUVIERE", 7100,
  "LA LOUVIERE","LA LOUVIERE", 8287, 8287, TRUE, "LA LOUVIERE", 7100,
  "ZAVENTE","ZAVENTEM", 8495, 8495, TRUE, "ZAVENTEM", 1932,
  "ZAVENTEM","ZAVENTEM", 8495,8495, TRUE, "ZAVENTEM", 1932,
  "VILVOOR","VILVOORDE", 8493, 8493, FALSE, "VILVOORDE", 1800,
  "VILVOORDE","VILVOORDE", 8493, 8493, FALSE, "VILVOORDE", 1800,
  "HUY","HUY", 3712,3712, FALSE, "HUY", 4500,
  "BEVEREN","BEVEREN",7078,7078,FALSE, "BEVEREN", 9120,
  "DROGENB", "DROGENBOS", 7492,7492, FALSE, "DROGENBOS", 1620,
  "DROGENBOS", "DROGENBOS", 7492,7492, FALSE, "DROGENBOS", 1620,
  "TIENEN",  "TIENEN", 3955, 3955, FALSE, "TIENEN", 3300
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
