### OK, I think we have cracked this nut for a good solving techinique for equations

## TO DO:
# Terminate loop if approaching NAN (stop doing work)

# So we can have a section on randomness to redefine as the try code (way to introduce stochasticity in the parameters)
# Euler equation for solving
euler <- function(rate_eq,init_cond,parameters=NULL,t_start=0,deltaT=1,n_steps=1) {

  # Add time to our condition vector, identify the names
  curr_vec <- c(init_cond,t=t_start)

  vec_names <- names(curr_vec)

  time_eq <- c(dt ~ 1)  # This is an equation to keep track of the dt
  new_rate_eq <- c(rate_eq,time_eq) %>%
    formula.tools::rhs()


    # Start building the list
    out_list <- vector("list",length=n_steps)
    out_list[[1]] <- curr_vec

    for(i in 2:n_steps) {

      # Define the list of inputs to the rate equation
      in_list <- c(parameters,curr_vec) %>% as.list()

      curr_rate <-sapply(new_rate_eq,FUN=eval,envir=in_list) %>%
        set_names(nm =vec_names)

     # Now we add them together and update
      v3 <- c(curr_vec, curr_rate*deltaT)
      curr_vec <-  tapply(v3, names(v3), sum)

      out_list[[i]] <- curr_vec

    }

    # Accumulate as we go and build up the data frame. This seems like magic.
    out_results <- out_list %>%
      bind_rows() %>%
      relocate(t)  # Put t at the start



    return(out_results)



}

# Stochastic equation  -> maybe this should be internal
euler_stochastic <- function(rate_eq,stochastic_rate,init_cond,parameters=NULL,t_start=0,deltaT=1,n_steps=1,sigma=1) {

  # Add time to our condition vector, identify the names
  curr_vec <- c(init_cond,t=t_start)

  vec_names <- names(curr_vec)
  n_vars <- length(vec_names)  # Number of variables

  time_eq <- c(dt ~ 1)  # This is an equation to keep track of the dt
  new_rate_eq <- c(rate_eq,time_eq) %>%
    formula.tools::rhs()

  time_eq_stoc <- c(dt~0)
  new_stochastic_rate <- c(rate_eq,time_eq_stoc) %>%
    formula.tools::rhs()


  # Start building the list
  out_list <- vector("list",length=n_steps)
  out_list[[1]] <- curr_vec

  for(i in 2:n_steps) {

    # Define the list of inputs to the rate equation
    in_list <- c(parameters,curr_vec) %>% as.list()

    curr_rate <-sapply(new_rate_eq,FUN=eval,envir=in_list) %>%
      set_names(nm =vec_names)

    curr_stoch_rate <-sapply(new_stochastic_rate,FUN=eval,envir=in_list) %>%
      set_names(nm =vec_names)

    # Now we add them together and update
    v3 <- c(curr_vec, curr_rate*deltaT,curr_stoch_rate*sigma*sqrt(deltaT)*rnorm(n_vars))
    curr_vec <-  tapply(v3, names(v3), sum)

    out_list[[i]] <- curr_vec

  }



  # Accumulate as we go and build up the data frame. This seems like magic.
  out_results <- out_list %>%
    bind_rows() %>%
    relocate(t)  # Put t at the start



  return(out_results)



}




# Example for stochastic eq
logistic_eq <- c(dx~r*x*(1-x/K))
stochastic_logistic <- c(dx~1)
params <- c(r=.8,K=100)
start_time <- Sys.time()
yoop <- euler(logistic_eq,c(x=3),params,deltaT=.05,n_steps=200)
Sys.time()-start_time


n_sims <- 500
start_time <- Sys.time()
try1 <- rerun(n_sims, c(x=runif(1,min=0,max=5))) %>%
  set_names(paste0("sim", 1:n_sims)) %>%
  map(~ euler(logistic_eq,.x,params,deltaT=.05,n_steps=200)) %>%
  map_dfr(~ .x, .id = "simulation")
Sys.time()-start_time


try1 %>%
  ggplot(aes(x = t, y = x)) +
  geom_line(aes(color = simulation)) +
  ggtitle("Random initial conditions") +
  guides(color=FALSE)

# Now let's do a 2d equation
my_rate <- c(dx~-0.1*x+sin(t)*y,dy~a*x-sin(t)*y)
param2 <- c(a=3)
init_cond <- c(x=4,y=3)

# So far so good - yay!
yoop <- euler(my_rate,init_cond,param2,deltaT=.1,n_steps=30)


n_sims <- 500
start_time <- Sys.time()
try2 <- rerun(n_sims, c(a=runif(1,min=0,max=5))) %>%
  set_names(paste0("sim", 1:n_sims)) %>%
  map(~ euler(my_rate,init_cond,.x,deltaT=.1,n_steps=30)) %>%
  map_dfr(~ .x, .id = "simulation")
Sys.time()-start_time


try2 %>%
  ggplot(aes(x = x, y = y)) +
  geom_line(aes(color = simulation)) +
  ggtitle("Random initial conditions") +
  guides(color=FALSE)

# This could be something they could do - plotting randomness and ensemble averages.
# They would need to learn pivoting and the geom_ribbon, but it wouldn't be horrible, no?
# Have them do the ensemble average one at a time ...

yeep <- try2 %>%
  ensemble_average(t,c("x","y"))

try2 %>%
  ensemble_average(t,x) %>%
  pivot_wider(names_from="quantile",values_from="x") %>%
  ggplot(aes(x=t)) +
  geom_ribbon(aes(ymin=q0.025,ymax=q0.975),alpha=0.2) +
  geom_line(aes(y=q0.5))

# HW problems: have them work in some data, make a geom plot in one variable or the other.
# I think this is worth it, especially if we are having them do the ggplot earlier.


# Code to compute the ensemble average
ensemble_average <- function(data, group_var, summarise_var) {
  data %>%
    group_by(across({{ group_var }})) %>%
    summarise(across({{ summarise_var }}, ~quantile(.x,probs=c(0.025, 0.5, 0.975))),
              quantile=c("q0.025","q0.5","q0.975"))
}

#### STOCHASTICS
# YAY  Let's plot these out ...
yoop <- euler_stochastic(logistic_eq,stochastic_logistic,c(x=3),params,deltaT=.05,n_steps=200)

n_sims <- 50
start_time <- Sys.time()
try3 <- rerun(n_sims) %>%
  set_names(paste0("sim", 1:n_sims)) %>%
  map(~ euler_stochastic(logistic_eq,stochastic_logistic,c(x=3),params,deltaT=.05,n_steps=200,sigma=0.1)) %>%
  map_dfr(~ .x, .id = "simulation")
Sys.time()-start_time

try3 %>%
  ggplot(aes(x=t,y=x)) +
  geom_line(aes(color = simulation)) +
  ggtitle("Stochastics") +
  guides(color=FALSE)



try3 %>%
  ensemble_average(t,x) %>%
  pivot_wider(names_from="quantile",values_from="x") %>%
  ggplot(aes(x=t)) +
  geom_ribbon(aes(ymin=q0.025,ymax=q0.975),alpha=0.2) +
  geom_line(aes(y=q0.5))


