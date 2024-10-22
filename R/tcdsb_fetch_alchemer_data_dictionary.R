#' TCDSB Fetch Alchemer Survey Data
#' A function that retrieves data from TCDSB's Alchemer account.
#' Requires user to have set up an API with Alchemer, including
#' a token and secret key
#'
#' @param survey_number
#' Alchemer survey number, retrieved from survey URL
#' @return
#' A data frame of question numbers and question labels
#' @export
#'
#' @examples
#' # token <- keyring::key_get("alchemer", "token")
#' # secret_key <- keyring::key_get("alchemer", "secret")
#' # tcdsb_fetch_alchemer_data_dictionary("XXXXXXXX")

tcdsb_fetch_alchemer_data_dictionary <- function(survey_number){

  survey_url <- glue::glue("https://api.alchemer-ca.com/v5/survey/{survey_number}/surveyquestion")
  survey_req <- httr2::request(survey_url)

  survey <- survey_req |>
    httr2::req_url_query(
      `api_token` = token,
      `api_token_secret` = secret_key,
      `resultsperpage` = 25,
      page = 1
    )

  temp_df <- jsonlite::fromJSON(survey$url, flatten = TRUE)
  temp_df <- temp_df$data

  temp_df |>
    dplyr::select(id,
                  "label" = title.English,
                  options) |>
    tidyr::unnest(options,
                  names_sep = "_",
                  keep_empty = TRUE) |>
    dplyr::select(id, label, options_id, options_value)

}
