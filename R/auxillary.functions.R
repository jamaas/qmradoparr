#' Combines 2d arrays into 3-d arraysMeal size of food in g
#'
#' This combines the results from each individual simulation "outer loop" into 3-d array.
#' @export acomb

acomb <- function(...) abind::abind(..., along=3)

#' Annualizes the values of risk to one number for entire year, when
#' individual daily values are available
#' @export khf

khf <- function (x) 1-prod(1-x)

#' Probability of getting an infection from pathogen dose, beta-poisson D:R model
#'
#' The probability of getting an infection from the pathogen, given the daily dose, using
#' the beta.poisson model.
#' @param probability.infection.beta beta parameter for beta.poisson model
#' @param probability.infection.alpha alpha parameter for beta.poisson model
#' @export prob.infection.beta.poisson

prob.infection.beta.poisson <- function (probability.infection.beta,
                       probability.infection.alpha, ...) {
    ## Calculate the total dose from all four food groups
    Dose <- do.call(total.dose, total.dose.params)

    ## Calculate the probability of pathogen infection, given the total dose
    ## consumed, and the approximate beta-poisson distribution
    probability.infection <- 1-((1 + Dose / probability.infection.beta)
        ^-probability.infection.alpha)
}
