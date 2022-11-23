## Step 1: Define the model and parameters
phos_model <- daphnia ~ c * algae^(1 / theta)

# Define the parameters that you will use with their bounds
phos_param <- tibble(
  name = c("c", "theta"),
  lower_bound = c(0, 1),
  upper_bound = c(2, 20)
)

phos_iter <- 1000

## Step 3: Compute MCMC estimate
phos_mcmc <- mcmc_estimate(
  model = phos_model,
  data = phosphorous,
  parameters = phos_param,
  iterations = phos_iter
)

mcmc_analyze(
  model = phos_model,
  data = phosphorous,
  mcmc_out = phos_mcmc
)

# rename this to avoid confusion
in_data <- phosphorous
independent_var <- names(in_data)[1] # We will always have the independent variable first

model <- phos_model
mcmc_out <- phos_mcmc

# Plot the estimates
param_estimates <- mcmc_out %>%
  filter(accept_flag) %>%
  select(-accept_flag, -l_hood)

p1 <- GGally::ggpairs(data = param_estimates, diag = list(continuous = "barDiag", discrete = "barDiag", na = "naDiag")) +
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


ggsave(filename = 'figures/13-mcmc/histogram.png',plot=p1,width=4,height=3)

  new_eq <- model %>%
    formula.tools::rhs()
  
  # Internal function to compute the model
  compute_model <- function(parameters, model_eq, mydata) {
    in_list <- c(parameters, mydata) %>% as.list()
    out_data <- eval(model_eq, envir = in_list)
    
    out_tibble <- mydata %>%
      mutate(model = out_data)
    return(out_tibble)
  }
  
  out_model <- mcmc_out %>%
    filter(accept_flag) %>%
    select(-accept_flag, -l_hood) %>%
    mutate(id = 1:n()) %>%
    group_by(id) %>%
    nest() %>%
    rename(in_params = data) %>%
    mutate(m_data = lapply(X = in_params, FUN = compute_model, new_eq, in_data)) %>%
    unnest(cols = c(m_data)) %>%
    ungroup() %>%
    select(-id, -in_params)
  
 p2 <- ggplot(out_model) +
    geom_boxplot(aes_string(x = independent_var, y = "model",group = independent_var),outlier.shape = NA) +
    geom_point(data = in_data, aes_string(x = independent_var, y = names(in_data)[2]), color = "red", size = 2) +
    labs(y = names(in_data)[2]) +
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
  
 ggsave(filename = 'figures/13-mcmc/output-plot.png',plot=p2,width=4,height=3)
 
 
 #### NOW DO TOURISM MODEL
 ## Step 1: Define the model, parameters, and data
 # Define the tourism model
 tourism_model <- c(
   dRdt ~ resources * (1 - resources) - a * visitors,
   dVdt ~ b * visitors * (resources - visitors)
 )
 
 # Define the parameters that you will use with their bounds
 tourism_param <- tibble(
   name = c("a", "b"),
   lower_bound = c(10, 0),
   upper_bound = c(30, 5)
 )
 
 ## Step 2: Determine MCMC settings
 # Define the initial conditions
 tourism_init <- c(resources = 0.995, visitors = 0.00167)
 
 deltaT <- .1 # timestep length
 n_steps <- 15 # must be a number greater than 1
 
 # Define the number of iterations
 tourism_iter <- 1000
 
 ## Step 3: Compute MCMC estimate
 tourism_out <- mcmc_estimate(
   model = tourism_model,
   data = parks,
   parameters = tourism_param,
   mode = "de",
   initial_condition = tourism_init,
   deltaT = deltaT,
   n_steps = n_steps,
   iterations = tourism_iter,
 )
 
 
 # rename this to avoid confusion
 in_data <- parks
 independent_var <- names(in_data)[1] # We will always have the independent variable first
 
 mcmc_out <- tourism_out
 model <- tourism_model
 initial_condition <- tourism_init
 # Plot the estimates
 param_estimates <- mcmc_out %>%
   filter(accept_flag) %>%
   select(-accept_flag, -l_hood)
 
 p3 <- GGally::ggpairs(data = param_estimates, diag = list(continuous = "barDiag", discrete = "barDiag", na = "naDiag")) +
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
 
 ggsave(filename = 'figures/13-mcmc/histogram-tourism.png',plot=p3,width=4,height=3)
 
compute_model <- function(parameters, model,initial_condition, deltaT,n_steps) {
     
     out_data <- rk4(model,
                     parameters = parameters,
                     initial_condition=initial_condition,
                     deltaT=deltaT,
                     n_steps = n_steps) %>%
       pivot_longer(cols=c(-"t")) %>%
       rename(model=value)
     
     
     return(out_data)
   }
   
   
   out_model <- mcmc_out %>%
     filter(accept_flag) %>%
     select(-accept_flag, -l_hood) %>%
     mutate(id = 1:n()) %>%
     group_by(id) %>%
     nest() %>%
     rename(in_params = data) %>%
     mutate(m_data = lapply(X = in_params, FUN = compute_model, model, initial_condition,deltaT,n_steps)) %>%
     unnest(cols = c(m_data)) %>%
     ungroup() %>%
     select(-id, -in_params) %>%
     group_by(across(c(1,2))) %>%
     summarize(across(.cols = c("model"), .fns = quantile, probs = c(0.025, 0.50, 0.975))) %>%
     mutate(probs = c("q025", "q50", "q975")) %>%
     ungroup() %>%
     pivot_wider(names_from = "probs", values_from = "model")
   
   
   # Mutate the data in a long format for comparison
   data_long <- parks %>%
     pivot_longer(cols=c(-1)) %>%
     rename(t=1)
   
  p4 <-  ggplot(out_model) +
     geom_line(aes(x = t, y = q50)) +
     geom_ribbon(aes(x = t, ymin = q025, ymax = q975), alpha = 0.3) +
     geom_point(data = data_long, aes(x = t, y = value), color = "red", size = 2) +
     labs(y = "") + facet_grid(name~.,scales="free_y") +
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
  
  ggsave(filename = 'figures/13-mcmc/output-tourism.png',plot=p4,width=4,height=3)
  
   