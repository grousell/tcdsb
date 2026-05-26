#' Create a TCDSB Project
#'
#' Scaffold function for the RStudio New Project wizard. Can also be called
#' directly from the console.
#'
#' @param path Path to the new project directory.
#' @param project_title Character. Project title.
#' @param project_owner Character. Owner/author name.
#' @param project_type Character. One of \code{"Research"} or \code{"Analytics"}.
#' @param source_data Character. Description of source data.
#' @param include_presentation Logical. Include Quarto presentation stub.
#' @param include_pdf_report Logical. Include Quarto PDF report stub.
#' @param include_webpage Logical. Include Quarto webpage stub.
#' @param ... Additional arguments (ignored).
#'
#' @return Called for side effects.
#' @export
tcdsb_project <- function(
  path,
  project_title = "My TCDSB Project",
  project_owner = "Author",
  project_type = "Research",
  source_data = "",
  include_presentation = FALSE,
  include_pdf_report = FALSE,
  include_webpage = FALSE,
  ...
) {
  dir.create(path, recursive = TRUE, showWarnings = FALSE)

  skeleton_path <- system.file(
    "rstudio/templates/project/skeleton",
    package = "tcdsb"
  )
  skeleton_files <- list.files(skeleton_path, recursive = TRUE,
                                all.files = TRUE, full.names = TRUE)
  skeleton_rel   <- list.files(skeleton_path, recursive = TRUE,
                                all.files = TRUE)

  for (i in seq_along(skeleton_files)) {
    dest <- file.path(path, skeleton_rel[[i]])
    dir.create(dirname(dest), recursive = TRUE, showWarnings = FALSE)
    file.copy(skeleton_files[[i]], dest)
  }

  readme_path <- file.path(path, "README.md")
  readme      <- readLines(readme_path)
  readme      <- gsub("\\{\\{project_title\\}\\}", project_title, readme)
  readme      <- gsub("\\{\\{project_type\\}\\}",  project_type,  readme)
  readme      <- gsub("\\{\\{project_owner\\}\\}", project_owner, readme)
  readme      <- gsub(
    "\\{\\{source_data\\}\\}",
    ifelse(nchar(trimws(source_data)) > 0, source_data, "TBD"),
    readme
  )
  readme      <- gsub("\\{\\{date\\}\\}", Sys.Date(), readme)
  writeLines(readme, readme_path)
}
