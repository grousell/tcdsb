
tcdsb_report_template_quarto <- function(report_name){

  report_name <- deparse(substitute(report_name)) #makes names a character string

  if(file.exists("assets")){
  } else{
    dir.create("assets")
  }

  if(file.exists("R")){
  } else{
    dir.create("R")
  }

  if(file.exists("styles")){
  } else{
    dir.create("styles")
  }

  # Download .qmd ----

  download.file("https://raw.githubusercontent.com/grousell/tcdsb/master/templates/tcdsb_presentation_template_revealjs.qmd",
                destfile = glue::glue("{report_name}.qmd")
  )

  # Download clean title page html file ----
  download.file("https://raw.githubusercontent.com/grousell/tcdsb/refs/heads/master/templates/clean_title_page.html",
                destfile = "styles/clean_title_page.html"
  )

  # Download .css and .scss files ----

  download.file("https://raw.githubusercontent.com/grousell/tcdsb/refs/heads/master/templates/tcdsb_revealjs.scss",
                destfile = "styles/tcdsb_revealjs.scss"
  )

  download.file("https://raw.githubusercontent.com/grousell/tcdsb/refs/heads/master/templates/tcdsb_extras.css",
                destfile = "styles/tcdsb_extras.css"
  )


  # Download TCDSB images ----

  download.file("https://github.com/grousell/tcdsb/blob/master/assets/title_slide_background.png?raw=true",
                destfile = "assets/title_slide_background.png",
                mode = "wb")

  download.file("https://github.com/grousell/tcdsb/blob/master/images/r_a_logo.png?raw=true",
                destfile = "assets/r_a_logo.png",
                mode = "wb")

}


