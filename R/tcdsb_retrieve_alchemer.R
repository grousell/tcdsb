#' TCDSB - Retrieve Alchemer Data
#'
#' @param x
#' Alchemer survey number
#'
#' @return Data frame with survey data, plus a data dictionary
#' @export
#'
#' @examples
#' # tcdsb_retrieve_alchemer("XXXXXXX")
#'
tcdsb_retrieve_alchemer <- function(x){
  # requires user to have token and secret_key stored as objects
  # x is the survey number from Alchemer

  if (exists("final_df")){
    remove(final_df)
  }

  survey_url <- glue::glue("https://api.alchemer-ca.com/v5/survey/{x}/surveyresponse")
  survey_req <- httr2::request(survey_url)

  for (i in c(1:250)) {
    # Make sure environment is empty or else will append existing dataframe
    survey <- survey_req |>
      httr2::req_url_query(
        `api_token` = token,
        `api_token_secret` = secret_key,
        `resultsperpage` = 500,
        page = i
      )

    temp_survey_df <- jsonlite::fromJSON(survey$url, flatten = TRUE)

    if (length(temp_survey_df$data) == 0) {
      break
    } else {
      temp_df <- temp_survey_df$data
    }

    if (!exists("final_df")) {
      final_df <- temp_df
    } else {
      final_df <- final_df |> dplyr::bind_rows(temp_df)
    }
  }
  ## Create dataframe of question names
  data_dictionary <<- final_df |>
    dplyr::select(dplyr::matches(".id|question")) |>
    dplyr::select(!dplyr::matches("_id")) |>
    head(1) |>
    tidyr::pivot_longer(
      cols = dplyr::ends_with("question"),
      names_to = "column_header",
      values_to = "question") |>
    dplyr::select(
      dplyr::all_of(
        c("column_header", "question")
      )
    )
  # Return final data frame

  final_df <- final_df |>
    dplyr::select(
      c(1:22, dplyr::contains("answer"))
    ) |>
    dplyr::select(!dplyr::contains("id")) |>
    janitor::clean_names()

  return(final_df)
}



# token <- keyring::key_get("alchemer", "token")
# secret_key <- keyring::key_get("alchemer", "secret")
#
# demo_survey <- "50269987"
#
# df <- tcdsb_retrieve_alchemer(demo_survey)
