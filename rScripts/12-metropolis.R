wilson_data_plot <- ggplot(data = wilson) +
  geom_point(aes(x = days, y = mass)) +
  labs(
    x = "Days since birth",
    y = "Weight (pounds)"
  )

wilson_data_plot

days <- seq(0, 1500, by = 1)

p1 <- 78
p2 <- -2.461935
p3 <- 0.017032
mass <- p1 / (1 + exp(-(p2 + p3 * days)))

my_guess <- tibble(days, mass)

wilson_data_plot +
  geom_line(data = my_guess, color = "red", aes(x = days, y = mass))


days <- seq(0, 1500, by = 1)

p1 <- 78
p2 <- -2.461935
p3 <- 0.017032
mass <- p1 / (1 + exp(-(p2 + p3 * days)))

my_guess <- tibble(days, mass)

my_guess_plot <- wilson_data_plot +
  geom_line(data = my_guess, color = "red", aes(x = days, y = mass))

my_guess_plot




days <- seq(0, 1500, by = 1)

p1 <- 65
p2 <- -2.461935
p3 <- 0.017032
mass <- p1 / (1 + exp(-(p2 + p3 * days)))

my_guess_two <- tibble(days, mass)

my_guess_plot +
  geom_line(data = my_guess_two, color = "blue", aes(x = days, y = mass))

#####
# Can we do this with compute likelihood?
my_model <- mass ~ p1 / (1 + exp(-(p2 + p3 * days)))

# This allows for all the possible combinations of parameters
parameters <- tibble(p1 = c(78, 65), p2 = -2.461935, p3 = 0.017032)





out_values <- compute_likelihood(my_model, demodelr::wilson, parameters)$likelihood

likelihood_ratio_wilson <- function(proposed, current) {

  # Can we do this with compute likelihood?
  my_model <- mass ~ p1 / (1 + exp(-(p2 + p3 * days)))


  # This allows for all the possible combinations of parameters
  parameters <- tibble(p1 = c(current, proposed), p2 = -2.461935, p3 = 0.017032)

  # Compute the likelihood and return the likelihood from the list
  out_values <- compute_likelihood(my_model, wilson, parameters)$likelihood

  # Return the likelihood from the list:
  ll_ratio <- out_values$l_hood[[2]] / out_values$l_hood[[1]]

  return(ll_ratio)
}

likelihood_ratio_wilson(64, 70)
