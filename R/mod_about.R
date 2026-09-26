#' about UI Function
#' @param id Module id
#' @import shiny
#' @import bslib
#' @noRd
mod_about_ui <- function(id) {
  ns <- NS(id)
  
  card(
    card_body(
      h3("About this Project"),
      
      h4("What is this prediction used for?"),
      p("This tool predicts how long a clinical trial is likely to take from start to completion. 
         Knowing the expected duration helps in better planning of time, budget, and resources."),
      
      h4("Who can use this prediction and what do they need to enter?"),
      
      tags$table(
        class = "table table-bordered table-striped",
        tags$thead(
          tags$tr(
            tags$th("User Group"),
            tags$th("What they need to enter"),
            tags$th("How they benefit")
          )
        ),
        tags$tbody(
          tags$tr(
            tags$td(strong("Clinical Trial Managers")),
            tags$td("Phase, Enrollment, Number of Sites, Sponsor Type, Start Year"),
            tags$td("Plan more realistic study timelines")
          ),
          tags$tr(
            tags$td(strong("Pharmaceutical & Biotech Companies")),
            tags$td("Phase, Enrollment, Number of Sites, Sponsor Type, Start Year"),
            tags$td("Estimate project timelines and allocate budget better")
          ),
          tags$tr(
            tags$td(strong("CROs")),
            tags$td("Phase, Enrollment, Number of Sites, Sponsor Type, Start Year"),
            tags$td("Give better and more realistic time estimates to clients")
          ),
          tags$tr(
            tags$td(strong("Biostatisticians & Data Scientists")),
            tags$td("Phase, Enrollment, Number of Sites, Sponsor Type, Start Year"),
            tags$td("Understand which factors influence trial duration")
          ),
          tags$tr(
            tags$td(strong("Students & Researchers")),
            tags$td("Any combination of the above inputs"),
            tags$td("Learn how real clinical trial data is used in data science")
          )
        )
      ),
      
      h4("Conclusion"),
      p("This Shiny app shows how publicly available clinical trial data can be turned into a useful prediction tool. 
         By using historical data from ClinicalTrials.gov, the model provides a simple estimate of how long a new trial might take. 
         While the prediction is not perfect, it gives a helpful starting point for planning and decision-making in clinical research."),
      
      hr(),
      p(em("Built as a portfolio project combining Clinical Trials domain knowledge, R Shiny, and Data Science."))
    )
  )
}

#' about Server Function
#' @param id Module id
#' @noRd
mod_about_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    # No server logic needed
  })
}