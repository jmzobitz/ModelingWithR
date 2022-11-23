
# This function computes the values of a 2 by 2 matrix where we want some desired phase plane

# det < 0 --> saddle
# det > 0 & trace > 0 & det < tr^/4 -- > unstable
# det > 0 & trace > 0 & det > tr^/4 -- > unstable spiral
# det > 0 & trace < 0 & det < tr^/4 -- > stable
# det > 0 & trace < 0 & det > tr^/4 -- > stable spiral
# det > 0 & trace = 0 --> center

# to get integrer values, generally speaking:
# c | a, k^2 | det, k | trace --> we just set k = 1 for simplicity
coeff_cal <- function(trace,deter,a,c) {
  
  d <- trace - a
  b <- (a*d-deter)/c
  
  print(demodelr::eigenvalues(c(a,b,c,d)))
  
  return(c(a,b,c,d))
  
}
