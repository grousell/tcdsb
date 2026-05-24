# Project Dependencies Loading
# `00_setup.R`


#########################
# PACKAGE DEPENDENCIES  #
#########################

# Ensure Require package is available.
if (!require("Require")) {
  install.packages("Require")
}

# Require latest TCDSB package
# Note: this will automatically update if a new
#       version is available.
Require::Require("grousell/tcdsb@development (HEAD)")

# Define all packages required for this project.
# Note: alternatively, use Require::Install() to ensure
#       a package is available using the
#       `packagename::function()` syntax.
Require::Require(
                 c("dplyr",
                   "dbplyr",
                   "tidyr",
                   "stringr",
                   "glue",
                   "ggplot2",
                   "gt",
                   "usethis"
                   )
                 )
# Customize the above example as needed.



#########################
#      DATA SOURCES     #
#########################

# Add raw data sources




#########################
#  OTHER REQUIREMENTS   #
#########################

# Add any other project requirements
