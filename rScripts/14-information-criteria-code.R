
## Step 1: Define the model, parameters, and data
  # Define the tourism model
yeast_model_1 <- volume ~ K/(1+exp(log(K/0.45-1)-b*time))

yeast_param <- tibble(
  name = c("b", "K"),
  lower_bound = c(0, 0),
  upper_bound = c(1, 20)
  )
## Step 2: Determine MCMC settings
# Define the initial conditions

# Define the number of iterations
yeast_iter <- 1000
## Step 3: Compute MCMC estimate
yeast_m1_out <- mcmc_estimate(
    model = yeast_model_1,
    data = yeast,
    parameters = yeast_param,
    iterations = yeast_iter)

mcmc_analyze(
  model = yeast_model_1,
  data = yeast,
  mcmc_out = yeast_m1_out)

# 
# [1] "The parameter values at the optimized log likelihood:"
# # A tibble: 1 × 3
# l_hood     b     K
# <dbl> <dbl> <dbl>
#   1   7.96 0.242  12.8

### Yeast model 2
## Step 1: Define the model, parameters, and data



yeast_model_2 <- volume ~ K + (0.45 - K)*exp(-b*time)

yeast_param <- tibble(
  name = c("b", "K"),
  lower_bound = c(0, 0),
  upper_bound = c(1, 20)
)
## Step 2: Determine MCMC settings
# Define the initial conditions

# Define the number of iterations
yeast_iter <- 1000
## Step 3: Compute MCMC estimate
yeast_m2_out <- mcmc_estimate(
  model = yeast_model_2,
  data = yeast,
  parameters = yeast_param,
  iterations = yeast_iter)

mcmc_analyze(
  model = yeast_model_2,
  data = yeast,
  mcmc_out = yeast_m2_out)

#[1] "The parameter values at the optimized log likelihood:"
## A tibble: 1 × 3
#l_hood      b     K
#<dbl>  <dbl> <dbl>
#  1   13.1 0.0493  14.7

0.242  12.8

yeast_out <- tibble(
  time = seq(0,60,length.out=200),
  model1 =  12.8/(1+exp(log(12.8/0.45-1)-0.242*time)),
  model2 = 14.7 + (0.45 - 14.7)*exp(-0.0493*time)
) %>%
  pivot_longer(cols=c(-"time"))

ggplot() +
  geom_point(data = yeast, aes(x=time, y= volume),size=2) +
  geom_line(data =yeast_out,aes(x=time,y=value,color=name,linetype=name),size=1) +
  labs(x="Time (days)",y="Volume (cubic centimeters)",color="Model",linetype="Model") +
  scale_color_discrete(breaks=c("model1", "model2"),
                      labels=c("Logistic model", "Saturating model")) +
  scale_linetype_discrete(breaks=c("model1", "model2"),
                       labels=c("Logistic model", "Saturating model"))
