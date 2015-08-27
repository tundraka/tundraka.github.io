#Simulation and Profiling
- Description function
 - `str`
 - `summary`
 - `head`
- Random number from distibutions
 - `rnorm`
 - `rpois`
 - `rbinom`
 - etc.
- Built in distributions
 - Normal
 - Binomial
 - Exponential
 - Gamma
 - Poisson
- `set.seed`
- `sample`

##The `str` function
- The most important function in all R
- Compactly displays the structure of an R object.
- Simple diagnostic function, very versatile.
- Answers the question of what's in here.
- Three function to provide information: `str`, `head`, `summary`

```R
> str(lm)
function (formula, data, subset, weights, na.action, method = "qr", model = TRUE, 
    x = FALSE, y = FALSE, qr = TRUE, singular.ok = TRUE, contrasts = NULL, 
    offset, ...)  

> x <- rnorm(100, 2, 4)
> summary(x)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 -9.541  -1.674   1.762   1.085   3.596   9.860 
> str(x)
# in numeric vector, 100 elements...
 num [1:100] -7.197 -1.876 -3.47 9.506 0.655 ...

# Try this when you get some dataset.
s <- split(dataSet, dataSet$Field)
```

##Simulation

###Generating random numbers
Functions that generates random numbers.
- `rnorm` generated normal random numbers given a mean and a std dev.
- `dnorm` 
- `pnorm` cumulative distribution functions for a Normal distribution.
- `rpois` generates poison random numbers, given a rate.

Probability distribution function usually have 4 functions associated with
them. The funtions are prefixed with:
- `p` for cumulative distribution
- `r` random number generator
- `d` density
- `q` quantile function.

if Φ is the cumulative distribution function for a std Normal distribution,
then pnorm(q) = Φ(q) and qnorm(p) = Φ^-1(p)

When simulating random numbers for any distribution for any purpose, it's
important to set the number seed with `set.seed` which ensures reproducibility.
Always set the random number seed when conducting a simulation.

```R
set.seed(1)
x <- rnorm(5)
y <- rnorm(5)
# x and y are different
set.seed(1)
z <- rnorm(5)
# x and z are the same.
```

###Simulating a linear model
Sometimes we have a model and want to generate random numbers based on that
model. Suppose that we want to simulate from the following linear model.

y = B0 + B1x + e

where e ~N(0, 2^2). Assume x ~N(0, 1^2), B0 = 0.5, B1 = 2.

```R
set.seed(20)
x <- rnorm(100)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
summary(y)
plot(x, y)
```

What is x is binary?
```R
set.seed(20)
x <- rbinom(100, 1, 0.5)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
summary(y)
plot(x, y)
```

Simulate from a Poisson model.

Y ~ Poisson(mu)
log mu = B0 + B1x

And B0=0.5, B1=0.3
```R
set.seed(20)
x <- rnorm(100)
log.mu <- 0.5 + 0.3 * x
y <- rpois(100, exp(log.mu))
summary(y)
plot(x, y)
```

###Random sampling
`sample` function allows to draws randomly from a specified set of (scalar)
objects allowing you to sample from arbitrary distributions.
```R
set.seed(1)
sample(1:10, 4) # 4 random entries from 1-10
sample(1:10, 4) # different set
sample(letters, 5) # letters a-z
sample(1:10) # gives me a permutation of those.
sample(1:10) # gives me a another permutation
sample(1:10, replace = T) # repeated number of 1-10
```

##Summary
- Draw random samples from probability distributions  with r\* functions.
- Std distributions are build in: Normal, Poison, Binomial, Exponential, Gamma,
  etc.
- The `sample` function can be use to draw random samples from arbitrary
  vectors.
- Setting the random number generator seed is important for reproducibility.
