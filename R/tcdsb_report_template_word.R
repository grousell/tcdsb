
#' Report Template - Word
#' A function that downloads an .Rmd template, .R script and Word templates for a TCDSB themed report template.
#' @param report_name
#' Name of the report to be created.
#' @return
#' Templates and scripts to create the report
#' @export
#'
#' @examples

tcdsb_report_template_word <- function(report_name){
  if(file.exists("assets")){
  } else{
    dir.create("assets")
  }

  if(file.exists("R")){
  } else{
    dir.create("R")
  }

  # Download .R file to create the title page ----
  download.file("https://github.com/grousell/tcdsb/blob/master/templates/01_create_word_coverpage.R",
                destfile = "R/01_create_word_coverpage.R"
  )

  # Download title page template ----
  download.file("https://github.com/grousell/tcdsb/blob/master/templates/tcdsb_word_cover_page_template.docx",
                destfile = "assets/tcdsb_word_cover_page_template.docx"
  )

  # Download report template ----
  download.file("https://github.com/grousell/tcdsb/blob/master/templates/tcdsb_word_template.docx",
                destfile = "assets/tcdsb_word_template.docx"
  )

  # Download .rmd ----
  download.file("https://github.com/grousell/tcdsb/blob/master/templates/tcdsb_report_template_word.Rmd",
                destfile = glue::glue("{report_name}.rmd")
  )
}


