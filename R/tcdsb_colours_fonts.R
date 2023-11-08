
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
  tcdsbGreen <<- "#8dc63f"
  tcdsbGreen2 <<- "#afd778"
  tcdsbGreen3 <<- "#d1e8b2"

  tcdsbBlue <<- "#0089cf"
  tcdsbBlue2 <<- "#4cacdd"
  tcdsbBlue3 <<- "#99cfeb"

  tcdsbOrange <<- "#faa61a"
  tcdsbOrange2 <<- "#fbc05e"
  tcdsbOrange3 <<- "#fddba3"

  tcdsbFont <<- "Arial"

  extrafont::loadfonts(device = "win", quiet = TRUE)
}


