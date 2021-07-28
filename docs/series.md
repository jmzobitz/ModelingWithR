



















# 1 Welcome Creating this from Bookdown to Github

I stumbled on how to do this by going to this
[website](https://jules32.github.io/bookdown-tutorial/) and built this
out from here. I am glad that I will be able to work on this.

Who to thank Tidyverse Augsburg students sources waterparks family kids

<!--chapter:end:index.Rmd-->

# 2 Local Linearization and the Jacobian

In the previous few sections we focused on systems of equations and the
types of behaviors we should expect when analyzing the stability of the
equilibrium solution. In this section we will extend that concept to
nonlinear systems of equations. We will analyze stability of a nonlinear
system through the concept of *local linearization*.

## 2.1 A first example

Let’s take a look at the following phase plane to this non-linear
system:

$$\\begin{equation}
\\begin{split} 
\\frac{dx}{dt} &= y-1 \\\\  \\qquad(2.1)
\\frac{dy}{dt} &= x^{2}-1 
\\end{split}
\\end{equation}$$

The nullclines for this system are *y* = 1 and *x* =  ± 1, leading two
two equilibrium solutions when we create the phaseplane:

<img src="series_files/figure-markdown_strict/ex1-phaseplane-1.png" alt="Phaseplane for Equation \ref{eq:ex1-ch17}."  />
<p class="caption">
Figure 2.1: Phaseplane for Equation .
</p>

From Figure <a href="#fig:ex1-phaseplane">2.1</a>, arrows on the
phaseplane by the equilibrium solution at (*x*, *y*) = ( − 1, 1) seems
to spiral inwards, whereas the second equilibrium solution at
(*x*, *y*) = (1, 1) has behavior that flows in and out depending on the
direction you approach. Beyond this visualization we can define
additional tools to help characterize the stability of this system near
the equilibrium solutions.

This section is focused on understanding the behavior near the
equilibrium solutions, and in particular applying concepts of *local
linearization* along with our understanding of linear systems. Let’s get
started!

## 2.2 The lynx hare revisited

Let’s take a look at another familiar example. Consider the following
nonlinear system of equations from the Lynx-Hare model, with *H* and *L*
measured in thousands of animals:

$$\\begin{equation}
\\begin{split}
\\frac{dH}{dt} &= .3 H - .1 HL \\\\  \\qquad(2.2)
\\frac{dL}{dt} &=.05HL -.2L
\\end{split}
\\end{equation}$$

You can show that the steady states for Equation (2.2) are
(*H*, *L*) = (0, 0) and (4, 3). The phase plane diagram for this system
is the following:

    # Define the range we wish to evaluate this vector field
    H_window <- c(0,5)
    L_window <- c(0,5)

    system_eq <- c(dH ~ .3*H - .1*H*L,
                   dL ~ .05*H*L -.2*L)

    # Reminder: The values in quotes are the labels for the axes
    phaseplane(system_eq,'H','L',x_window = H_window, y_window = L_window)  

![](series_files/figure-markdown_strict/unnamed-chunk-3-1.png)

Let’s take a closer look at the phase plane near the first equilibrium
solution:

    # Define the range we wish to evaluate this vector field
    H_window <- c(0,0.5)
    L_window <- c(0,0.5)

    system_eq <- c(dH ~ .3*H - .1*H*L,
                   dL ~ .05*H*L -.2*L)

    # Reminder: The values in quotes are the labels for the axes
    phaseplane(system_eq,'H','L',x_window = H_window, y_window = L_window) 

<img src="series_files/figure-markdown_strict/lynx-hare-closer-1.png" alt="A zoomed in view of the lynx-hare system."  />
<p class="caption">
Figure 2.2: A zoomed in view of the lynx-hare system.
</p>

While the phaseplane in Figure <a href="#fig:lynx-hare-closer">2.2</a>
*looks* like this equilibrium solution is unstable, verifying this with
another approach would be useful. To do so, we are going to do a
**locally linear approximation** or **tangent plane approximation**
around *H* = 0, *L* = 0, which we discuss next.

## 2.3 Tangent plane approximations

To extend the notion of a linear approximation, we apply the **tangent
plane approximation** at the point *x* = *a*, *y* = *b*:

*L*(*x*, *y*) = *f*(*a*, *b*) + *f*<sub>*x*</sub>(*a*, *b*) ⋅ (*x* − *a*) + *f*<sub>*y*</sub>(*a*, *b*) ⋅ (*y* − *b*),

where *f*<sub>*x*</sub> is the partial derivative of *f*(*x*, *y*) with
respect to *x* and *f*<sub>*y*</sub> is the partial derivative of
*f*(*x*, *y*) with respect to *y*. For simplicity let’s work with the
equilibrium solution at (0, 0). If we say that
*f*(*H*, *L*) = .3*H* − .1*H**L*, we know *f*(0, 0) = 0. Furthermore the
locally linear approximation is:

$$\\begin{equation}
\\begin{split}
f\_{H} = .3 - .1L & \\rightarrow f\_{H}(0,0)=.3 \\\\
f\_{L} = -.1H & \\rightarrow f\_{L}(0,0)=0
\\end{split}
\\end{equation}$$

With this information we are able to take this and then write down the
locally linear approximation for *f*(*H*, *L*):
*f*(*H*, *L*) ≈ 0 + .3 ⋅ (*H* − 0) − 0 ⋅ (*L* − 0) = .3*H*
.05*H*L -.2\*L Likewise if we consider
*g*(*H*, *L*) = .05*H**L* − .2*L*, then we have:

$$\\begin{equation}
\\begin{split}
g\_{H} = .05L-.2L & \\rightarrow g\_{H}(0,0)=0 \\\\
g\_{L} = .05H-.2 & \\rightarrow f\_{L}(0,0)=-.2
\\end{split}
\\end{equation}$$

With these results, our locally linear approximation for *g*(*H*, *L*)
is:

*g*(*H*, *L*) ≈ 0 + 0 ⋅ (*H* − 0) − .2 ⋅ (*L* − 0) = 0 − .2*L*.

So, at the equilibrium solution, the system behaves like the following
system of equations:

$$\\begin{align}
\\frac{dH}{dt} &= .3H\\\\
\\frac{dL}{dt} &= - .2L
\\end{align}$$

Notice how this the system is entirely decoupled linear system of
equations, so we have for an initial condition
(*H*<sub>0</sub>, *L*<sub>0</sub>) that
*H*(*t*) = *H*<sub>0</sub>*e*<sup>.3*t*</sup> and
*L*(*t*) = *L*<sub>0</sub>*e*<sup> − .2*t*</sup>.

## 2.4 The Jacobian matrix

If we look at the last example before the solution we can write our
system in matrix form:

$$\\begin{equation}
\\begin{pmatrix} H' \\\\ L' \\end{pmatrix} =\\begin{pmatrix} .3 & 0 \\\\ 0 &  -.2 \\end{pmatrix} \\begin{pmatrix} H \\\\ L \\end{pmatrix}
\\end{equation}$$

We define the matrix
$\\displaystyle J= \\begin{pmatrix} .3 & 0 \\\\ 0 & -.2 \\end{pmatrix}$
as the Jacobian matrix. This is a key matrix we will use to investigate
stability of nonlinear systems. While in the Lynx-Hare example we could
easily solve the uncoupled system of equations, it may not be this case
all the time. In that case we will need to understand a little bit more
about analyzing them - which we will revisit the idea of straight line
solutions and eigenvalues.

## 2.5 Predator prey with logistic growth

Let’s take a look at another model developed from the lynx-hare system.
We assumed that the hare grow exponentially (notice the term *r**H* in
their equation.) However we can modify their growth rate to be a
logistic growth function with carrying capacity *K*:

$$\\begin{align}
\\frac{dH}{dt} &= r H \\left( 1- \\frac{H}{K} \\right) - b HL \\\\
\\frac{dL}{dt} &=ebHL -dL
\\end{align}$$

Through a rescaling of this system $\\displaystyle x=\\frac{H}{K}$,
$\\displaystyle y=\\frac{L}{r/b}$ and *T* = *r**t* we can rewrite this
system as:

$$\\begin{align}
\\frac{dx}{d T} &= x(1-x) - xy \\\\
\\frac{dy}{d T} &=\\frac{ebK}{r}xy -\\frac{d}{r}y
\\end{align}$$

In order to analyze the Jacobian matrix we will need to compute several
partial derivatives:

$$\\begin{align}
\\frac{\\partial}{\\partial x} \\left( f(x,y) \\right) &= \\frac{\\partial}{\\partial x} \\left( x(1-x) - xy \\right) = 1-2x-y \\\\
\\frac{\\partial}{\\partial y} \\left( f(x,y) \\right) &= \\frac{\\partial}{\\partial y} \\left( x(1-x) - xy \\right) = -x \\\\
\\frac{\\partial}{\\partial x} \\left( g(x,y) \\right) &= \\frac{\\partial}{\\partial x} \\left( \\frac{ebK}{r}xy -\\frac{d}{r}y \\right) = \\frac{ebK}{r}y  \\\\
\\frac{\\partial}{\\partial y} \\left( g(x,y) \\right) &= \\frac{\\partial}{\\partial y} \\left( \\frac{ebK}{r}xy -\\frac{d}{r}y \\right) = \\frac{ebK}{r}x -\\frac{d}{r}
\\end{align}$$

So we can construct the Jacobian matrix, ready for evaluation at any
(*x*, *y*) equilibrium solution:

$$\\begin{equation}
J\_{(x,y)} = \\begin{pmatrix} 1-2x-y & -x \\\\ \\frac{ebK}{r}y & \\frac{ebK}{r}x -\\frac{d}{r} \\end{pmatrix}
\\end{equation}$$

Sometimes computing the Jacobian matrix is a good first step so then you
are ready to compute the equilibrium solutions. In the exercises you
will determine equilibrium solutions and visualize the Jacobian matrix.

## 2.6 Concluding thoughts

To summarize, let’s say we have the following system of equations

$$\\begin{align}
\\frac{dx}{dt} &= f(x,y) \\\\
\\frac{dy}{dt} &= g(x,y)
\\end{align}$$

Assuming we have an equibrium solution at (*x*, *y*) = (*a*, *b*), the
Jacobian matrix at that solution is:

$$\\begin{equation}
J\_{(a,b)} =\\begin{pmatrix} f\_{x}(a,b) & f\_{y}(a,b) \\\\ g\_{x}(a,b) &  g\_{y}(a,b) \\end{pmatrix}
\\end{equation}$$

The Jacobian matrix also extends to higher order systems as well.

## 2.7 Exercises

<span id="exr:unnamed-chunk-4" class="exercise"><strong>Exercise 2.1:
</strong></span>Consider the following nonlinear system:

$$\\begin{equation}
\\begin{split} 
\\frac{dx}{dt} &= y-1 \\\\ 
\\frac{dy}{dt} &= x^{2}-1 
\\end{split}
\\end{equation}$$

 

<span id="exr:unnamed-chunk-5" class="exercise"><strong>Exercise 2.2:
</strong></span>By solving directly, show that (*H*, *L*) = (0, 0) and
(4, 3) are equilibrium solutions to the following system of equations:

$$

 

<span id="exr:unnamed-chunk-6" class="exercise"><strong>Exercise 2.3:
</strong></span>Consider the following nonlinear system:

$$\\begin{equation}
\\begin{split}
\\frac{dx}{dt} &= x-y \\\\
\\frac{dy}{dt} &=-y + \\frac{5x^2}{4+x^{2}},
\\end{split}
\\end{equation}$$

 

<span id="exr:unnamed-chunk-7" class="exercise"><strong>Exercise 2.4:
</strong></span>Consider the nonlinear system

$$\\begin{equation}
\\begin{split}
\\frac{dx}{dt} &= 2x+3y+xy \\\\
\\frac{dy}{dt} &= -x + y - 2xy^{3},
\\end{split}
\\end{equation}$$

 

<span id="exr:unnamed-chunk-8" class="exercise"><strong>Exercise 2.5:
</strong></span>Consider the following system:

$$\\begin{equation}
\\begin{split}
\\frac{dx}{dt} &= y^{2} \\\\
\\frac{dy}{dt} &= -\\frac{2}{3} x,
\\end{split}
\\end{equation}$$

 

<span id="exr:unnamed-chunk-9" class="exercise"><strong>Exercise 2.6:
</strong></span>Consider the lynx-hare system with parameters *r*, *b*,
*e*, and *d*:

$$\\begin{equation}
\\begin{split}
\\frac{dH}{dt} &= r H - b HL \\\\
\\frac{dL}{dt} &=ebHL -dL
\\end{split}
\\end{equation}$$

 

<span id="exr:unnamed-chunk-10" class="exercise"><strong>Exercise 2.7:
</strong></span>This problem revisits the modified lynx-hare system:
$$\\begin{equation}
\\begin{split}
\\frac{dH}{dt} &= r H \\left( 1- \\frac{H}{K} \\right) - b HL \\\\
\\frac{dL}{dt} &=ebHL -dL
\\end{split}
\\end{equation}$$

 

<!-- Adapted from LW pg 121 -->

<span id="exr:unnamed-chunk-11" class="exercise"><strong>Exercise 2.8:
</strong></span>A model for the spread of a disease where people recover
is given by the following differential equation:

$$\\begin{equation}
\\begin{split}
\\frac{dS}{dt} &= -\\alpha SI \\\\
\\frac{dI}{dt} &= \\alpha SI - \\gamma I \\\\
\\frac{dR}{dt} &= \\gamma I,
\\end{split}
\\end{equation}$$

 

<!-- LW pg 157 158 #3 -->

<span id="exr:unnamed-chunk-12" class="exercise"><strong>Exercise 2.9:
</strong></span>A population of fish used as food is an example of a
renewable resource. This population decreases due to harvesting the
fish. As long as the rate of harvest is smaller than the replacement
rate, theoretically the population would be considered a renewable
resource. However fish do have natural predators, which may also be
harvested at the same time. A model that describes this interaction is

$$\\begin{equation}
\\begin{split}
\\frac{dN}{dt} &= rN - cNP - \\rho E N \\\\
\\frac{dP}{dt} &= bcNP - mP - \\sigma EP,
\\end{split}
\\end{equation}$$

where *E* is the fishing effort and *ρ* and *σ* are the catchability
coefficients for the prey and predator.

 

<img src="series_files/figure-markdown_strict/glucose-1.png" alt="Glucose transporter reaction schemes."  />
<p class="caption">
Figure 2.3: Glucose transporter reaction schemes.
</p>

 

<!-- Problem adapted from Keener pg 64 and 65 2.4.1 glucose transport -->

<span id="exr:unnamed-chunk-13" class="exercise"><strong>Exercise 2.10:
</strong></span>The chemical glucose is transported across the cell
membrane using a carrier proteins. These proteins can have different
states (open or closed) that can be bound to a glucose substrate. The
schematic for this reaction is shown in Figure
<a href="#fig:glucose">2.3</a>. The system of differential equations
describing this reaction is:

$$\\begin{equation}
\\begin{split}
\\frac{dp\_{i}}{dt} &= k p\_{e} - k p\_{i} + k\_{+} s\_{i}c\_{i}-k\_{i}p\_{i} \\\\
\\frac{dp\_{e}}{dt} &= k p\_{i} - k p\_{e} + k\_{+} s\_{e}c\_{e}-k\_{-}p\_{e} \\\\
\\frac{dc\_{i}}{dt} &= k c\_{e} - k c\_{i} + k\_{-} p\_{i}-k\_{+}s\_{i}c\_{i} \\\\
\\frac{dc\_{e}}{dt} &= k c\_{i} - k c\_{e} + k\_{-} p\_{e}-k\_{+}s\_{e}c\_{e}
\\end{split}
\\end{equation}$$

<!--chapter:end:17-jacobian.Rmd-->
