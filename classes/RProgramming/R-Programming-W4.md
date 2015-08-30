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

###Summary
- Draw random samples from probability distributions  with r\* functions.
- Std distributions are build in: Normal, Poison, Binomial, Exponential, Gamma,
  etc.
- The `sample` function can be use to draw random samples from arbitrary
  vectors.
- Setting the random number generator seed is important for reproducibility.

#Profiling

##Profiling R code
- The profiler can help you figure out why some R code is taking so long. And
  suggest strategies to fixing your code.
- Profiling is a systematic way to examine how much time is spent in different
  parts of the program 
- Profiling is better than guessing 
- Getting the biggest impact on speeding up code depends on knowing where the
  code spends most of the time. This cannot be done without performance
analysis and profiling.

> We should forget about small efficiencies, say about 97% of the time:
> premature optimization is the root of all evil. - Donald Knuth.

- Design first, optimization second
- Measure (collect data), don't guess

###Using `system.time`
- Measures the amount of time to evaluate an R expression, can accept blocks of
  code (`{}`)
- Computes the time in seconds. Error codition gets reported 
- Return an object of class `proc_time`
 - user time: time charged to the CPU for this expression
 - elapsed time: *wall clock* time
- Usually both times are very close
- Elapsed time can be greater than the user time if the computer spends a lot
  of time waiting.
- Elapsed time may be smaller than the user time if the machine has multiple
  cores, the basic R program doesn't use multiple cores
 - There are libraries however that are able to use multiple core, like the
   linear algebra libraries. 
 - Parallel processing with the `parallel` package.

```R
# Elapsed time is > than user time because the time spent in my program, in
# this case, just reading the content of the page is almost nothing. Most of the
# time is spent waiting for the content to be available.
system.time(readLines("http://www.jhsph.edu"))
#   user  system elapsed 
#  0.007   0.005   2.338 

# Elapsed time is < than user time. In this case, looks like the code is run
# in two different cores, making the elapsed time less because it's the amount
# of time spent in each core.
hilbert <- function(n) {
    i <- 1:n
    1 / outer(i - 1, i, "+")
}
x <- hilbert(1000)
system.time(svd(x))

# Not in my mac
#   user  system elapsed 
#  3.957   0.031   4.101 

# Expression can be wrapped in {}
system.time({
    n <- 1000
    r <- numeric(n)
    for (i in 1:n) {
        x <- rnorm(n)
        r[i] <- mean(x)
    }
})

#   user  system elapsed 
#  0.128   0.004   0.132 
```

- handy function to profile blocks of code and see if they take a lot of time.
- `system.time` assumes that you know where to look

##Using `Rprof`
- R must be compiled with `Rprof` support
- starts the profiler in R
- `summaryRprof` takes the output from `Rprof` and summarizes it, `Rprof`
  output is not very readable.
- **Don't combine** `system.time` and `Rprof`
- If your code runs very quickly `Rprof` won't be very useful, but probably you
  won't need it.
- `Rprof` keeps track of the call stack and samples at certain intervals and
  keeps track of how much time is spent in each function.
- Samples at the rate of 0.02 by default.
- `summaryRprof` tabulates the output of `Rprof` and calcultes how much time is
  spent in each function.
- There are two methods for normalizing the data.
 - `by.total` divides the time spent in each function by the total run time
 - `by.self` first substracts out time spent in function above the call stack.
 - `by.self` tells you how much time is spent in a given function after taking
   out all the time spent in lower level functions.
- `sample.interval` polling time default 0.02
- `sampling.time` total amount of time that the expression run, similar to
  `system.time` function
- C or Fortran code is not profiled.
