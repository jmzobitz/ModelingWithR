library(tidyverse)
enzyme_data <- tibble(
  s = c(0.1,0.2,0.5,1.0,2.0,3.5,5.0),
  V = c(0.04,0.08,0.17,0.24,0.32,0.39,0.42) )

# Linear fit
enzyme_fit <- lm(I(1/V) ~ 1+ I(1/s),
                 data = enzyme_data)

logLik(enzyme_fit)

#\mbox{Model 1: } & V =  \frac{V_{max} s}{s+K_{m}}
nonlinear_fit1 <- nls(V ~ Vmax *s / (s+Km),
                     data = enzyme_data,
                     start = list(Vmax = 0.2,Km=1))

logLik(nonlinear_fit1)


#\mbox{Model 2: } & V= K + Ae^{-bs}
nonlinear_fit2 <- nls(V ~ K+ A*exp(-b*s),
                     data = enzyme_data,
                     start = list(A = -0.3, b=1.96,K = 0.4))

logLik(nonlinear_fit2)


#\mbox{Model 3: } & V = \frac{K}{1+e^{-a-bs}} \\
nonlinear_fit3 <- nls(V ~ K/(1+exp(a-b*s)),
                     data = enzyme_data,
                     start = list(a = 2, b=1.96,K = 0.4))

logLik(nonlinear_fit3)
