# Define the rate equation:
infection_eq <- c(dsdt ~ 1/(1-s) )

# Define the initial condition (as a named vector):
infection_init <- c(s = 1.5)

# Define deltaT and the time steps:
deltaT <- 0.1
n_steps <- 10

# Compute the solution via Euler's method:
out_solution <- euler(system_eq = infection_eq,
                      initial_condition = infection_init,
                      deltaT = deltaT, 
                      n_steps = n_steps
)

out_solution %>%
  ggplot(aes(x=t,y=s)) + geom_line()

# Define deltaT and the time steps:
deltaT <- 0.01
n_steps <- 100

# Compute the solution via Euler's method:
out_solution <- euler(system_eq = infection_eq,
                      initial_condition = infection_init,
                      deltaT = deltaT, 
                      n_steps = n_steps
)

out_solution %>%
  ggplot(aes(x=t,y=s)) + geom_line()


# Define deltaT and the time steps:
deltaT <- 0.1
n_steps <- 10

# Compute the solution via Euler's method:
out_solution <- rk4(system_eq = infection_eq,
                      initial_condition = infection_init,
                      deltaT = deltaT, 
                      n_steps = n_steps
)

out_solution %>%
  ggplot(aes(x=t,y=s)) + geom_line()

# Define deltaT and the time steps:
deltaT <- 0.01
n_steps <- 100

# Compute the solution via Euler's method:
out_solution <- rk4(system_eq = infection_eq,
                      initial_condition = infection_init,
                      deltaT = deltaT, 
                      n_steps = n_steps
)

out_solution %>%
  ggplot(aes(x=t,y=s)) + geom_line()
