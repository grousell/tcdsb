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
  # Create project directory
  dir.create(path, recursive = TRUE, showWarnings = FALSE)

  # Copy skeleton into new project path
  skeleton_path <- system.file(
    "rstudio/templates/project/skeleton",
    package = "tcdsb"
  )
  skeleton_files <- list.files(
    skeleton_path,
    recursive = TRUE,
    all.files = TRUE,
    full.names = TRUE
  )
  skeleton_rel <- list.files(skeleton_path, recursive = TRUE, all.files = TRUE)

  for (i in seq_along(skeleton_files)) {
    dest <- file.path(path, skeleton_rel[[i]])
    dir.create(dirname(dest), recursive = TRUE, showWarnings = FALSE)
    file.copy(skeleton_files[[i]], dest)
  }


  # Fill README template with variables from new project wizard
  readme_path <- file.path(path, "README.md")
  readme <- readLines(readme_path)
  readme <- gsub("\\{\\{project_title\\}\\}", project_title, readme)
  readme <- gsub("\\{\\{project_type\\}\\}", project_type, readme)
  readme <- gsub("\\{\\{project_owner\\}\\}", project_owner, readme)
  readme <- gsub(
    "\\{\\{source_data\\}\\}",
    ifelse(nchar(trimws(source_data)) > 0, source_data, "TBD"),
    readme
  )
  readme <- gsub("\\{\\{date\\}\\}", Sys.Date(), readme)
  writeLines(readme, readme_path)

  # TODO: Placeholder .qmd stubs
  # if (isTRUE(include_presentation)) {
  #   writeLines(
  #     "# Presentation placeholder",
  #     file.path(path, "presentation.qmd")
  #   )
  # }
  # if (isTRUE(include_pdf_report)) {
  #   writeLines("# PDF Report placeholder", file.path(path, "report.qmd"))
  # }
  # if (isTRUE(include_webpage)) {
  #   writeLines("# Webpage placeholder", file.path(path, "index.qmd"))
  # }
}
