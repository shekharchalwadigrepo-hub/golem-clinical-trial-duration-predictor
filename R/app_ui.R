#' The application User-Interface
#' @param request Internal parameter for `{shiny}`.
#' @import shiny
#' @import bslib
#' @noRd
app_ui <- function(request) {
  tagList(
    golem_add_external_resources(),
    page_navbar(
      title = "Clinical Trial Duration Predictor",
      theme = bs_theme(bootswatch = "flatly", primary = "#2C3E50"),
      
      nav_panel(
        title = "Predict",
        mod_predict_ui("predict_1")
      ),
      
      nav_panel(
        title = "Data Overview",
        mod_overview_ui("overview_1")
      ),
      
      nav_panel(
        title = "About",
        mod_about_ui("about_1")
      )
    )
  )
}

#' Add external Resources to the Application
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )
  
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "Clinical Trial Duration Predictor"
    )
  )
}