#' TCDSB gt tables
#'
#' @param df A cleaned table for report
#' @param table_font Font
#' @param fontsize Font size scale - base is 1
#' @param title Title of table
#' @param subtitle Subtitle of table
#'
#' @returns a gt object
#' @export
#'
#' @examples
#' # df |>
#' #  tcdsb_gt_table(title = "Table for Report", font_size = 0.8)

tcdsb_gt_table <- function(df, table_font = "Century Gothic", fontsize = 1, title = "Title", subtitle = NA) {
  df |>
    gt::gt() |>
    # Title of table
    gt::tab_header(title = {{ title }}, subtitle = {{ subtitle }}) |>
    # Style for Title
    gt::tab_style(style = list(gt::cell_text(size = gt::px(20 * fontsize), font = table_font)), locations = list((gt::cells_title()))) |>
    # Style for body
    gt::tab_style(style = list(gt::cell_text(size = gt::px(12 * fontsize), font = table_font)),
                  locations = list(gt::cells_body())) |>
    # Style for Column Labels
    gt::tab_style(style = list(
      gt::cell_fill(color = "#951B1E"),
      gt::cell_text(
        color = "white",
        weight = "bold",
        size = gt::px(14 * fontsize),
        font = table_font
      )
    ),
    locations = gt::cells_column_labels(dplyr::everything())) |>
    # Style for Row Groups
    gt::tab_style(
      style = list(
        gt::cell_fill(color = "lightgrey"),
        gt::cell_text(
          weight = "bold",
          size = gt::px(13 * fontsize),
          font = table_font
        )
      ),
      locations = gt::cells_row_groups(groups = dplyr::everything())
    ) |>
    # Adds striping to cells, for Typst and PDF
    gt::tab_style(style = gt::cell_fill(color = "grey95"),
                  locations = gt::cells_body(rows = seq(2, nrow({{ df }}), 2)))
}
