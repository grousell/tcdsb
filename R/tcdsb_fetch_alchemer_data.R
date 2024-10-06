#' TCDSB Fetch Alchemer Survey Data
#' A function that retrieves data from TCDSB's Alchemer account.
#' Requires user to have set up an API with Alchemer, including
#' a token and secret key
#'
#' @param survey_number
#' Alchemer survey number, retrieved from survey URL
#' @return
#' Cleaned data frame of survey data
#' @export
#'
#' @examples
#' # token <- keyring::key_get("alchemer", "token")
#' # secret_key <- keyring::key_get("alchemer", "secret")
#' # tcdsb_fetch_alchemer_data("XXXXXXXX")

tcdsb_fetch_alchemer_data <- function(survey_number){

  survey_url <- glue::glue("https://api.alchemer-ca.com/v5/survey/{survey_number}/surveyresponse")
  survey_req <- httr2::request(survey_url)

  for (i in c(1:250)) {

    survey <- survey_req |>
      httr2::req_url_query(
        `api_token` = token,
        `api_token_secret` = secret_key,
        `resultsperpage` = 250,
        page = i
      )

    temp_survey_df <- jsonlite::fromJSON(survey$url, flatten = TRUE)

    if (length(temp_survey_df$data) == 0) {
      break
    } else {
      temp_df <- temp_survey_df$data |>
        dplyr::select(
          c(1, 3:5, 8, 14),
          tidyr::ends_with("answer")
        )
    }

    if(!exists("new_df")){
      new_df <- temp_df
    } else {
      new_df <- new_df |>
        dplyr::bind_rows(temp_df)
    }
  }

  names(new_df) <- stringr::str_replace_all(names(new_df), "survey_data.", "Q")
  names(new_df) <- stringr::str_replace_all(names(new_df), ".answer", "")

  return(new_df)
}


