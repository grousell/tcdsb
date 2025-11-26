#' TCDSB Diverging Plots
#' A function that creates a diverging bar chart, using 2, 4 or 6 factor levels.
#'
#' @param df Data frame in long format
#' @param group_col Column with groups
#' @param response_col Column with responses
#' @param fct_levels Factor levels
#' @param percent_col Column with percentages
#' @param label_width Width of labels
#' @param font Font
#' @param low_colour Low end colour
#' @param high_colour High end colour
#' @param font_size Font size scale - base is 1
#' @param left_label Left hand label
#' @param right_label Right hand label
#' @param bar_width Width of bars
#'
#' @returns A ggplot object
#' @export
#'
#' @examples
#' # Not run
#' # df |>
#' #   tcdsb_diverge_plot_function(
#' #     group_col = Question,
#' #     response_col = response,
#' #     percent_col = percent,
#' #     fct_levels = c("Strongly Disagree", "Disagree", "Agree", "Strongly Agree"))

tcdsb_diverge_plot_function <- function(df,
                                        group_col,
                                        response_col,
                                        fct_levels,
                                        percent_col = percent,
                                        label_width = 30,
                                        font = "Century Gothic",
                                        low_colour = '#8EB8C2',
                                        high_colour = '#d2a940',
                                        font_size = 1,
                                        left_label = "Left Label",
                                        right_label = "Right Label",
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


  # Number of levels
  # fct_levels <- fct_6
  n_levels <- length(fct_levels)

  if (!n_levels %in% c(2, 4, 6))
    stop("Factor levels must be 2, 4, or 6.")

  # Right Label Factor Level

  if (n_levels == 2) {
    top_fct_level <- fct_levels[2]
  } else if (n_levels == 4) {
    top_fct_level <- fct_levels[4]
  } else{
    top_fct_level <- fct_levels[6]
  }

  # Dynamic color palette
  colour_palette <- switch(
    as.character(n_levels),
    "2" = stats::setNames(c(low_colour, high_colour), fct_levels),
    "4" = stats::setNames(
      c(
        low_colour,
        colorspace::lighten(low_colour, 0.3),
        colorspace::lighten(high_colour, 0.3),
        high_colour
      ),
      fct_levels
    ),
    "6" = stats::setNames(
      c(
        low_colour,
        colorspace::lighten(low_colour, 0.3),
        colorspace::lighten(low_colour, 0.6),
        colorspace::lighten(high_colour, 0.6),
        colorspace::lighten(high_colour, 0.3),
        high_colour
      ),
      fct_levels
    )
  )


  df <- df |>
    dplyr::mutate({{ response_col }} := factor({{ response_col }}, levels = fct_levels)) |>
    dplyr::arrange({{ group_col }}, {{ response_col }})

  # Number of groups for annotation labels

  num_groups <- nrow(df |> dplyr::select({{ group_col }}) |> dplyr::distinct())

  # Compute positions dynamically
  df <- df |>
    dplyr::group_by({{ group_col }}) |>
    dplyr::mutate(
      left_count = n() / 2,
      middle_shift = sum({{ percent_col }}[seq_len(first(left_count))]),
      # scalar left_count
      lagged_percent = dplyr::lag({{ percent_col }}, default = 0),
      left = cumsum(lagged_percent) - middle_shift,
      right = cumsum({{ percent_col }}) - middle_shift,
      middle_point = (left + right) / 2,
      width = right - left
    ) |>
    dplyr::ungroup()

  plot <- df |>
    ggplot2::ggplot() +
    ggplot2::coord_cartesian(clip = "off") +
    ggplot2::geom_tile(ggplot2::aes(
      x = middle_point,
      y = {{ group_col }},
      width = width,
      fill = {{ response_col }}
    ), height = bar_width) +
    ggplot2::scale_y_discrete(
      labels = function(x)
        stringr::str_wrap(x, width = label_width)
    ) +
    ggplot2::scale_x_continuous(
      limits = c(-1.1, 1.1),
      labels = function(x)
        scales::percent_format()(abs(x))
    ) +
    ggplot2::scale_fill_manual(values = colour_palette, drop = FALSE) +
    ggplot2::geom_vline(xintercept = 0,
               color = 'black',
               linewidth = 0.25) +
    # Add all labels
    ggplot2::geom_text(
      ggplot2::aes(
        x = middle_point,
        y = {{ group_col }},
        label = scales::percent({{ percent_col }}, accuracy = 1)
      ),
      size = 3 * font_size,
      family = font
    ) +
    # Add left total labels
    ggplot2::geom_text(
      data = df |> dplyr::filter({{response_col}} == fct_levels[1]),
      ggplot2::aes(
        x = -1.1,
        y = {{ group_col }},
        label = scales::percent(abs(left), accuracy = 1)
      ),
      family = font,
      size = 4 * font_size,
      fontface = 'bold',
      inherit.aes = FALSE  # Important so it uses only the aesthetics you specify here
    ) +
    # Add left total TITLE
    ggplot2::annotate(
      "text",
      x = -1,
      y = num_groups + 0.75,
      label = left_label,
      size = 4 * font_size,
      # Font size (in mm, not pt)
      family = font,
      fontface = 'bold',
    ) +
    # Add right total labels
    ggplot2::geom_text(
      data = df |> dplyr::filter({{response_col}} == top_fct_level),
      ggplot2::aes(
        x = 1.1,
        y = {{ group_col }},
        label = scales::percent(abs(right), accuracy = 1)
      ),
      family = font,
      size = 4 * font_size,
      fontface = 'bold',
      inherit.aes = FALSE  # Important so it uses only the aesthetics you specify here
    ) +
    # Add right total TITLE
    ggplot2::annotate(
      "text",
      x = 1,
      y = num_groups + 0.75,
      label = right_label,
      size = 4 * font_size,
      # Font size (in mm, not pt)
      family = font,
      fontface = 'bold',
    ) +
    ggplot2::labs(x = NULL, y = NULL) +
    ggplot2::theme(
      title = ggplot2::element_text(colour = "black", size = (14 * font_size)),
      plot.title.position = "plot",
      text = ggplot2::element_text(size = (12 * font_size), family = font),
      plot.title = ggplot2::element_text(hjust = 0.5),
      plot.subtitle = ggplot2::element_text(hjust = 0.5),
      plot.margin = ggplot2::unit(c(4, 1, 1, 1), "lines"),
      # top, right, bottom, left
      panel.background = ggplot2::element_blank(),
      panel.border = ggplot2::element_blank(),
      panel.grid.major.y = ggplot2::element_blank(),
      panel.grid.minor.y = ggplot2::element_line(colour = "NA"),
      panel.grid.major.x = ggplot2::element_line(colour = "grey90"),
      panel.grid.minor.x = ggplot2::element_line(colour = "NA"),
      axis.title.x = ggplot2::element_text(colour = "black", size = (13 * font_size)),
      axis.title.y = ggplot2::element_text(
        colour = "black",
        size = (13 * font_size),
        angle = 90
      ),
      axis.text.x = ggplot2::element_blank(),
      axis.text.y = ggplot2::element_text(
        colour = "black",
        size = (11 * font_size),
        hjust = 1
      ),
      axis.ticks.y = ggplot2::element_blank(),
      axis.ticks.x = ggplot2::element_blank(),
      legend.text = ggplot2::element_text(colour = "black", size = (10 * font_size)),
      legend.position = ("bottom"),
      legend.title = ggplot2::element_blank(),
      legend.key = ggplot2::element_blank()
    )

  return(plot)
}
