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
# Note: this will load our internal package from Github.
Require::Require("grousell/tcdsb@master (HEAD)")


# Define all packages required for this project.
# When looking for a tool to solve a particular problem,
# browse the "tidyverse" first and add the package to this list:
#          https://tidyverse.org/packages/
# Second, search for your issue with:
#          https://www.rseek.org/
# Links that end in "- CRAN" or "- Tidyverse" are documentation for packages.
# that can be added to the project list below.
Require::Require(
                 c("dplyr", # https://rstudio.github.io/cheatsheets/data-transformation.pdf
                   "dbplyr",   # https://dbplyr.tidyverse.org/
                   "tidyr",    # https://tidyr.tidyverse.org/
                   "stringr",  # https://stringr.tidyverse.org/
                   "glue",     # https://glue.tidyverse.org/
                   "ggplot2",  # https://ggplot2.tidyverse.org/
                   "gt",       # https://gt.rstudio.com/
                   "readr"     # https://readr.tidyverse.org/
                   )
                 )
# Note: alternatively, you may use Require::Install() to ensure
#       a package is only available using the
#       `packagename::function()` syntax.



#########################
#      DATA SOURCES     #
#########################

# Add raw data sources




#########################
#  OTHER REQUIREMENTS   #
#########################

# Add any other project requirements
