
#' TCDSB Colors and Fonts
#'
#' @param ...
#'
#' @return
#' R objects with names and HEX colors for TCDSB visual identity
#' @export
#'
#' @examples
#' # tcdsb_colours_fonts()

tcdsb_colours_fonts <- function(...){

  tcdsb_board_color <<- "#951B1E"
  tcdsb_board_color_20 <<- "#C84E51"
  tcdsb_board_color_40 <<- "#FB8184"

  tcdsb_palette <<- c("#560F11", "#2D0026", "#BA7D6B", "#FFE3A6", "#8EB8C2",
                      "#6BCAD4", "#016567", "#7DA387", "#8ACA88", "#9D976E")
  province_green <<- "#39B54A"

  tcdsbFont <<- "Arial"

  extrafont::loadfonts(device = "win", quiet = TRUE)
}


