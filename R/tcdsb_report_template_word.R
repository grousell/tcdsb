
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
                destfile = glue::glue("assets/{report_name}.docx")
  )
}


tcdsb_report_template_word()
