# Project Dependencies Loading
# `00_setup.R`

# Each subsequent script should source this setup script with:
# source("R/00_setup.R")

## PROJECT DEPENDENCIES --------------------------------------------------------

# Require latest TCDSB package
# Check once per day and automatically update if a new version is unavailable:
stamp_file <- file.path(Sys.getenv("LOCALAPPDATA"), "tcdsb_last_update")
if (!file.exists(stamp_file) || as.Date(file.info(stamp_file)$mtime) < Sys.Date()) {
  if (!require("pak")) { # Install pak if needed
    install.packages("pak") 
  }
  pak::pkg_install("grousell/tcdsb", ask = FALSE) 
  file.create(stamp_file) 
}

## Un-comment to see the list of packages installed via department package:
#pak::pkg_deps_tree("grousell/tcdsb")
## or
#pak::pkg_deps("grousell/tcdsb")$package

# Load packages required for this project (edit to your needs).
library(tcdsb)     # https://github.com/grousell/tcdsb

# Data Manipulation
library(dplyr)     # https://dplyr.tidyverse.org/
library(dbplyr)    # https://dbplyr.tidyverse.org/
library(tidyr)     # https://tidyr.tidyverse.org/
library(stringr)   # https://stringr.tidyverse.org/
library(glue)      # https://glue.tidyverse.org/

# Visualization
library(ggplot2)   # https://ggplot2.tidyverse.org/articles/ggplot2.html
library(gt)        # https://gt.rstudio.com/articles/gt.html



#########################
#  OTHER REQUIREMENTS   #
#########################

# Add any other project requirements that should be run before any other script.
