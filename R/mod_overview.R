#' overview UI Function
#' @param id Module id
#' @import shiny
#' @import bslib
#' @noRd
mod_overview_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    layout_columns(
      col_widths = c(6, 6),
      card(
        card_header("Duration Distribution"),
        plotOutput(ns("hist_duration"))
      ),
      card(
        card_header("Duration by Phase"),
        plotOutput(ns("boxplot_phase"))
      )
    ),
    card(
      card_header("Summary Statistics"),
      verbatimTextOutput(ns("summary_text"))
    )
  )
}

#' overview Server Function
#' @param id Module id
#' @param clean_data Cleaned dataset
#' @import shiny
#' @import ggplot2
#' @noRd
mod_overview_server <- function(id, clean_data) {
  moduleServer(id, function(input, output, session) {
    
    output$hist_duration <- renderPlot({
      ggplot(clean_data, aes(x = duration_months)) +
        geom_histogram(bins = 40, fill = "#3498DB", alpha = 0.8, color = "white") +
        labs(x = "Duration (months)", y = "Count") +
        theme_minimal(base_size = 13)
    })
    
    output$boxplot_phase <- renderPlot({
      ggplot(clean_data, aes(x = phase_clean, y = duration_months, fill = phase_clean)) +
        geom_boxplot(alpha = 0.8) +
        labs(x = NULL, y = "Duration (months)") +
        theme_minimal(base_size = 13) +
        theme(legend.position = "none")
    })
    
    output$summary_text <- renderPrint({
      summarise_trials(clean_data)
    })
  })
}