#' Report Template - Quarto PDF
#' A function that downloads an .qmd template and associate .typ and .lua files for a TCDSB themed report template.
#' @param report_name
#' Name of the report to be created.
#' @return
#' Templates and scripts to create the report
#' @export
#'
#' @examples
#' #tcdsb_report_template_quarto("test_report")

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

  # Download .qmd ----

  download.file("https://raw.githubusercontent.com/grousell/tcdsb/master/templates/tcdsb_report_template.qmd",
                destfile = glue::glue("{report_name}.qmd")
  )

  # Download .typ files ----
  download.file("https://raw.githubusercontent.com/grousell/tcdsb/refs/heads/master/templates/typst-show.typ",
                destfile = "typst-show.typ"
                )

  download.file("https://raw.githubusercontent.com/grousell/tcdsb/refs/heads/master/templates/typst-template.typ",
                destfile = "typst-show.typ"
  )

  # Download TCDSB images ----
  download.file("https://github.com/grousell/tcdsb/blob/master/images/title_page_background.png?raw=true",
                destfile = "assets/title_page_background.png",
                mode = "wb")

  download.file("https://github.com/grousell/tcdsb/blob/master/images/tcdsb_logo_BW.png?raw=true",
                destfile = "assets/tcdsb_logo_BW.png",
                mode = "wb")

  download.file("https://github.com/grousell/tcdsb/blob/master/images/r_a_logo.png?raw=true",
                destfile = "assets/r_a_logo.png",
                mode = "wb")

  }


