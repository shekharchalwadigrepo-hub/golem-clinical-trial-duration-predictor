#' Load the cleaned trials data
#' @return A tibble with cleaned clinical trial data
#' @export
load_clean_data <- function() {
  path <- "data/processed/clean_trials.rds"
  
  if (!file.exists(path)) {
    stop("Cleaned data not found. Please run the data cleaning script first.")
  }
  
  readr::read_rds(path)
}

#' Load the best trained model
#' @return A fitted workflow / model object
#' @export
load_best_model <- function() {
  path <- "models/best_duration_model.rds"
  
  if (!file.exists(path)) {
    stop("Model not found. Please run the modeling script first.")
  }
  
  readr::read_rds(path)
}

#' Predict trial duration for new data
#' @param model Fitted model
#' @param new_data A data frame with the required predictors
#' @return A tibble with predictions
#' @export
predict_duration <- function(model, new_data) {
  predict(model, new_data) %>%
    dplyr::rename(predicted_duration = .pred)
}

#' Format duration nicely
#' @param months Numeric vector of months
#' @return Character vector
#' @export
format_duration <- function(months) {
  years <- months / 12
  ifelse(
    years < 1,
    paste0(round(months, 1), " months"),
    paste0(round(years, 1), " years")
  )
}

#' Quick summary of the cleaned dataset
#' @param data Cleaned data frame
#' @export
summarise_trials <- function(data = load_clean_data()) {
  cat("===== Clinical Trial Dataset Summary =====\n")
  cat("Total trials:        ", nrow(data), "\n")
  cat("Date range:          ", 
      as.character(min(data$start_date, na.rm = TRUE)), "to", 
      as.character(max(data$start_date, na.rm = TRUE)), "\n")
  cat("Average duration:    ", round(mean(data$duration_months, na.rm = TRUE), 1), "months\n")
  cat("Median duration:     ", round(median(data$duration_months, na.rm = TRUE), 1), "months\n\n")
  
  cat("Phase distribution:\n")
  print(table(data$phase_clean))
  
  cat("\nSponsor type:\n")
  print(table(data$sponsor_type))
}

#' Create a simple prediction input row
#' @export
make_prediction_input <- function(phase = "Phase 3",
                                  sponsor_type = "Industry",
                                  enrollment = 200,
                                  n_sites = 20,
                                  start_year = 2020) {
  
  tibble::tibble(
    phase_clean    = phase,
    sponsor_type   = sponsor_type,
    log_enrollment = log1p(enrollment),
    n_sites        = n_sites,
    start_year     = start_year
  )
}