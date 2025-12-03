#' TCDSB Diverging Plots - Other
#' A function to create plots of other responses (i.e. Missing, Neutral) to pair
#' with TCDSB Diverging Plots
#'
#' @param df Data frame in long format
#' @param group_col Column with groups
#' @param response_col Column with responses
#' @param percent_col Column with percentages
#' @param label Label for chart
#' @param font Font
#' @param bar_color Bar color (defaults to grey)
#' @param label_width Width of labels
#' @param legend_width Width of legend
#' @param x_max Max of x-axis. Can be adjusted for appearance
#' @param font_size Font size scale - base is 1
#' @param bar_width Width of bars
#'
#' @returns A ggplot to be paired with tcdsb_diverge_plot
#' @export
#'
#' @examples
#' # Not run
#' # df |>
#' #   dplyr::filter(response == "Neutral") |>
#' #   tcdsb_diverge_plot_other_function(
#' #     group_col = Question,
#' #     response_col = response,
#' #     percent_col = percent,
#' #     label = "Neutral"
#' #     )

tcdsb_diverge_plot_other_function <- function(df,
                                        group_col,
                                        response_col,
                                        percent_col,
                                        label,
                                        font = "Century Gothic",
                                        bar_color = "grey70",
                                        label_width = 30,
                                        legend_width = 10,
                                        x_max = 1,
                                        font_size = 1,
                                        bar_width =  0.75) {
  # Ensure required columns are of the correct type
  if (!is.character(dplyr::pull(df, {{ group_col }}))) {
    stop("`group_col` must be of type character.")
  }
  if (!is.character(dplyr::pull(df, {{ response_col }}))) {
    stop("`response_col` must be of type character.")
  }
  if (!is.numeric(dplyr::pull(df, {{ percent_col }}))) {
    stop("`percent_col` must be of type numeric.")
  }

  num_groups <- nrow(
    df |> dplyr::select({{ group_col }}) |> dplyr::distinct()
  )

  plot <- df |>
    ggplot2::ggplot() +
    ggplot2::coord_cartesian(clip = "off") +
    ggplot2::geom_col(ggplot2::aes(y = {{ group_col }},
                 x = {{ percent_col }},
                 fill = {{ response_col }}),
             width = bar_width) +
    ggplot2::scale_fill_manual(
      values = {{ bar_color }},
      drop = FALSE,
      labels = function(x) stringr::str_wrap(x, width = legend_width)
    ) +
    ggplot2::scale_y_discrete(labels = function(x) stringr::str_wrap(x, width = label_width)) +
    ggplot2::scale_x_continuous(labels = function(x) scales::percent_format()(abs(x)),
                       limits = c(0, {{ x_max }}),
                       expand = ggplot2::expansion()
    ) +
    ggplot2::geom_text(ggplot2::aes(x = {{ percent_col }},
                  y = {{ group_col }},
                  label = scales::percent({{ percent_col }}, accuracy = 1),
                  hjust = -0.6
    ),
    size = 3 * font_size,
    family = font) +
    # Add TITLE
    ggplot2::annotate("text", x = (x_max / 2), y = num_groups + 0.75,
             label = label,
             size = 4 * font_size,                # Font size (in mm, not pt)
             family = font,
             fontface = 'bold',) +
    ggplot2::labs(x = NULL, y = NULL) +
    ggplot2::theme(
      title = ggplot2::element_text(colour = "black",
                                    size = (14 * font_size)
      ),
      plot.title.position = "plot",
      text = ggplot2::element_text(size = (12 * font_size),
                                   family = font),
      plot.title = ggplot2::element_text(hjust = 0.5),
      plot.subtitle = ggplot2::element_text(hjust = 0.5),
      plot.margin = ggplot2::unit(c(4, 1, 1, 1), "lines"),  # top, right, bottom, left
      panel.background = ggplot2::element_blank(),
      panel.border = ggplot2::element_blank(),
      panel.grid.major.y = ggplot2::element_blank(),
      panel.grid.minor.y = ggplot2::element_line(colour = "NA"),
      panel.grid.major.x = ggplot2::element_blank(),
      panel.grid.minor.x = ggplot2::element_line(colour = "NA"),
      axis.title.x = ggplot2::element_text(colour = "black",
                                           size = (13 * font_size)
      ),
      axis.title.y = ggplot2::element_text(colour = "black",
                                           size = (13 * font_size),
                                           angle = 90),
      axis.text.y = ggplot2::element_blank(),
      axis.text.x = ggplot2::element_blank(),

      axis.ticks.y = ggplot2::element_blank(),
      axis.ticks.x = ggplot2::element_blank(),
      legend.text = ggplot2::element_text(colour = "black",
                                          size = (10 * font_size)),
      legend.position = "none",
      legend.title = ggplot2::element_blank(),
      legend.key = ggplot2::element_blank()
    )
  return(plot)
}

