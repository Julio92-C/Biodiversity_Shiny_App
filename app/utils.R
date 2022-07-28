
plotContainer <- function(plot, title) {
  tags$section(
    class = "dimension_chart_parent_section",
    tags$div(
      class = "dimension_chart_parent",
      style = "position:relative",
      tags$div(
        class = "dimension_chart_header",
        tags$div(class = "chart-title", title)
      ),
      tags$div(
        class = "dimension_chart_body",
        tags$div(plot),
        header = TRUE,
        status = "primary"
      )
    )
  )
}