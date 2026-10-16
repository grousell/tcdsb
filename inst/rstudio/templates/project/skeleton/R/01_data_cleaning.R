# Data Cleaning
# `01_data_cleaning.R`

source("R/00_setup.R")

## DATA SOURCES ----------------------------------------------------------------

# Uncomment to connect to the Data Repo
# data_repo <- DBI::dbConnect(
#   odbc::odbc(),
#   Server = Sys.getenv("DATA_REPO_URL"),
#   Database = Sys.getenv("DATA_REPO_DATABASE"),
#   Authentication = "ActiveDirectoryInteractive",
#   UID = paste0(Sys.getenv("USERNAME"), "@tcdsb.org"),
#   Driver = Sys.getenv("DRIVER"),
#   Encrypt = "yes"
# )




## BASIC  CLEANING -------------------------------------------------------------




## SAVE INTERIM DATA  ----------------------------------------------------------

# Example:
# save(table1, variable1, table2, list1, file = "data/intermediate.RData")
