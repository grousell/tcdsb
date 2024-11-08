# Set up ------------------------------------------------------------------

title <- "My New Title"
subtitle <- "My New Subtitle"
date <- as.character(Sys.Date())
author <- "Person who Authored the Report"
author2 <- "Second Author"

# Set up Title Page -------------------------------------------------------

officer::read_docx("assets/tcdsb_word_cover_page_template.docx") |>
  officer::body_replace_all_text(
    old_value = "TITLE",
    new_value = title
  ) |>
  officer::body_replace_all_text(
    old_value = "SUB",
    new_value = subtitle,
  ) |>
  officer::body_replace_all_text(
    old_value = "DATE",
    new_value = date
  ) |>
  officer::body_replace_all_text(
    old_value = "AUTHOR",
    new_value = author
  ) |>
  officer::body_replace_all_text(
    old_value = "AUTH2",
    new_value = author2
  ) |>
  print(target = "assets/title_page.docx")

