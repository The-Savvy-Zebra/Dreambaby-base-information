source("R/Load Libraries.R")
source("R/References.R")
source("R/Supporting Functions.R")

# Extract Rental and Depreciation by Shop
startTextInBlue("Rental and Depreciation by Shop")
source("R/Extract Rental and Depr by Shop.R")
stopTextInGreen("Rental and Depreciation by Shop")

# Extract Shop Surface
startTextInBlue("Shop Surface")
source("R/Extract Shop Surface.R")
stopTextInGreen("Shop Surface")

# Extract Shop-Region base data
startTextInBlue("Shop-Region base data")
source("R/Extract Shop-region data.R")
stopTextInGreen("Shop-Region base data")

# Extract Personnel Cost
startTextInBlue("Personnel Cost")
source("R/Extract_Personnel_Cost.R")
stopTextInGreen("Personnel Cost")

# Extract Personnel Hours
startTextInBlue("Personnel Hours")
source("R/Extract_Personnel_Hours.R")
stopTextInGreen("Personnel Hours")

# Extract Revenue Cost
startTextInBlue("Revenue Cost")
source("R/Extract_Revenue_by_Shop.R")
stopTextInGreen("Revenue Cost")

# Extract Number of Tickets
startTextInBlue("Number of Tickets")
source("R/Extract_Number_Tickets.R")
stopTextInGreen("Number of Tickets")

