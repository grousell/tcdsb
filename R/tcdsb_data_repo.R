#' Connect to The Research Data Repo
#'
#' \strong{Retired Function.}
#'
#' This helper function is deprecated and retained for documentation purposes.
#' It no longer creates a database connection.
#'
#' The original intent of this function was to standardize connection details and
#' provide retry logic around \code{DBI::dbConnect()}. However, RStudio's
#' Connections pane only detects direct calls to \code{DBI::dbConnect()},
#' causing wrapped connections to behave unreliably. Use
#' \code{DBI::dbConnect()} directly instead.
#'
#' Store connection settings in \code{.Renviron} so infrastructure details do
#' not appear in project code. This makes future infrastructure changes easier,
#' since connection details can be updated centrally without modifying existing
#' analysis projects.
#'
#' @param ... Deprecated. Ignored.
#'
#' @return Invisibly returns \code{NULL}. Displays guidance on the
#'   connection pattern.
#'
#' @examples
#' \dontrun{
#'
#' # In your R console, run:
#' usethis::edit_r_environ()
#'
#' # Add the lines provided in the file on the department sharepoint/onedrive:
#' #   Documentation/R/R_Environment.docx
#'
#' # Environment variables from this file can then be accessed using:
#' Sys.getenv("VARIABLE_NAME")
#'
#'
#' # STANDARD CONNECTION (Laptop / Interactive Use)
#'
#' data_repo <- DBI::dbConnect(
#'   odbc::odbc(),
#'   Server = Sys.getenv("DATA_REPO_URL"),
#'   Database = Sys.getenv("DATA_REPO_DATABASE"),
#'   Authentication = "ActiveDirectoryInteractive",
#'   UID = paste0(Sys.getenv("USERNAME"), "@tcdsb.org"),
#'   Driver = Sys.getenv("DRIVER"),
#'   Encrypt = "yes"
#' )
#'
#' # This will prompt for MFA authentication when connecting.
#' #
#' # To improve reproducibility, place database downloads in an
#' # 01_data_download.R or 01_data_cleaning.R script and save the
#' # resulting intermediate files. Subsequent scripts can then use
#' # the saved data without repeatedly connecting to the database.
#'
#'
#' # AUTOMATED CONNECTION USING A SERVICE ACCOUNT
#'
#' # Service accounts are used for scheduled refreshes, automated
#' # reports, and unattended data pipelines.
#'
#' for (i in 1:3) { # Try the connection 3 times
#'
#'   data_repo <- tryCatch(
#'     DBI::dbConnect(
#'       odbc::odbc(),
#'       Server = Sys.getenv("DATA_REPO_URL"),
#'       Database = Sys.getenv("DATA_REPO_DATABASE"),
#'       UID = "tcdsb_research_dept_read_data",
#'       PWD = keyring::key_get(
#'         service = "studentanalytics",
#'         username = "tcdsb_research_dept_read_data"
#'       ),
#'       Driver = Sys.getenv("DRIVER"),
#'       Encrypt = "yes"
#'     ),
#'     error = function(e) NULL
#'   )
#'
#'   if (!is.null(data_repo))
#'     break
#'
#'   if (i < 3)
#'     Sys.sleep(30)
#' }
#'
#' if (is.null(data_repo))
#'   stop("Could not connect after 3 attempts.")
#' # Note that the `tryCatch()` may break Rstudio's connection pane.
#'
#' # DIFFERENT CONNECTION STRATEGIES BY ENVIRONMENT
#' # ENVIRONMENT is set in .Renviron
#'
#' if (Sys.getenv("ENVIRONMENT") == "Laptop") {
#'
#'   data_repo <- DBI::dbConnect(
#'     odbc::odbc(),
#'     Server = Sys.getenv("DATA_REPO_URL"),
#'     Database = Sys.getenv("DATA_REPO_DATABASE"),
#'     Authentication = "ActiveDirectoryInteractive",
#'     UID = paste0(Sys.getenv("USERNAME"), "@tcdsb.org"),
#'     Driver = Sys.getenv("DRIVER"),
#'     Encrypt = "yes"
#'   )
#'
#' } else if (Sys.getenv("ENVIRONMENT") == "VPS") {
#'   srv_act <- "service_account_name"
#'   data_repo <- DBI::dbConnect(
#'     odbc::odbc(),
#'     Server = Sys.getenv("DATA_REPO_URL"),
#'     Database = Sys.getenv("DATA_REPO_DATABASE"),
#'     UID = srv_act,
#'     PWD = keyring::key_get(
#'       service = "studentanalytics",
#'       username = srv_act
#'     ),
#'     Driver = Sys.getenv("DRIVER"),
#'     Encrypt = "yes"
#'   )
#'
#' }
#'
#'
#' # DATA LOADER / TABLE UPLOAD ACCOUNT
#'
#' # Example of using a data upload-only restricted service account:
#' srv_act <- "service_account_name"
#' data_repo <- DBI::dbConnect(
#'   odbc::odbc(),
#'   Server = Sys.getenv("DATA_REPO_URL"),
#'   Database = Sys.getenv("DATA_REPO_DATABASE"),
#'   UID = srv_act,
#'   PWD = keyring::key_get(
#'     service = "studentanalytics",
#'     username = srv_act
#'   ),
#'   Driver = Sys.getenv("DRIVER"),
#'   Encrypt = "yes"
#' )
#'
#' DBI::dbGetQuery(
#'   data_repo,
#'   "drop table if exists test_upload"
#' )
#'
#' DBI::dbWriteTable(
#'   conn = data_repo,
#'   name = DBI::Id(table = "test_upload"),
#'   value = palmerpenguins::penguins
#' )
#' # Alternative schema can be specified with schema = "alternative_schema" 
#' # and use schema.tablename elsewhere.
#'
#' # The loader account should not be able to read this table.
#' # This should return a permission error:
#'
#' DBI::dbGetQuery(
#'   data_repo,
#'   "select * from test_upload"
#' )
#'
#' # But it can delete the table
#' 
#' DBI::dbGetQuery(
#'   data_repo,
#'   "drop table if exists test_upload"
#' )
#'
#' DBI::dbDisconnect(data_repo)
#'
#'
#' # SQL command for rotating a loader account password:
#' #
#' # alter user service_account_name with password = 'new_secure_password'
#'
#' }
#' @export
#' 
tcdsb_connect_data_repo <- function(...) {
  .Deprecated(  msg = "Use DBI::dbConnect() directly. See ?tcdsb::tcdsb_connect_data_repo.")
  args <- list(...)
  configure_info <- paste(
      "You have probably not set up .Renviron yet.",
      "",
      "Run:",
      "  usethis::edit_r_environ()",
      "",
      "Add the lines documented in the dept. sharepoint/onedrive:",
      "  Documentation/R/R_Environment.docx",
      sep = "\n"
  )
  required_vars <- c("DATA_REPO_URL", "DATA_REPO_DATABASE", "DRIVER")
  if (any(Sys.getenv(required_vars) == ""))  stop(configure_info, call. = FALSE)
  
  message(
    paste(
      "This helper function wrapped DBI::dbConnect() but could not be made to work properly",
      "with RStudio's Connections tab and so is no longer to be used.",
      "",
      "Instead, use the following code snippet:",
      "",
      '  data_repo <- DBI::dbConnect(odbc::odbc(),',
      '    Server = Sys.getenv("DATA_REPO_URL"),',
      '    Database = Sys.getenv("DATA_REPO_DATABASE"),',
      '    Authentication = "ActiveDirectoryInteractive",',
      '    UID = paste0(Sys.getenv("USERNAME"), "@tcdsb.org"),',
      '    Driver = Sys.getenv("DRIVER")',
      '    Encrypt = "yes"',
      '    )',
      "",
      "For more details and alternative connections, see:",
      "  ?tcdsb::tcdsb_connect_data_repo",
      sep = "\n"
    )
  )
  invisible(NULL)

}
#
