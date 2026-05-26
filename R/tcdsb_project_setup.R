#' TCDSB Project Setup
#'
#' Sets up a standard TCDSB project structure in the current working directory.
#' This function is retained for console/historical use; the RStudio New Project
#' wizard calls \code{tcdsb_project()} directly.
#'
#' @param project_title Character. Title for the project README.
#' @param project_type Character. One of \code{"Research"} or \code{"Analytics"}.
#' @param source_data Character. Description of the source data.
#'
#' @return Called for side effects; creates directories and README.
#' @export
#'
#' @examples
#' # tcdsb_project_setup()
tcdsb_project_setup <- function(project_title = "My TCDSB Project",
                                 project_type = "Research",
                                 source_data = "") {
  tcdsb_project(
    path          = getwd(),
    project_title = project_title,
    project_type  = project_type,
    source_data   = source_data
  )
}
