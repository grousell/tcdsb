#let tcdsb_colors = (
  grey: rgb("#404041"),
  board_maroon: rgb("#951B1E"),
  dark_maroon: rgb("#2D0026"),
  med_maroon: rgb("#BA7D6B"),
  aqua: rgb("#016567"),
  light_blue_1: rgb("#6BCAD4"),
  light_blue_2: rgb("#8EB8C2")
)


//   Custom title page
#let title_page(title, subtitle, dept, date, author)={
    page(margin: 0in,
        background: image("assets/title_page_background.png", height: 35%, fit: "cover"))[

        #place(right, dy: 60pt, dx: -60pt)[ // TCDSB Logo
          #box(height: 150pt, image("assets/tcdsb_logo_BW.png", height: 95%))
          ]

        #place(left + horizon, dy: -2.5in, dx: 1.25in)[ // Title of report
            #text(weight: "light", size: 36pt, fill: tcdsb_colors.board_maroon, title)
            ]

        #place(left + horizon, dy: -1.75in, dx: 1.25in)[ // Subtitle of report
            #text(weight: "light", size: 28pt, fill: tcdsb_colors.board_maroon, subtitle)
            ]

        #place(left + horizon, dy: -1in, dx: 1.25in)[ // Type of report (Research or Analytics)
            #text(weight: "light", size: 28pt, fill: tcdsb_colors.board_maroon, dept)
            ]

        #place(left + horizon, dy: 1in, dx: 1.25in)[ // Date of report
            #text(weight: "light", size: 28pt, fill: tcdsb_colors.board_maroon, date)
            ]

        #place(left + horizon, dy: 1.75in, dx: 1.25in)[ // Date of report
            #text(weight: "light", size: 20pt, fill: tcdsb_colors.light_blue_2, author)
            ]


        #place(center + bottom, dy: -36pt)[
          #block(height: 150pt)[
            #box(inset: (x: 12pt), line(length: 100%, angle: 90deg, stroke: 0.5pt + white))
            #box(image("assets/R_A_logo.png"))
          ]
        ]
    ]
}

#let tcdsb(
  title: none,
  subtitle: none,
  dept: none,
  author: none,
  date: none,
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: (),
  fontsize: 11pt,
  doc,
) = {

  set page(
    paper: paper,
    margin: margin,
    numbering: none,

  )

  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize,
           fill: tcdsb_colors.grey)


  set par(
    leading: 0.8em
  )

  set table(
    align: left,
    inset: 7pt,
    stroke: (x: none, y: 0.5pt)
  )

  if title != none {
    title_page(title, subtitle, dept, date, author)
  }

  show heading.where(level: 1): set text(weight: "light", size: 24pt)
  show heading.where(level: 1): set block(width: 100%, below: 1em)

  show heading.where(level: 2): it => {
    set block(below: 1.5em)
    upper(it)
  }

  show link: underline
  show link: set underline(stroke: 1pt, offset: 2pt)
  show link: set text(fill: tcdsb_colors.light_blue_1)

  block(above: 0em, below: 2em)[
    #outline(
      indent: 1.5em
    );
  ]

  counter(page).update(0)
  set page(numbering: "1")

  // Start document
  doc

}

