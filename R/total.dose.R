#' Total Dose
#'
#' Calculate the total pathogen dose, sum of the four food groups consumed.
#' @param pathogen.viable.variability.switch Boolean variable to varible viability
#' on or off.
#' @param run.oyster.model Boolean variable to turn oyster model on or off
#' @export total.dose

total.dose <- function (run.oyster.model, pathogen.viable.variability.switch, ...) {
    total.oyster.dose <- `if`(run.oyster.model, rnorm(1, mean=0.45, sd=0.1), 0)
}


