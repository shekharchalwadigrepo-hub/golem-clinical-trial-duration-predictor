# Launch the Shiny app
pkgload::load_all(export_all = FALSE, helpers = FALSE, attach_testthat = FALSE)
options("golem.app.prod" = TRUE)
clinicalTrialDuration::run_app()