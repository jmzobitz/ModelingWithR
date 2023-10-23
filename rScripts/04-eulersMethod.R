# Define the rate equation:
system_eq <- c(didt ~ .003 * i * (4000-i))

# Define the initial condition (as a named vector)
init_cond <- c(i=10)

# Define deltaT and the time steps:
deltaT = 0.2
n_steps <- 10

# Compute the solution via Euler's method:
out_solution <- euler(system_eq,initial_condition=init_cond,deltaT=deltaT,n_steps = n_steps) %>% mutate(method = 'euler')

out_solution_rk4 <- rk4(system_eq,initial_condition=init_cond,deltaT=deltaT,n_steps = n_steps) %>%
  mutate(method = 'myrk4')

# Let's do a runge kutta solver by comparing things
dynamics <- function(t, state, parameters){
  with(as.list(c(state, parameters)), {  # Do not edit this line
    dI = .003 * i * (4000-i)  # <-- You may edit this line
    return(list(c(dI)))  # <-- If you have more equations you will need to list the dVariables
  })
}

out <- deSolve::ode(y = init_cond, times = seq(from=0,by=deltaT,length.out=n_steps), func = dynamics, parms = parameters,method="rk4") %>% as_tibble() %>%
  rename(t=time)


out_solver <- out_solution %>%
  select(t) %>%
  mutate(i=as.numeric(out$i),
         method='odeSolver')
# YES!  Things compare - woot woot!



rbind(out_solver,out_solution,out_solution_rk4) %>% 
ggplot() +
  geom_line(aes(x=t,y=i,color=method)) +
  geom_point(aes(x=t,y=i,color=method)) +
labs(x='Time',
     y='Infected')


### Step size work:

# deltaT = (b-a)/N.  2/(.2)^4 is an approximation of N.  This means we will need to do 20000 steps for Euler's method!  Let's try this out:
out_solution_rev <- euler(system_eq,initial_condition=init_cond,deltaT=deltaT^4,n_steps = 1250) 

ggplot(data = out_solution_rev) +
  geom_line(aes(x=t,y=i),color='red') +
  labs(x='Time',
       y='Infected')




### Systems equation

# Define the rate equation:
system_eq <- c(dHdt ~ r*H-b*H*L,
               dLdt ~ e*b*H*L-d*L)


# Define the parameters (as a named vector)
lynx_hare_params <- c(r = 2, b = 0.5, e = 0.1, d = 1)   # parameters: a named vector

# Define the initial condition (as a named vector)
init_cond <- c(H=1, L=3)


# Define deltaT and the time steps:
deltaT <- 0.05    # timestep length
timeSteps <- 200   # must be a number greater than 1

# Compute the solution via Euler's method:
out_solution <- euler(system_eq,
                      parameters = lynx_hare_params,
                      initial_condition=init_cond,
                      deltaT=deltaT,
                      n_steps = n_steps)



out_solution_rk4 <- rk4(system_eq,
                      parameters = lynx_hare_params,
                      initial_condition=init_cond,
                      deltaT=deltaT,
                      n_steps = n_steps)

ggplot(data = out_solution_rk4) +
  geom_line(aes(x=t,y=H),color='red') +
  geom_line(aes(x=t,y=L),color='blue') +
labs(x='Time',
     y='Lynx (red) or Hares (blue)')


### Bad Euler
system_eq <- c(dSdt ~ -k*S*I,
               dIdt ~ k*S*I-beta*I)


deltaT <- .1    # timestep length
timeSteps <- 15   # must be a number greater than 1

quarantine_parameters <- c(k=.05, beta=.2)   # parameters: a named vector

init_cond <- c(S=300, I=1)  # Be sure you have enough conditions as you do variables.

# Compute the solution via Euler's method:
out_solution_rk4 <- rk4(system_eq,
                      parameters = quarantine_parameters,
                      initial_condition=init_cond,
                      deltaT=deltaT,
                      n_steps = n_steps)


ggplot(data = out_solution_rk4) +
  geom_line(aes(x=t,y=S),color='red') +
  geom_line(aes(x=t,y=I),color='blue') +
  labs(x='Time',
       y='Susceptible (red) or Infected (blue)')




