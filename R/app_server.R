#' The application server-side
#' @param input, output, session Internal parameters for `{shiny}`.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  
  # Load data and model once
  model      <- load_best_model()
  clean_data <- load_clean_data()
  
  # Call modules
  mod_predict_server("predict_1", model = model, clean_data = clean_data)
  mod_overview_server("overview_1", clean_data = clean_data)
  mod_about_server("about_1")
}