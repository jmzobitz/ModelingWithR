library(tidyverse)
library(demodelr)
# Identify the deterministic and stochastic parts of the DE:
deterministic_logistic_r <- c(dx ~ r*x*(1-x/K))
stochastic_logistic_r <-  c(dx ~ x*(1-x/K))

# Identify the initial condition and any parameters
init_logistic <- c(x=3)
logistic_parameters <- c(K=100,r=0.8)   # parameters: a named vector

# Identify how long we run the simulation
deltaT_logistic <- .1    # timestep length
timesteps_logistic <- 200   # must be a number greater than 1

# Identify the standard deviation of the stochastic noise
D_logistic <- .5

# Do one simulation of this differential equation
logistic_out_r <- euler_stochastic(
  deterministic_rate = deterministic_logistic_r,
  stochastic_rate = stochastic_logistic_r,
  initial_condition = init_logistic,
  parameters = logistic_parameters,
  deltaT = deltaT_logistic,
  n_steps = timesteps_logistic,
  D = D_logistic
)

# Many solutions
n_sims <- 100  # The number of simulations

# Compute solutions
logistic_run_r <- rerun(n_sims) %>%
  set_names(paste0("sim", 1:n_sims)) %>%
  map(~ euler_stochastic(deterministic_rate = deterministic_logistic_r,
                         stochastic_rate = stochastic_logistic_r,
                         initial_condition = init_logistic,
                         parameters = logistic_parameters,
                         deltaT = deltaT_logistic,
                         n_steps = timesteps_logistic,
                         D = D_logistic)
  ) %>%
  map_dfr(~ .x, .id = "simulation")


# Plot these all up together
ggplot(data = logistic_run_r) +
  geom_line(aes(x=t, y=x, color = simulation)) +
  ggtitle("Spaghetti plot for the logistic SDE") +
  guides(color="none")

### Any less than 0?
bad_sim <- logistic_run_r %>% filter(x <0) %>% head(1) %>% pull(simulation)

### Plot bad simulation
p1 <- logistic_run_r %>%
  filter(simulation == bad_sim) %>%
ggplot() +
  geom_line(aes(x=t, y=x)) +
  ggtitle("One realization of the logistic SDE") +
  guides(color="none") +
  theme_bw() +
  theme(
    legend.position = "bottom",
    legend.text = element_text(size = 14),
    axis.title.x = element_text(size = 14),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10),
    axis.title.y = element_text(size = 14)
  ) +
  scale_color_colorblind()

ggsave(filename = 'figures/25-sdes/poor-sde.png',plot=p1,width=4,height=2)

