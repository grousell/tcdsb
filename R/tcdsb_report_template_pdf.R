#' Report Template - PDF
#' A function that downloads an .Rmd template, images and .tex files for a TCDSB themed report template.
#' @param report_name
#' Name of the report to be created.
#' @return Templates and images for a TCDSB themed report
#' @export
#'
#' @examples
#' # tcdsb_report_template_pdf(test_report)

tcdsb_report_template_pdf <- function(report_name){

  report_name <- deparse(substitute(report_name)) #makes names a character string

  # Download .rmd file ----
  download.file("https://raw.githubusercontent.com/grousell/tcdsb/master/templates/tcdsb_report_template.Rmd",
                destfile = glue::glue("{report_name}.rmd")
  )

  # Download .tex template ----

  download.file("https://raw.githubusercontent.com/grousell/tcdsb/master/templates/in-header.tex",
                destfile = glue::glue("in-header.tex")
  )

  # Create images file if needed ----
  if (file.exists("images")){

  } else {
    dir.create("images")
  }

  # Download TCDSB images ----

  download.file("https://github.com/grousell/tcdsb/blob/master/images/r_a_footer.png?raw=true",
                destfile = "images/r_a_footer.png",
                mode = "wb")

  download.file("https://github.com/grousell/tcdsb/blob/master/images/r_a_logo.png?raw=true",
                destfile = "images/r_a_logo.png",
                mode = "wb")

  download.file("https://github.com/grousell/tcdsb/blob/master/images/tcdsb_logo.png?raw=true",
                destfile = "images/tcdsb_logo.png",
                mode = "wb")

  download.file("https://github.com/grousell/tcdsb/blob/master/images/tcdsb_logo_BW.png?raw=true",
                destfile = "images/tcdsb_logo_BW.png",
                mode = "wb")

  download.file("https://github.com/grousell/tcdsb/blob/master/images/title_page_background.png?raw=true",
                destfile = "images/title_page_background.png",
                mode = "wb")
  }

