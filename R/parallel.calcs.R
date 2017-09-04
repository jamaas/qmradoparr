#' Final calculations, run in parallel using "foreach".
#'
#' Final calculations, run in parallel using "foreach".
#' @param number.simulations number of total simulations to run
#' @param population.size size of population in each simulation
#' @param number.days number of days to run for each individual
#' @param proportion.secretor.positive proportion of people NoV Sec Pos
#' @param opts1 options for outer loop to speed up run speed
#' @param opts2 options for inner loop to speed up run speed
#' @export parallel.calcs

parallel.calcs <- function (total.dose.params,
                            beta.poisson.params,
                            number.simulations,
                            population.size,
                            number.days,
                            proportion.secretor.positive,
                            opts1,
                            opts2,
                            output.name,
                            ...) {

    results <- data.frame ( foreach::`%dopar%`(
        foreach::`%:%`(foreach::foreach(j = 1:number.simulations, .combine = acomb,
                                        .options.mpi=opts1),
                       foreach::foreach (i = 1:population.size, .combine=rbind,
                                         .options.mpi=opts2)),
        {
            output <- if(rbinom(1,1,proportion.secretor.positive) > 0)
                replicate(number.days,
                          do.call(prob.infection.beta.poisson,
                                  c(list(total.dose.params = total.dose.params),
                                    beta.poisson.params)))
            else rep(0, number.days)

            output2 <- data.frame(khf(output))
        }
    )
    )
    ## save outputs for subsequent analyses if required
    saveRDS(results, file = paste("./outputs/", output.name ,"_",
                                  population.size, "_", number.simulations, "_", format(Sys.time(), "%d_%m_%Y"),
                                  ".rds", sep=""))
}

