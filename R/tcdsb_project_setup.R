
#' TCDSB Project Setup
#' A function that sets up a project folder. Creates a README file subfolders.
#' @return
#' README file and subfolders
#' @export
#'
#' @examples
#' # tcdsb_project_setup()

tcdsb_project_setup <- function(){

  if(file.exists("README.md")){
  } else{
    usethis::use_readme_md()
  }

  if(file.exists("R")){
  } else{
    dir.create("R")
  }

  if(file.exists("reference_docs")){
  } else{
    dir.create("reference_docs")
  }

  if(file.exists("data_raw")){
  } else{
    dir.create("data_raw")
  }

  if(file.exists("data")){
  } else{
    dir.create("data")
  }

  if(file.exists("assets")){
  } else{
    dir.create("assets")
  }
}
