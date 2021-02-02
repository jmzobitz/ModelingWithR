

















1 Welcome
=========

2 Creating this from Bookdown to Github
=======================================

I stumbled on how to do this by going to this
[website](https://jules32.github.io/bookdown-tutorial/) and built this
out from here. I am glad that I will be able to work on this.

<!--chapter:end:index.Rmd-->

(PART) Models with Differential Equations
=========================================

3 Models of rates with data
===========================

3.1 What is the book about?
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

3.2 Modeling in context: the spread of a disease
------------------------------------------------

To see what the first steps would be, consider the data in Figure
<a href="#fig:sierra-leone">3.1</a>, which come from an [Ebola
outbreak](https://www.cdc.gov/vhf/ebola/history/2014-2016-outbreak/index.html)
in Sierra Leone in 2014.

<img src="ModelingWithR_files/figure-markdown_strict/sierra-leone-1.png" alt="An Ebola outbreak in Sierra Leone"  />
<p class="caption">
Figure 3.1: An Ebola outbreak in Sierra Leone
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

### 3.2.1 Model 1: Infection rate proportional to number infected.

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

### 3.2.2 Model 2: Infection rate proportional to number NOT infected.

In this description notice how we are talking about people who are sick
(which we have denoted as *I*) and people who are *not* sick. This looks
like we might need to introduce another variable for the \`\`not sick’’
people, which we will call *S*, or susceptible. So the differential
equation we would write down would be:

$$

We are still using the parameter *k* as with the previous model. Also
note we introduced the second variable *S* is in Equation (3.1). Because
we have introduced another variable *S* we should also include a
differential equation for how *S* changes as well. One way that we can
do this is by considering our entire population as consisting of two
groups of people: *S* and *I*. Infection brings someone over from *S* to
*I*, which we have in this diagram:

![](ModelingWithR_files/figure-markdown_strict/unnamed-chunk-3-1.png)

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

### 3.2.3 Model 3: Infection rate proportional to infected meeting not infected.

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

![](ModelingWithR_files/figure-markdown_strict/logistic-1.png)

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

3.3 The qualitative nature of solution curves
---------------------------------------------

So far we have primarily been focused on the qualitative understanding
of the different models. One way we can look at how these different
models work together is by plotting $\\displaystyle \\frac{dI}{dt}$
versus *I*. I know we have the parameters *k* and *N* to specify, but
let’s just set them to be *k* = 1 and *N* = 10 respectively. Plots of
these functions are shown in Figure <a href="#fig:threeRates">3.2</a>.

<img src="ModelingWithR_files/figure-markdown_strict/threeRates-1.png" alt="Comparing rates of change for three models"  />
<p class="caption">
Figure 3.2: Comparing rates of change for three models
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

3.4 Simulating a differential equation
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

<img src="ModelingWithR_files/figure-markdown_strict/threeSoln-1.png" alt="Three models compared"  />
<p class="caption">
Figure 3.3: Three models compared
</p>

In Figure <a href="#fig:threeSoln">3.3</a>, I plot these solutions over
the course of several days, using *k* = 0.03 and *N* = 4000 and
*I*<sub>0</sub> = 5. Notice how Model 1 increases quickly - it actually
grows without bound off the chart! Model 2 and Model 3 have saturating
behavior, but it looks like Model 3 might be the one that actually
captures the trend of the data. Models 2 and 3 are more commonly known
as the **saturating** and **logistic** models respectively.

3.5 Which model is best?
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

<span id="exr:unnamed-chunk-4" class="exercise"><strong>Exercise 3.1:
</strong></span>Solutions to an outbreak model of the flu are the
following: $$

where *t* is in days. Make a plot of both of these models for
0 ≤ *t* ≤ 100. How would you describe the growth of the outbreak as *t*
increases? How many people will be infected overall? Finally,evaluate
lim<sub>*t* → ∞</sub>*I*(*t*). How do these results compare to values
found on your graph?

 

<span id="exr:unnamed-chunk-5" class="exercise"><strong>Exercise 3.2:
</strong></span>The general solution for the saturating and the logistic
models are: $$ where *I*<sub>0</sub> is the initial number of people
infected and *N* is the overall population size. Using the functions
from the previous exercise, for both models, what are *N* and
*I*<sub>0</sub>?

 

<span id="exr:unnamed-chunk-6" class="exercise"><strong>Exercise 3.3:
</strong></span>The general solution for the saturating and the logistic
models are: $$ where *I*<sub>0</sub> is the initial number of people
infected and *N* is the overall population size. For both models
carefully evaluate the limits to show
lim<sub>*t* → ∞</sub>*I*(*t*) = *N*. How do these compare to the
steady-state values you found for Models 2 and 3 of the outbreak data?

 

<img src="ModelingWithR_files/figure-markdown_strict/liberia-1.png" alt="An Ebola outbreak in Liberia in 2014"  />
<p class="caption">
Figure 3.4: An Ebola outbreak in Liberia in 2014
</p>

 

<span id="exr:unnamed-chunk-7" class="exercise"><strong>Exercise 3.4:
</strong></span>Figure <a href="#fig:liberia">3.4</a> shows the Ebola
outbreak for the country of Liberia in 2014. If we were to apply the
logistic model based on this graphic what would be your estimate for
*N*?

  <!-- Sethi model for advertising -->

<span id="exr:unnamed-chunk-8" class="exercise"><strong>Exercise 3.5:
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

 

<span id="exr:unnamed-chunk-9" class="exercise"><strong>Exercise 3.6:
</strong></span>A more general form of the advertising model is the
following:
$$\\frac{dS}{dt} = r\\sqrt{1-S}-S, $$
where *S* is the product’s share of the market (scaled between 0 and 1).
The parameter *r* is related to the effectiveness of the advertising
(between 0 and 1). Solve this equation for the steady state value (where
$\\frac{dS}{dt}=0$). Make a plot of the steady state value as a function
of *r*, where 0 ≤ *r* ≤ 1. What can you conclude about the steady state
value as the effectiveness of the advertising increases?

 

<span id="exr:unnamed-chunk-10" class="exercise"><strong>Exercise 3.7:
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

 

<span id="exr:unnamed-chunk-11" class="exercise"><strong>Exercise 3.8:
</strong></span>A model for the outbreak of a cold virus assumes that
the rate people get infected is proportional to infected people
contacting susceptible people, as in the logistic model 3. However
people who are infected can also recover and become susceptible again
with rate *α*. Construct a diagram similar Model 3 for this scenario and
also write down the system of differential equations.

 

<span id="exr:unnamed-chunk-12" class="exercise"><strong>Exercise 3.9:
</strong></span>A model for the outbreak of the flu assumes that the
rate people get infected is proportional to infected people contacting
susceptible people, as in Model 3. However people also account for
recovering from the flu, denoted with the variable *R*. Assume that the
rate of recovery is proportional to the number of infected people with
parameter *β*. Construct a diagram like Model 3 for this scenario, and
also write down the system of differential equations.

  <!-- Van den Berg page 19 -->

<span id="exr:unnamed-chunk-13" class="exercise"><strong>Exercise 3.10:
</strong></span>Organisms that live in a saline environment
biochemically maintain the amount of salt in their blood stream. An
equation that represents the level of *S* in the blood is the following:

$$\\frac{dS}{dt} = I + p \\cdot (W - S), $$

where the parameter *I* represents the active uptake of salt, *p* is the
permeability of the skin, and *W* is the salinity in the water. What is
that value of *S* at *steady state*, or when
$\\displaystyle \\frac{dS}{dt} = 0$?

 

<span id="exr:unnamed-chunk-14" class="exercise"><strong>Exercise 3.11:
</strong></span>Use your steady state solution from the last exercise to
determine what parameters (*I*, *p*, or *W*) cause the steady state
value *S* to increase?

 

<!-- From LW -->

<span id="exr:unnamed-chunk-15" class="exercise"><strong>Exercise 3.12:
</strong></span>The immigration rate of bird species (species per time)
from a mainland to an offshore island is
*I*<sub>*m*</sub> ⋅ (1 − *S*/*P*), where *I*<sub>*m*</sub> is the
maximum immigration rate, *P* is the size of the source pool of species
on the mainland, and *S* is the number of species already occupying the
island. Further, the extinction rate is *E* ⋅ *S*/*P*, where *E* is the
maximum extinction rate. The growth rate of the number of species on the
island is the immigration rate minus the extinction rate.

 

<span id="exr:unnamed-chunk-16" class="exercise"><strong>Exercise 3.13:
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

[1] You may be used to working with *algebraic equations* (e.g. solve
*x*<sup>2</sup> − 4 = 0 for *x*). In that case the solution can be
points (for our example, *x* =  ± 2).
