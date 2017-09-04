rm(list=ls())

library(qmradoparr)
library(doParallel)
cl <-makeCluster(3)
registerDoParallel(cl)


total.dose.params <- list("pathogen.viable.variability.switch"=TRUE,
                          "run.oyster.model"=TRUE)

beta.poisson.params <- list(probability.infection.alpha=0.349,
                            probability.infection.beta=357.1)

parallel.calcs.params <- list(number.simulations=5,
                              population.size=1000,
                              number.days=365,
                              proportion.secretor.positive=0.75,
                              opts1=list(chunkSize=5),
                              opts2=list(chunkSize=20),
                              output.name="packtrial1")

do.call(total.dose, total.dose.params)

(replicate(500, do.call(total.dose, total.dose.params)))

stuff <- replicate(500, do.call(prob.infection.beta.poisson,
                                c(list(total.dose.params = total.dose.params),
                                  beta.poisson.params)))
(sum(stuff))

do.call(parallel.calcs, c(list(total.dose.params = total.dose.params,
                               beta.poisson.params = beta.poisson.params),
                          parallel.calcs.params))

