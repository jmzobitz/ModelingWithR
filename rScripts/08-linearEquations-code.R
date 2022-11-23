# Script so we can try out fitting for a periodic function

# The actual curve is the following:

t<- 0:24

y<- round(0.75*sin(pi/12*t)-7*cos(pi/12*t)+60 + rnorm(n=length(t),sd=1))

# We based this on approximate temperature from Minneapolis on May 31, 2021, but used desmos to make the curve
plot(t,y)

my_data <- tibble( sinT = sin(pi/12*t), cosT = cos(pi/12*t),y )

regression_formula <- y ~ 1 + sinT + cosT
lm(regression_formula,my_data)

my_new_tibble <-


#### Do a nonlinear fit

my_nonlin_data <- tibble(t,y)


# Define the regression formula
temp_formula <- y ~ A + B*sin(pi/12*t)+C*cos(pi/12*t)


# Apply the nonlinear fit
nonlinear_fit <- nls(formula = temp_formula,
                     data = my_nonlin_data,
                     start = list(A = 50, B=1, C = -10)
)

summary(nonlinear_fit)


# Augment the model
temp_model <- broom::augment(nonlinear_fit, data = my_nonlin_data)

# Plot the data with the model
ggplot(data = my_nonlin_data) +
  geom_point(aes(x = t, y =y),
             color = "red",
             size = 2
  ) +
  geom_line(
    data = temp_model,
    aes(x = t, y = .fitted)
  ) 