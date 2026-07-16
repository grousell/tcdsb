# Project Dependencies Loading
# `00_setup.R`

# Each script will want to source this setup script so libraries are available:
# source("R/00_setup.R")

#########################
# PACKAGE DEPENDENCIES  #
#########################

# Ensure pak is available.
if (!require("pak")) {
  install.packages("pak")
}

# Require latest TCDSB package
# Note: this will automatically update if a new version is unavailable.
pak::pkg_install("grousell/tcdsb", ask=FALSE)

## Un-comment to see the list of packages installed via department package:
#pak::pkg_deps_tree("grousell/tcdsb")
## or
#pak::pkg_deps("grousell/tcdsb")$package

# Load packages required for this project.
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
