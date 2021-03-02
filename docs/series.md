

















1 Welcome Creating this from Bookdown to Github
===============================================

I stumbled on how to do this by going to this
[website](https://jules32.github.io/bookdown-tutorial/) and built this
out from here. I am glad that I will be able to work on this.

Who to thank Tidyverse Augsburg students sources waterparks family kids

<!--chapter:end:index.Rmd-->

(PART) Models with Differential Equations
=========================================

2 Models of rates with data
===========================

2.1 What is the book about?
---------------------------

The focus of this textbook is understanding *rates of change* and how
you can apply them to model real-world phenomena. In addition this
textbook focuses on *using* equations with data, building both your
competence and confidence to construct a mathematical model from data
and a context.

I can imagine that your first sustained encounter of rates of change was
in your calculus course, perhaps answering the following types of
questions:

-   If *y* = *x**e*<sup> − *x*</sup>, determine the derivative function
    *f*′(*x*).
-   Where is the graph of sin (*x*) increasing at an increasing rate?
-   If you release a ball from the top of a skyscraper 500 meters above
    the ground, what is its speed when it impacts the ground?

Some of these mathematical questions derive from models from physical
phenomena, such as the ball falling off a skyscraper which assumes that
acceleration of the ball is constant. This assumption is typically a
starting point to build a mathematical model. Using acceleration, the
velocity (or the antiderivative of acceleration) can be found, from
which the position function can be calculated through
antidifferentiation.

However many times we observe data and *then* construct a mathematical
model to corroborate our observations. Some of the these models come
from well-understood physical phenomena (such as the case of the falling
ball).

2.2 Modeling in context: the spread of a disease
------------------------------------------------

To see what the first steps would be, consider the data in Figure
<a href="#fig:sierra-leone">2.1</a>, which come from an [Ebola
outbreak](https://www.cdc.gov/vhf/ebola/history/2014-2016-outbreak/index.html)
in Sierra Leone in 2014.

<img src="series_files/figure-markdown_strict/sierra-leone-1.png" alt="An Ebola outbreak in Sierra Leone"  />
<p class="caption">
Figure 2.1: An Ebola outbreak in Sierra Leone
</p>

These data represent the deaths due to Ebola in Sierra Leone.
Constructing a model from disease dynamics is part of the field of
[mathematical
epidemiology](https://en.wikipedia.org/wiki/Mathematical_modelling_of_infectious_disease).
How we construct a mathematical model of the spread of this outbreak
largely depends on the assumptions underlying the dynamics of the
disease, such as considering the rate of spread of Ebola. This model
also depends on the spatial scale studied as well - how a model is
constructed depends if we wish to examine the spread of the disease in
an individual immune response, or understand general principles for the
spread through a population.

Basic questions that one can ask is if the rate of deaths due to Ebola
proportional to:

-   The number of people infected?
-   The number of people not infected?
-   The number of infected people coming into contact with those not
    infected?

Let’s see what each of these mathematical models would look like if we
wrote down an equation. Since we are discussing *rates* of infection,
this means we will need a *rate of change* or derivative. Let’s use the
letter *I* to represent the number of people that are infected.

### 2.2.1 Model 1: Infection rate proportional to number infected.

In the first case (the rate of infection proportional to the number of
people infected), to translate that statement into an equation would be
the following:

$$\\begin{equation}
\\frac{dI}{dt} = kI
\\end{equation}$$

where *k* can be thought of as a proportionality constant, with units of
time**<sup> − 1</sup> for consistency. This is an example of a
*differential equation*, which is just a mathematical equation with
rates of change.

Differential equations may look different because what we are solving
for is the function *I*(*t*).[1] Later on we will examine how to
\`\`solve’’ a differential equation (which means we determine the family
of functions consistent with our rate equation).

Notice the proportionality constant *k* - we call this a *parameter*. We
can always try to solve an equation without specifying the parameter -
and then if we wanted to plot a solution the parameter would also be
specified. In some situations we may not be as concerned with the
particular *value* of the parameter but rather its influence on the
long-term behavior of the system (this is one aspect of [bifurcation
theory](https://en.wikipedia.org/wiki/Bifurcation_theory)). Otherwise we
can use the collected data shown above with the given model to determine
the value for *k*. This combination of a mathematical model with data is
called *data assimilation* or *model-data fusion*. How exciting!

Before we think about possible solutions let’s try to reason out if the
first model would be plausible. This model states that the rate of
change (the amount of increase) gets larger the more people that are
sick. That does seem reasonable as a model, but perhaps unreasonable in
real life. In the case of Ebola or any other infection disease,
stringent public health measures would be put in place before large
numbers of people die. We would expect that the rate of infection would
decrease and the number of deaths to slow. So perhaps the second model
might be a little more plausible. At some point the number of people who
are *not* sick will reach zero, making the rate of infection be zero (or
no increase).

### 2.2.2 Model 2: Infection rate proportional to number NOT infected.

In this description notice how we are talking about people who are sick
(which we have denoted as *I*) and people who are *not* sick. This looks
like we might need to introduce another variable for the \`\`not sick’’
people, which we will call *S*, or susceptible. So the differential
equation we would write down would be:

$$

We are still using the parameter *k* as with the previous model. Also
note we introduced the second variable *S* is in Equation (2.1). Because
we have introduced another variable *S* we should also include a
differential equation for how *S* changes as well. One way that we can
do this is by considering our entire population as consisting of two
groups of people: *S* and *I*. Infection brings someone over from *S* to
*I*, which we have in this diagram:

![](series_files/figure-markdown_strict/unnamed-chunk-3-1.png)

There are three reasons why I like to use diagrams like these: (1) they
help organize my thinking about a mathematical model (2) any assumed
parameters are listed, and (3) they help me to see that rates can be
conserved. In other words, if I enter into the box for *I*, then someone
is leaving *S*. In other words, $\\displaystyle \\frac{dS}{dt} = -kS$.
So the two equations together can be represented as:

$$\\begin{align\*}
\\frac{dS}{dt} &= -kS \\\\
\\frac{dI}{dt} &= kS
\\end{align\*}$$

This differential equation is what we would call a *coupled differential
equation*. In order to \`\`solve’’ the system we need to determine
functions for *S* and *I*. This coupled set of equations looks a little
clunky, but we do notice something cool. Algebriacally we have:

$$

Recall from calculus that if a rate of change equals zero then the
function is constant. In this case, the variable *S* + *I* is constant,
or we can also call *S* + *I* = *N*, the number of people in the
population. This means that *S* = *N* − *I*, so we can re-write our
differential equation in one equation:

$$\\begin{equation}
\\frac{dI}{dt} = k(N-I)
\\end{equation}$$

This second model does have some limiting behavior to this model as
well. As the number of infected people reaches *N* (the total population
size), the values of $\\displaystyle \\frac{dI}{dt}$ approaches zero,
meaning *I* doesn’t change. There is one caveat to this - if there are
no infected people around (*I* = 0) *the disease can still be
transmitted*, which might make not good biological sense.

### 2.2.3 Model 3: Infection rate proportional to infected meeting not infected.

The third model rectifies some of the shortcomings of the second model
(which rectified the shortcomings of the first model). This model states
that the rate of infection is due to those who are sick, actually
infecting those who are not sick. This would sort of scenario would also
make some sense, as it focused on that *transmission* of the disease are
between susceptibles and infected people. So if nobody is sick (*I* = 0)
then the disease is not spread. Likewise if there are no susceptibles
(*S* = 0), the disease is not spread as well.

In this case the diagram outlining this approach looks something like
this:

![](series_files/figure-markdown_strict/logistic-1.png)

The differential equations that describe this scenario are the
following:

$$\\begin{align\*}
\\frac{dS}{dt} &= -kSI \\\\
\\frac{dI}{dt} &= kSI
\\end{align\*}$$

Just like before for Model 2 we can combine the two equations to yield a
single differential equation:

$$\\begin{equation}
\\frac{dI}{dt} = k\\cdot I \\cdot (N-I)
\\end{equation}$$
Look’s pretty similar to model 2, doesn’t it? In this case notice the
variable *I* outside the expression. Notice this seems to be appropriate
- if *I* = 0, then there is no increase in infection. If *I* = *N* (the
total population size) then there is no increase in the infection.

2.3 The qualitative nature of solution curves
---------------------------------------------

So far we have primarily been focused on the qualitative understanding
of the different models. One way we can look at how these different
models work together is by plotting $\\displaystyle \\frac{dI}{dt}$
versus *I*. I know we have the parameters *k* and *N* to specify, but
let’s just set them to be *k* = 1 and *N* = 10 respectively. Plots of
these functions are shown in Figure <a href="#fig:threeRates">2.2</a>.

<img src="series_files/figure-markdown_strict/threeRates-1.png" alt="Comparing rates of change for three models"  />
<p class="caption">
Figure 2.2: Comparing rates of change for three models
</p>

There is a lot that we can tell from this figure. Notice how the sign of
$\\displaystyle \\frac{dI}{dt}$ is always positive for Model 1,
indicating that the solution (*I*) is always increasing. For Models 2
and 3, $\\displaystyle \\frac{dI}{dt}$ equals zero when *I* = 10, which
also is the value for *N* After that case,
$\\displaystyle \\frac{dI}{dt}$ turns negative, meaning that *I* is
decreasing.

In summary, we can tell a lot about the *qualitative behavior* of a
solution to a differential equation even without the solution.

2.4 Simulating a differential equation
--------------------------------------

Let’s talk solutions. One thing to note is that usually a differential
equation also has a starting, or an initial value that actualizes the
solution. When we state a differential equation with a starting value we
have an **initial value problem**. For our case here we will assume that
*I*(0) = *I*<sub>0</sub>, where this is also another parameter at our
disposal.

With that assumption, we can (and will solve later!) the following
solutions for these models:

$$\\begin{align\*}
\\mbox{ Model 1 (Exponential): } & I(t) = I\_{0}e^{kt} \\\\
\\mbox{Model 2 (Saturating): } & I(t) = N-(N-I\_{0})e^{-kt} \\\\
\\mbox{Model 3 (Logistic): } & I(t) = \\frac{N \\cdot I\_{0} }{I\_{0}+(N-I\_{0})e^{-kt}}
\\end{align\*}$$

    ## Warning: Removed 63 row(s) containing missing values (geom_path).

<img src="series_files/figure-markdown_strict/threeSoln-1.png" alt="Three models compared"  />
<p class="caption">
Figure 2.3: Three models compared
</p>

In Figure <a href="#fig:threeSoln">2.3</a>, I plot these solutions over
the course of several days, using *k* = 0.03 and *N* = 4000 and
*I*<sub>0</sub> = 5. Notice how Model 1 increases quickly - it actually
grows without bound off the chart! Model 2 and Model 3 have saturating
behavior, but it looks like Model 3 might be the one that actually
captures the trend of the data. Models 2 and 3 are more commonly known
as the **saturating** and **logistic** models respectively.

2.5 Which model is best?
------------------------

All three of these scenarios describe different modeling scenarios.
While we haven’t solved these differential equations, we do have some
intuitive sense of what could occur. With the saturating and logistic
models (Models 2 and 3) we have some limiting behavior the possibility
that the the rate of infecion slows. There are several possible models
that on the surface seem plausible, but which one is the *best* one? We
will also address that question later on in this textbook when we
discuss *model selection*.

Model selection is one key part of the modeling hypothesis - where we
investigate the implications of a particular model analyzed. If we don’t
do this, we don’t have an opportunity to test out what is plausible and
what is believeable in our models.

2.6 Exercises
-------------

<span id="exr:unnamed-chunk-4" class="exercise"><strong>Exercise 2.1:
</strong></span>Solutions to an outbreak model of the flu are the
following: $$

where *t* is in days. Make a plot of both of these models for
0 ≤ *t* ≤ 100. How would you describe the growth of the outbreak as *t*
increases? How many people will be infected overall? Finally,evaluate
lim<sub>*t* → ∞</sub>*I*(*t*). How do these results compare to values
found on your graph?

 

<span id="exr:unnamed-chunk-5" class="exercise"><strong>Exercise 2.2:
</strong></span>The general solution for the saturating and the logistic
models are: $$ where *I*<sub>0</sub> is the initial number of people
infected and *N* is the overall population size. Using the functions
from the previous exercise, for both models, what are *N* and
*I*<sub>0</sub>?

 

<span id="exr:unnamed-chunk-6" class="exercise"><strong>Exercise 2.3:
</strong></span>The general solution for the saturating and the logistic
models are: $$ where *I*<sub>0</sub> is the initial number of people
infected and *N* is the overall population size. For both models
carefully evaluate the limits to show
lim<sub>*t* → ∞</sub>*I*(*t*) = *N*. How do these compare to the
steady-state values you found for Models 2 and 3 of the outbreak data?

 

<img src="series_files/figure-markdown_strict/liberia-1.png" alt="An Ebola outbreak in Liberia in 2014"  />
<p class="caption">
Figure 2.4: An Ebola outbreak in Liberia in 2014
</p>

 

<span id="exr:unnamed-chunk-7" class="exercise"><strong>Exercise 2.4:
</strong></span>Figure <a href="#fig:liberia">2.4</a> shows the Ebola
outbreak for the country of Liberia in 2014. If we were to apply the
logistic model based on this graphic what would be your estimate for
*N*?

  <!-- Sethi model for advertising -->

<span id="exr:unnamed-chunk-8" class="exercise"><strong>Exercise 2.5:
</strong></span>A model that describes the growth of sales of a product
in response to advertising is the following:
$$\\frac{dS}{dt} = .55\\sqrt{1-S}-S, $$
where *S* is the product’s share of the market (scaled between 0 and 1).
Make a plot of the function $f(S)=.55\\sqrt{1-S}-S$. for 0 ≤ *S* ≤ 1.
Interpret your plot to predict when the market share will be increasing
and decreasing. At what value is $\\frac{dS}{dt}=0$? (This is called the
**steady-state** value.).

A second campaign is has the following differential equation:
$$\\frac{dS}{dt} = .2\\sqrt{1-S}-S $$

What is the steady-state value and how does it compare to the previous
one?

 

<span id="exr:unnamed-chunk-9" class="exercise"><strong>Exercise 2.6:
</strong></span>A more general form of the advertising model is the
following:
$$\\frac{dS}{dt} = r\\sqrt{1-S}-S, $$
where *S* is the product’s share of the market (scaled between 0 and 1).
The parameter *r* is related to the effectiveness of the advertising
(between 0 and 1). Solve this equation for the steady state value (where
$\\frac{dS}{dt}=0$). Make a plot of the steady state value as a function
of *r*, where 0 ≤ *r* ≤ 1. What can you conclude about the steady state
value as the effectiveness of the advertising increases?

 

<span id="exr:unnamed-chunk-10" class="exercise"><strong>Exercise 2.7:
</strong></span>A common saying is \`\`You are what you eat.’’ This
saying is mostly true and can be related in a mathematical model! An
equation that relates a consumer’s nutrient content (denoted as *y*) to
the nutrient content of food (denoted as *x*) is given by:
*y* = *c**x*<sup>1/*θ*</sup>,
where *θ* ≥ 1 and *c* are both constants is a constant. Units on *x* and
*y* are expressed as a proportion of a given nutrient (such as nitrogen
or carbon).

Let’s start with an example: *y* = *x*. In this case the point
(0.05, 0.05) would say that if an animal ate food that was 5% nitrogen,
their body composition would be 5% as well.

Let’s just assume that *c* = 1. How does the nutrient content of the
consumer compare to the food when *θ* = 2? *θ* = 5? *θ* → ∞? Draw some
sample curves to help illustrate your findings.

 

<span id="exr:unnamed-chunk-11" class="exercise"><strong>Exercise 2.8:
</strong></span>A model for the outbreak of a cold virus assumes that
the rate people get infected is proportional to infected people
contacting susceptible people, as in the logistic model 3. However
people who are infected can also recover and become susceptible again
with rate *α*. Construct a diagram similar Model 3 for this scenario and
also write down the system of differential equations.

 

<span id="exr:unnamed-chunk-12" class="exercise"><strong>Exercise 2.9:
</strong></span>A model for the outbreak of the flu assumes that the
rate people get infected is proportional to infected people contacting
susceptible people, as in Model 3. However people also account for
recovering from the flu, denoted with the variable *R*. Assume that the
rate of recovery is proportional to the number of infected people with
parameter *β*. Construct a diagram like Model 3 for this scenario, and
also write down the system of differential equations.

  <!-- Van den Berg page 19 -->

<span id="exr:unnamed-chunk-13" class="exercise"><strong>Exercise 2.10:
</strong></span>Organisms that live in a saline environment
biochemically maintain the amount of salt in their blood stream. An
equation that represents the level of *S* in the blood is the following:

$$\\frac{dS}{dt} = I + p \\cdot (W - S), $$

where the parameter *I* represents the active uptake of salt, *p* is the
permeability of the skin, and *W* is the salinity in the water. What is
that value of *S* at *steady state*, or when
$\\displaystyle \\frac{dS}{dt} = 0$?

 

<span id="exr:unnamed-chunk-14" class="exercise"><strong>Exercise 2.11:
</strong></span>Use your steady state solution from the last exercise to
determine what parameters (*I*, *p*, or *W*) cause the steady state
value *S* to increase?

 

<!-- From LW -->

<span id="exr:unnamed-chunk-15" class="exercise"><strong>Exercise 2.12:
</strong></span>The immigration rate of bird species (species per time)
from a mainland to an offshore island is
*I*<sub>*m*</sub> ⋅ (1 − *S*/*P*), where *I*<sub>*m*</sub> is the
maximum immigration rate, *P* is the size of the source pool of species
on the mainland, and *S* is the number of species already occupying the
island. Further, the extinction rate is *E* ⋅ *S*/*P*, where *E* is the
maximum extinction rate. The growth rate of the number of species on the
island is the immigration rate minus the extinction rate.

 

<span id="exr:unnamed-chunk-16" class="exercise"><strong>Exercise 2.13:
</strong></span>This problem relates to animal size and volume. Assume
that an animal assimilates nutrients at a rate *R* proportional to its
surface area. Also assume that it uses nutrients at a rate proportional
to its volume. You may assume that the size of the animal is implicitly
a function of the nutrient intake and usage. Determine the size of the
animal if its intake and use rates were in balance (meaning *R* is set
to zero), assuming the animal is the following shapes:

For both of these problems your goal is to determine a numeric value of
*r* and *l*.

<!--chapter:end:01-intro.Rmd-->

3 Phase space and equilibrium solutions
=======================================

In modeling with differential equations, we want to understand how a
system develops both qualitatively and quantitatively. Euler’s method
(and other associated numerical methods for solving differential
equations) illustrate solution behavior numerically. In this section we
are going to focus on the qualitative aspects of a differential
equation.

3.1 Equilibrium solutions
-------------------------

One key thing about the qualitative analysis is we are interested in the
*motion* and the general tendency and the flow of the solution. Because
there could be several possibilities about the flow, one very easy place
is to examine where the is *no* flow - meaning the solution is
stationary. Borrowing ideas from calculus, this occurs when the rate of
change is zero.

<span id="exm:unnamed-chunk-17" class="example"><strong>Example 3.1:
</strong></span>What are the equilibrium solutions to
$\\displaystyle \\frac{dy}{dt}=- y$?

For this example we know that when the rate of change is zero, this
means that $\\displaystyle \\frac{dy}{dt} = 0$, or when 0 =  − *y*. So
*y* = 0 is the equilibrium solution. This example does have a general
solution is when *y*(*t*) = *C**e*<sup> − *t*</sup>, where *C* is an
arbitrary constant. Figure
<a href="#fig:exponential"><strong>??</strong></a> plots different
solution curves, with the equilibrium solution shown as a horizontal
line:

![](series_files/figure-markdown_strict/exponential-1.png)

Notice how all solutions tend to *y* = 0 as *t* increases, no matter if
the initial condition is positive or negative.

<span id="exm:unnamed-chunk-18" class="example"><strong>Example 3.2:
</strong></span>What are the equilibrium solutions to
$\\displaystyle \\frac{dN}{dt} = N \\cdot(1-N)$?

In this case the equilibrium solutions occur when *N* ⋅ (1 − *N*) = 0,
or when *N* = 0 or *N* = 1.  

Given that the generic solution to this differential equation is
$$ \\displaystyle N(t)= \\frac{N\_0}{N\_0 +(1-N\_0) e^{-t}}.$$
Figure @ref(fig:logistic\_soln) displays several different solution
curves.

![](series_files/figure-markdown_strict/logistic_soln-1.png)

 

As with the previous figure, notice how all the solutions tend towards
*N* = 1, but even solutions that start close to *N* = 0 seem to move
away from this equilibrium solution. This brings us to understanding
classifying the *stability* of the equilibrium solutions.

3.2 Stability of equilibrium solutions
--------------------------------------

While it is one thing to determine where the equilibrium solutions are,
we are also interested in classifying the **stability** of the
equilibrium solutions. To do this investigate the behavior of the
differential around the equilibrium solutions, using facts from
calculus:

-   If $\\displaystyle \\frac{dy}{dt}&lt;0$, the function is decreasing.
-   If $\\displaystyle \\frac{dy}{dt}&gt;0$, the function is increasing.

We say that the solution *y* = 0 is a *stable* equilibrium solution in
this case.

Let’s apply this logic to our differential equation
$\\displaystyle \\frac{dy}{dt}=- y$. We know that if *y* = 3,
$\\displaystyle \\frac{dy}{dt}=- 3 &lt;0$, so we say the function is
*decreasing* to *y* = 0. If *y* =  − 2,
$\\displaystyle \\frac{dy}{dt}=- (-2) = 2 &gt;0$, so we say the function
is *increasing* to *y* = 0. This can be represented neatly in the
following figure, which is a phase line diagram:

![](series_files/figure-markdown_strict/unnamed-chunk-19-1.png)

Because the solution is *increasing* to *y* = 0 when *y* &lt; 0, and
*decreasing* to *y* = 0 when *y* &gt; 0, we say that the equilibrium
solution is **stable**, which is also confirmed by the solutions we
plotted above.

<span id="exm:unnamed-chunk-20" class="example"><strong>Example 3.3:
</strong></span>Classify the stability of the equilibrium solutions to
$\\displaystyle \\frac{dy}{dt} = k \\cdot y$, where *k* is a parameter.

In this case the equilibrium solution is still *y* = 0. We will need to
consider two different cases for the stability depending on the value of
*k* (*k* &gt; 0, *k* &lt; 0, and *k* = 0):

-   When *k* &gt; 0, the phase line will be similar to the one above.
-   When *k* = 0 the phase line will be:

![](series_files/figure-markdown_strict/unnamed-chunk-21-1.png)

So in this scenario, the equilibrium solution is *unstable*, as all
solutions flow away from the equilibrium.

![](series_files/figure-markdown_strict/unnamed-chunk-22-1.png)

-   Finally when *k* = 0 we have the differential equation
    $\\displaystyle \\frac{dy}{dt}=0$, which has *y* = *C* as a general
    solution. For this special case the equilibrium solution is neither
    stable or unstable. (By all intents and purposes this is a different
    differential equation than
    $\\displaystyle \\frac{dy}{dt}=k\\cdot y$; something peculiar is
    going on here - which we come back to when discuss bifurcations.)

 

Let’s investigate our other differential equation
$\\displaystyle \\frac{dN}{dt} = N \\cdot(1-N)$. This differential
equation has equilbrium solutions when *N*(1 − *N*) = 0, or *N* = 0 or
*N* = 1. We evaluate the stability of the solutions in the following
table:

<table>
<thead>
<tr class="header">
<th><strong>Test point</strong></th>
<th><strong>Sign of <span class="math inline"><em>N</em>′</span></strong></th>
<th><strong>Tendency of solution</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><span class="math inline"><em>N</em> =  − 1</span></td>
<td>Negative</td>
<td>Decreasing</td>
</tr>
<tr class="even">
<td><span class="math inline"><em>N</em> = 0</span></td>
<td>Zero</td>
<td>Equilibrium solution</td>
</tr>
<tr class="odd">
<td><span class="math inline"><em>N</em> = 0.5</span></td>
<td>Positive</td>
<td>Increasing</td>
</tr>
<tr class="even">
<td><span class="math inline"><em>N</em> = 1</span></td>
<td>Zero</td>
<td>Equilibrium solution</td>
</tr>
<tr class="odd">
<td><span class="math inline"><em>N</em> = 2</span></td>
<td>Negative</td>
<td>Decreasing</td>
</tr>
</tbody>
</table>

Notice how the points that were selected in the first column are either
the the *left* or the *right* of the equilbrium solution. We can also
represent the information in the table using a phase line diagram, but
in this case we need to include *two* equilibrium solutions:

![](series_files/figure-markdown_strict/unnamed-chunk-23-1.png)

Notice how the table and the phase line diagram confirms that *N* is
moving *away* from *N* = 0 (either decreasing when $ N$ is less than 0
and increasing when *N* is greater than 0) and moving *towards* *N* = 1
(either increasing when *N* is between 0 and 1 and decreasing when *N*
is greater than one.

  These results suggest that equilibrium solution at *N* = 0 to be
*unstable* and at *N* = 1 to be *stable*.

Other than writing the words in the phase line diagram, we also use
arrows to signify increasing or decreasing in the solutions.

### 3.2.1 Connection to local linearization.

Notice how when constructing the phase line diagram we relied on the
behavior of solutions *around* the equilibrium solution to classify the
stability. As an alternative we can also use the equilibrium solution
itself.

To do this we are going to consider the general differential equation
$\\displaystyle \\frac{dy}{dt}=f(y)$. We are going to assume that we
have an equilibrium solution at *y* = *y*<sub>\*</sub>.

We are going to borrow local linearization (which we say when working on
Euler’s method) and construct a locally linear approximation to *L*(*y*)
to *f*(*y*) at *y* = *y*<sub>\*</sub>:

*L*(*y*) = *f*(*y*<sub>\*</sub>) + *f*′(*y*<sub>\*</sub>) ⋅ (*y* − *y*<sub>\*</sub>)
We will use *L*(*y*) as an approximation to *f*(*y*). There are two key
things here. First, because we have an equilibrium solution,
*f*(*y*<sub>\*</sub>) = 0. The other key thing is that if we define the
variable *P* = *y* − *y*<sub>\*</sub>, then the differential equation
translates to

$$ \\frac{dP}{dt} = f'(y\_{\*}) \\cdot P $$

Does this differential equation look familiar - it should! This is
similar to the example where we classified the stability of
$\\displaystyle \\frac{dy}{dt} = k \\cdot y$ – cool! So let’s use what
we learned above to classify the stability:

-   If *f*′(*y*<sub>\*</sub>)’ &gt; 0 at an equilibrium solution, the
    equilibrium solution *y* = *y*<sub>\*</sub> will be *unstable*.
-   If *f*′(*y*<sub>\*</sub>) &lt; 0 at an equilibrium solution, the
    equilibrium solution *y* = *y*<sub>\*</sub> will be *stable*.
-   If *f*′(*y*<sub>\*</sub>) = 0, we cannot conclude anything about the
    stability of *y* = *y*<sub>\*</sub>.

<span id="exm:unnamed-chunk-24" class="example"><strong>Example 3.4:
</strong></span>Apply local linearization to classify the stability of
the equilibrium solutions of
$\\displaystyle \\frac{dN}{dt} = N \\cdot(1-N)$

<span class="solution"><em>Solution. </em></span> The locally linear
approximation is *L*(*N*) = 1 − 2*N*. We have *L*(0) = 1 &gt; 0, so
*N* = 0 is unstable. Similarly *L*(1) =  − 1, so *N* = 1 is stable.

3.3 Exercises
-------------

<span id="exr:unnamed-chunk-26" class="exercise"><strong>Exercise 3.1:
</strong></span>What are the equilibrium solutions to the following
differential equations?
After identifying the equilibrium solutions construct a phase line for
each of the differential equations and classify the stability of the
equilibrium solutions using the derivative stability test.

 

<span id="exr:unnamed-chunk-27" class="exercise"><strong>Exercise 3.2:
</strong></span>Can a solution curve cross an equilibrium solution of a
differential equation?

  <!-- Thornley and Johnson -->

<span id="exr:unnamed-chunk-28" class="exercise"><strong>Exercise 3.3:
</strong></span>The Chanter equation of growth is the following: $$

with *μ*, *B*, and *D* are variables. What are the equilibrium solutions
to this model? What happens to the rate of growth (*W*′) as *t* grows
large? Why would this be a more realistic model of growth than the
saturating model ($\\displaystyle \\frac{dW}{dt} = \\mu \\cdot W(B-W)$)?

 

<span id="exr:unnamed-chunk-29" class="exercise"><strong>Exercise 3.4:
</strong></span>Red blood cells are formed from stem cells in the bone
marrow. The red blood cell density *r* satisfies an equation of the form

$$\\begin{equation}
\\frac{dr}{dt} = \\frac{br}{1+r^{n}} - c r,
\\end{equation}$$

where *n* &gt; 1 and *b* &gt; 1 and *c* &gt; 0. Find all the equilibrium
solutions to this differential equation.

  For all of the following problems:

  <!-- LW exercise 5, pg 36 -->

<span id="exr:unnamed-chunk-30" class="exercise"><strong>Exercise 3.5:
</strong></span>The immigration rate of bird species (species per time)
from a mainland to an offshore island is
*I*<sub>*m*</sub> ⋅ (1 − *S*/*P*), where *I*<sub>*m*</sub> is the
maximum immigration rate, *P* is the size of the source pool of species
on the mainland, and *S* is the number of species already occupying the
island. Further, the extinction rate is *E* ⋅ *S*/*P*, where *E* is the
maximum extinction rate. The growth rate of the number of species on the
island is the immigration rate minus the extinction rate, given by the
following differential equation:

$$ \\frac{dS}{dt} = I\_{m} \\left(1-\\frac{S}{P} \\right) - \\frac{ES}{P}. $$

 

<span id="exr:unnamed-chunk-31" class="exercise"><strong>Exercise 3.6:
</strong></span>A colony of bacteria growing in a nutrient-rich medium
deplete the nutrient as they grow. As a result, the nutrient
concentration *x*(*t*) is steadily decreasing. The equation describing
this decrease is the following:
$$ \\displaystyle \\frac{dx}{dt} = - \\mu \\frac{x (\\xi- x)}{\\kappa + x}, $$

where *μ*, *κ*, and *ξ* are all parameters greater than zero.

  <!-- Van den Berg page 19 -->

<span id="exr:unnamed-chunk-32" class="exercise"><strong>Exercise 3.7:
</strong></span>Organisms that live in a saline environment
biochemically maintain the amount of salt in their blood stream. An
equation that represents the level of *S* in the blood is the following:

$$ \\frac{dS}{dt} = I + p \\cdot (W - S) $$

Where the parameter *I* represents the active uptake of salt, *p* is the
permeability of the skin, and *W* is the salinity in the water.

  <!-- Based off LW pg 4 -->

<span id="exr:unnamed-chunk-33" class="exercise"><strong>Exercise 3.8:
</strong></span>A cell with radius *r* assimilates nutrients at a rate
proportional to its surface area, but uses nutrients proportional to its
volume, according to the following differentiatl equation:
$$ \\frac{dr}{dt} = k\_{1} 4 \\pi r^{2} - k\_{2} \\frac{4}{3} \\pi r^{3}. $$

 

<span id="exr:unnamed-chunk-34" class="exercise"><strong>Exercise 3.9:
</strong></span>A population grows according to the equation
$\\displaystyle \\frac{dP}{dt} = \\frac{aP}{1+abP} - dP$, where *a*, *b*
and *d* are parameters.

<!--chapter:end:05-phase.Rmd-->

[1] You may be used to working with *algebraic equations* (e.g. solve
*x*<sup>2</sup> − 4 = 0 for *x*). In that case the solution can be
points (for our example, *x* =  ± 2).
