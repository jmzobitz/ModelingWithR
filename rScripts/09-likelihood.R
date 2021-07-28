a <- log(k/0.45-1)
# Gause data
my_model <- yOut ~ k/(1+exp(log(k/0.45-1)+b*time))


# Identify the ranges of the parameters that we wish to investigate
kParam <- seq(5,20,length.out=100)
bParam <- seq(-1,0,length.out=100)

kParam <- seq(11,14,length.out=100)
bParam <- seq(-0.3,-0.1,length.out=100)

# This allows for all the possible combinations of parameters
parameters <- expand.grid(k=kParam,b=bParam)


out_values <- compute_likelihood(my_model,MAT369Code::yeast,parameters,logLikely=TRUE)

out_values$likelihood %>%
ggplot()+
   geom_tile(aes(x=k,y=b,fill = l_hood)) +
  stat_contour(aes(x=k,y=b,z = l_hood))
#   geom_point(data=optValue,aes(x=optValue[[2]],y=optValue[[3]]),size=4,color="red") +
#   labs(title="Contour Plot of Likelihood Function",
#        x=names(parameters)[1],
#        y=names(parameters)[2],
#        fill="Likelihood")

# Define the parameters and the times that you will evaluate the equation
params <- out_values$opt_value
time = seq(0,60,length.out=100)

# Get the right hand side of your equations
new_eq <-my_model %>%
  formula.tools::rhs()

# This collects the parameters and data into a list
in_list <- c(params,my_time) %>% as.list()

# The eval command evaluates your model
out_model <- eval(new_eq,envir=in_list)

# Now collect everything into a dataframe:
my_prediction <- tibble(t = time, volume = out_model)


ggplot() +
  geom_point(data = yeast,
             aes(x=time,y=volume),
             color='red',
             size=2) +
  geom_line(data = my_prediction,
            aes(x=time,y=volume)) +
  labs(x = 'Time', y= 'Volume')



model_volume <- params$k/(1+exp(log(params$k/0.45-1)+params$b*my_time))
####

# Gause data
my_model <- daphnia ~ c*algae^(1/theta)


# Identify the ranges of the parameters that we wish to investigate
thetaParam <- seq(1,20,length.out=100)
cParam <- seq(0,5,length.out=100)


# This allows for all the possible combinations of parameters
parameters <- expand.grid(c=cParam,theta=thetaParam)


out_values <- compute_likelihood(my_model,MAT369Code::phosphorous,parameters,logLikely=TRUE)



### Single value likelihoods
my_data <- tibble(x=c(1,2,4,4), y = c(3,5,4,10))
my_model <- y~b*x
my_params <- tibble(b=seq(0,10,length.out=100))

out_values <- compute_likelihood(my_model,my_data,my_params,logLikely=FALSE)

out_values$likelihood %>%
  ggplot(aes(x=b,y=l_hood)) + geom_line()
