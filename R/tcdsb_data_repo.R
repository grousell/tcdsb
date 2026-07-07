#' Connect to The Research Data Repo
#'
#' Function standardizes the data repo connection details across projects and
#' increases connection reliability, also updating the connections tab
#' in Rstudio and Positron.
#'
#' Currently wraps \code{DBI::dbConnect()} with retry logic and department
#' defaults. Existing \code{DBI::dbConnect(odbc::odbc(), ...)} calls can be
#' replaced with \code{connect_data_repo(...)} unchanged. Underlying database
#' can be changed in the future without breaking department code if the defaults
#' are used.
#'
#' @param ... Arguments passed directly to \code{DBI::dbConnect(odbc::odbc())}.
#'   If \code{Server} and \code{Database} are omitted, they default to the
#'   \code{server_url} and \code{database_name} environment variables (set in
#'   \code{.Renviron} via \code{usethis::edit_r_environ()}), falling back to
#'   \code{server_url} and \code{database_name} objects in the global environment
#'   if the environment variables are not set.
#'   If \code{UID} is omitted, defaults to \code{USERNAME@tcdsb.org}.
#'   If \code{PWD} is supplied, password auth is used for service accounts; otherwise
#'   \code{Authentication = "ActiveDirectoryInteractive"}.
#'
#' @return A \code{DBIConnection} object.
#'
#' @examples
#' \dontrun{
#' # Use all defaults (requires .Renviron setup)
#' data_repo <- tcdsb_connect_data_repo()
#'
#' # Override database only
#' data_repo <- tcdsb_connect_data_repo(Server = "Otherserver", Database = "OtherDB")
#'
#' # Using a service account via keyring package
#' data_repo <- tcdsb_connect_data_repo(UID = "tcdsb_research_dept_read_data",
#'            PWD = keyring::key_get("studentanalytics", "tcdsb_research_dept"),
#'
#' }
#' @export
tcdsb_connect_data_repo <- function(...) {
  args <- list(...)
  configure_info <- "You have probably not set up .Renviron with the connection url yet. \n
  Add to .Renviron using the command: usethis::edit_r_environ() \n
  The lines are available in sharepoint under Documentation/R/R_Environment.docx"

  # Order of preference for server url and database:
  #   1. argument to the function
  #   2. environment variable (.Renviron)
  #   3. variable in the global environment.

  if (is.null(args$Server)) {
    args$Server <- Sys.getenv("server_url", unset = NA)
    if (is.na(args$Server)) {
      if (!exists("server_url", envir = .GlobalEnv))
        stop("No `Server` supplied and `server_url` not found in global environment.\n",
             configure_info)
      args$Server <- get("server_url", envir = .GlobalEnv)
    }
  }

  if (is.null(args$Database)) {
    args$Database <- Sys.getenv("database_name", unset = NA)
    if (is.na(args$Database)) {
      if (!exists("database_name", envir = .GlobalEnv))
        stop("No `Database` supplied and `database_name` not found in global environment.\n",
             configure_info)
      args$Database <- get("database_name", envir = .GlobalEnv)
    }
  }

  if (is.null(args$Driver))
    args$Driver <- "ODBC Driver 17 for SQL Server"

  if (is.null(args$UID))
    args$UID <- paste0(Sys.getenv("USERNAME"), "@tcdsb.org")

  if (is.null(args$PWD) && is.null(args$Authentication))
    args$Authentication <- "ActiveDirectoryInteractive"

  conn       <- NULL
  last_error <- NULL
  for (i in 1:5) {
    result <- tryCatch(
      do.call(DBI::dbConnect, c(odbc::odbc(), args)),
      error = function(e) e
    )

    if (inherits(result, "error")) {
      last_error <- conditionMessage(result)
      if (grepl("28000", last_error))
        stop("Authentication failure (ODBC 28000): aborting to avoid lockout:\n", last_error)
      if (i < 5) Sys.sleep(0.5 * i)
    } else {
      conn <- result
      break
    }
  }

  if (is.null(conn))
    stop(sprintf("Cannot connect to %s / %s after %d attempts.\nLast error: %s",
                 args$Server, args$Database, 5L, last_error))

  observer <- getOption("connectionObserver")
  if (!is.null(observer))
    observer$connectionOpened(
      type             = "ODBC",
      host             = args$Server,
      displayName      = paste(args$Server, args$Database, sep = " / "),
      connectCode      = sprintf('tcdsb_connect_data_repo(%s)',
                                 paste(
                                   mapply(function(k, v) sprintf('%s = "%s"', k, v), names(args), args),
                                   collapse = ", "
                                 )),
      disconnect = function() try(DBI::dbDisconnect(conn), silent = TRUE),
      listObjectTypes  = function() list(table = list(contains = "data")),
      listObjects = function(...) {
        try(
          data.frame(name = DBI::dbListTables(conn), type = "table", stringsAsFactors = FALSE),
          silent = TRUE
        )
      },
      listColumns      = function(...) data.frame(name = character(), type = character()),
      previewObject    = function(rowLimit, ...) data.frame(),
      connectionObject = conn
    )

  message(sprintf("Connected to %s / %s.", args$Server, args$Database))
  return(conn)
}
#
