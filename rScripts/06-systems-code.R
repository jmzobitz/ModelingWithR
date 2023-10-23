k <-1
beta <- 1
s_window <- c(0,4)
i_window <- c(0,4)

systems_eq <- c(dsdt ~ -k*S*I,
                didt ~ k*S*I-beta*I )

# Now we plot the solution.
phaseplane(systems_eq,'S','I',s_window,i_window)



phaseplane(systems_eq,'S','I',s_window,i_window) +
  stat_function(fun=function(x)0, geom="line", aes(colour="S' = 0"),size=2) +
  stat_function(fun=function(x)0, geom="line", aes(colour="I' = 0"),size=2,linetype=2,inherit.aes = TRUE) +
  geom_vline(xintercept = 0,color='#00bfc4',size=2)  +
  geom_vline(xintercept = beta/k,color='#f8766d',size=2)  +
  #geom_vline(xintercept = beta/k, aes(colour="I' = 0"),size=2) +
  scale_color_discrete(name="Nullclines",breaks=c("S' = 0","I' = 0"))

phaseplane(systems_eq,'S','I',c(0,0.25),c(0,0.25))  +
  stat_function(fun=function(x)0, geom="line", aes(colour="S' = 0"),size=2) +
  stat_function(fun=function(x)0, geom="line", aes(colour="I' = 0"),size=2,linetype=2,inherit.aes = TRUE) +
  geom_vline(xintercept = 0,color='#00bfc4',size=2)  +
  #geom_vline(xintercept = beta/k,color='#f8766d',size=2)  +
  #geom_vline(xintercept = beta/k, aes(colour="I' = 0"),size=2) +
  scale_color_discrete(name="Nullclines",breaks=c("S' = 0","I' = 0"))


t_window <- c(0,3)
x_window <- c(0,5)
system_eq <- c(dt ~ 1,
               dx ~ -0.7 * x*(3-x)/(1+x))

phaseplane(system_eq,"t","x",t_window,x_window)

# HW problems
b<- 0.2
c <- 0.1
n=2
phaseplane(c(dt~1,dr~b*r/(1+r^n)-c*r),"t","r",c(0,5),c(0,5))

# $$ \frac{dS}{dt} = I + p \cdot (W - S) $$
I <- 1
p <- 0.3
W <- 3

phaseplane(c(dt~1,dS~I+p*(W-S)),"t","S",c(0,10),c(0,10))


