#' predict UI Function
#' @param id Module id
#' @import shiny
#' @import bslib
#' @noRd
mod_predict_ui <- function(id) {
  ns <- NS(id)
  
  layout_sidebar(
    sidebar = sidebar(
      title = "Trial Characteristics",
      width = 320,
      
      selectInput(
        ns("phase"), "Phase",
        choices = NULL
      ),
      
      selectInput(
        ns("sponsor"), "Sponsor Type",
        choices = c("Industry", "Other"),
        selected = "Industry"
      ),
      
      numericInput(
        ns("enrollment"), "Number of Participants",
        value = 200, min = 10, max = 10000, step = 10
      ),
      
      numericInput(
        ns("n_sites"), "Number of Sites",
        value = 25, min = 1, max = 500, step = 1
      ),
      
      numericInput(
        ns("start_year"), "Start Year",
        value = 2020, min = 2005, max = 2025, step = 1
      ),
      
      actionButton(ns("predict_btn"), "Predict Duration", class = "btn-primary w-100")
    ),
    
    card(
      card_header("Prediction Result"),
      card_body(
        uiOutput(ns("prediction_result")),
        br(),
        plotOutput(ns("duration_distribution"), height = "350px")
      )
    )
  )
}

#' predict Server Function
#' @param id Module id
#' @param model Trained model
#' @param clean_data Cleaned dataset
#' @import shiny
#' @import ggplot2
#' @noRd
mod_predict_server <- function(id, model, clean_data) {
  moduleServer(id, function(input, output, session) {
    
    # Update phase choices from actual data
    observe({
      phases <- sort(unique(clean_data$phase_clean))
      updateSelectInput(session, "phase", choices = phases, selected = phases[1])
    })
    
    prediction <- eventReactive(input$predict_btn, {
      new_data <- make_prediction_input(
        phase = input$phase,
        sponsor_type = input$sponsor,
        enrollment = input$enrollment,
        n_sites = input$n_sites,
        start_year = input$start_year
      )
      
      pred <- predict_duration(model, new_data)
      pred$predicted_duration
    })
    
    output$prediction_result <- renderUI({
      req(prediction())
      
      months <- prediction()
      years  <- months / 12
      
      div(
        style = "text-align: center; padding: 20px;",
        h2(style = "color: #18BC9C; font-weight: 700;",
           paste0(round(months, 1), " months")),
        h4(paste0("≈ ", round(years, 1), " years")),
        p(class = "text-muted", "Predicted duration based on the selected trial characteristics")
      )
    })
    
    output$duration_distribution <- renderPlot({
      req(prediction())
      
      ggplot(clean_data, aes(x = duration_months)) +
        geom_histogram(bins = 40, fill = "#3498DB", alpha = 0.7, color = "white") +
        geom_vline(xintercept = prediction(), color = "#E74C3C",
                   linewidth = 1.3, linetype = "dashed") +
        annotate("text", x = prediction(), y = Inf,
                 label = " Prediction", vjust = 2, hjust = -0.1, color = "#E74C3C") +
        labs(
          title = "Where does this prediction sit in the historical distribution?",
          x = "Trial Duration (months)",
          y = "Number of Trials"
        ) +
        theme_minimal(base_size = 14)
    })
  })
}