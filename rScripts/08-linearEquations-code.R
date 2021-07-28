# Script so we can try out fitting for a periodic function

# The actual curve is the following:

t<- 0:24

y<- round(0.75*sin(pi/12*t)-7*cos(pi/12*t)+60 + rnorm(n=length(t),sd=1))

# We based this on approximate temperature from Minneapolis on May 31, 2021, but used desmos to make the curve
plot(t,y)

my_data <- tibble( sinT = sin(pi/12*t), cosT = cos(pi/12*t),y )

regression_formula <- y ~ 1 + sinT + cosT
lm(regression_formula,my_data)
