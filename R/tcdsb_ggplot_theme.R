#' TCDSB ggplot Theme
#'
#' @param text_scale
#' Numeric value to scale font sizes in plot. Default = 1.
#'
#' @return A ggplot theme
#' @export
#'
#' @examples
#' # df |>
#' #   ggplot(aes (x = x, y = y)) +
#' #   geom_bar() +
#' #   tcdsb_ggplot_theme()

tcdsb_ggplot_theme <- function(text_scale = 1) {

  chart_font <- "sans"

  ggplot2::theme(
    title = ggplot2::element_text(colour = "black", size = (14 * text_scale)),
    plot.title.position = "plot",
    text = ggplot2::element_text(size = (12 * text_scale),  family = chart_font),
    plot.title = ggplot2::element_text(hjust = 0.5),
    plot.subtitle = ggplot2::element_text(hjust = 0.5),
    plot.margin = ggplot2::unit(c(0.25, 0.25, 0.25, 0.25), "cm"),

    panel.background = ggplot2::element_blank(),

    panel.border = ggplot2::element_blank(),
    panel.grid.major.y = ggplot2::element_line(colour = "grey90"),
    panel.grid.minor.y = ggplot2::element_line(colour = "NA"),
    panel.grid.major.x = ggplot2::element_line(colour = "NA"),
    panel.grid.minor.x = ggplot2::element_line(colour = "NA"),

    axis.title.x = ggplot2::element_text(
      colour = "black", size = (13 * text_scale)
    ),
    axis.title.y = ggplot2::element_text(
      colour = "black",
      size = (13 * text_scale),
      angle = 90
    ),
    axis.text.x = ggplot2::element_text(
      colour = "black",
      size = (11 * text_scale),
      angle = 0
    ),
    axis.text.y = ggplot2::element_text(
      colour = "black",
      size = (11 * text_scale),
      hjust = 1
    ),

    axis.ticks.y = ggplot2::element_blank(),
    axis.ticks.x = ggplot2::element_blank(),

    legend.text = ggplot2::element_text(
      colour = "black",
      size = (10 * text_scale)),
    legend.position = ("bottom"),
    legend.title = ggplot2::element_blank(),
    legend.key = ggplot2::element_blank(),

    strip.background = ggplot2::element_rect(fill = "white", color = NA)
  )
  }

