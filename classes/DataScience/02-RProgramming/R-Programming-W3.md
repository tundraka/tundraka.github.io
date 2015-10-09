#Loop functions
- Loop function: a lot of work in a very small space.
- They can use *anonymous function* functions without a name.
- They have the word apply somewhere
 - `lapply`: loop over a list of objects, and apply a function to every
   element, it always returns a list.
 - `sapply`: same as `lapply`, but simplify the result
 - `apply`: apply a function over the margins of an array
 - `tapply`: apply a function over subsets of a vector
 - `mapply`: multivariate version of `lapply`
The function `split` is also used in conjuction with `lapply`. Splits objects
into subpieces.

##lapply
The actual looping is done in C code. It takes three arguments
1. A list, if not a list it'll coerced into a list (`as.list`). if cannot be
   coercerd, we'll get an error.
2. A function, of the name of the function.
3. Other arguments `...` that go to the function that will be executed.

In the following example we'll apply the function `mean` to the list. It will
loop over the elements in the list `x` and apply the function `mean` to each
element in the list. It will return a list with the mean of each element `a` in `b`
of the original `x` list.
```R
x <- list(a=1:10, b=rnorm(20))
lapply(x, mean)
# Will return a list with the mean of a and b
```
In the following example, we are defining an vector and applying it to the
function `runif`. In this case we are applying `runif(1)`, `runif(2)`, and so
on and returning a vector wit the result of `runif` in it, which is a vector
of the size of the param `x` with random numbers.

Also notice how we are passing params to the runif function, `min`, `max`.
```R
x <- 1:5
lapply(x, runif, min=0, max=10)
```

##sapply
Is a variant of `lapply`, it simplifies the result if possible. `lapply` always
returnsa list, for example the `mean` example above, return a list with 2 elements
`a` and `b`, each being a vector of 1 element. Other considerations are:
- If the result is a list where every element is length 1, then a vector is
  returned.
- If the resuls is a list where every element is a vector of the same length
  (>1) then a matrix is returned.
- If not able to figure out, a list is returned.

##apply
- is used to evaluate a function over the margins of an array.
- mostly used to apply a functon to the rows or columns of a matrix.
- *Review*: can be used with general arrays, eg. avg of an array of matrices.
- not faster than a `for` loop, but saves space.

It accepts the following parameter.
- an array
- `MARGIN` an integer vector which indicates which margins should be "retained"
- extra params `...`

About the `MARGIN` param. In a matrix of (x, y) dimension where x are the rows and
y are the columns. We can express the dimension saying that x is margin 1 and
y would be margin 2. When we execute `apply(x, 1, function)` we are saying
apply the function `function` to the columns of matrix x. See example.
```R
x <- matrix(1:6, 2, 3) # Create a matric of 2 x 3
y <- apply(x, 1, mean) # apply mean to the rows of matrix x
z <- apply(x, 2, mean) # apply mean to the columns of matrix x

y # will return a vector of size 2 like the rows of matrix x
z # will return a vector of size 3 like the columns of matrix x
```

There are functions that are part of R that provide the same functionality, for
example:
- `rowSums` = apply(x, 1, sum)
- `rowMean` = apply(x, 1, mean)
- `colSums` = apply(x, 2, sum)
- `colMean` = apply(x, 2, mean)
This function are *much faster*, but only noticeable with big matrices.

##mapply
Is a multivariate apply, which applies a function un parallel over a set of
arguments. The accepted params are:

##tapply
Apply a function over a subset of a vector. The list of parameters is:
- a vector
- `INDEX`: Another vector of the same length.
- `FUN`: the function to apply.
- `...` other arguments for `FUN`
- simplify: T default, similar to `sapply`

##split

##with
Interesting use of `with` with the `*apply` functions.
```R
tapply(someSet$field1 someSet$field2, mean)
with(someSet, tapply(field1, fiels2, mean))
```

#Debugging Tools

##Diagnosing the problem
- `message`: a generi notification/diagnostic, execution of the function
  continues, this sounds like a `log.info`
- `warning`: let the function execut and then display the warning, indicates
  that there's something wrong but not fatal. The warning appear when the
function returns.
- `error`: A fatal problem has occured, execution of the function stops by the
  `stop` function.
- `condition`: a generic concept indicating that something unexpected can
  occur, programmers can create their own `condition`s. This is like
a precondition or an asserts (?).

For example a `warn` message, notice that it's displayed after the function
finishes.

```R
log(-1)
#with the result.
[1] NaN
Warning message:
In log(-1) : NaNs produced
```

`invisible` prevents autoprinting. For example the following two functions
will return the same object, but one of them won't print the value of the
returned value because it's using `invisible`.

```R
x <- function(p) p
y <- function(p) invisible(p)

x(2) # aside from returning 2 will print the 2
y(2) # will return 2 but won't print it.
```

One thing to notice in the following example is that the `print` function will
return the string that it prints, notice how we also used the function
`invisible` to avoid this.

```R
x <- function(p) {
    print(cat('function executed ', p)) #bad example.
    invisible(p)
}
```

##Basic Tools
These are good tools, but in general we can debug wihtout using them, here
there are to know about them. They allow you to peak in your code, instead of
having print statements in the code.
- `traceback`: prints the call stack after the error occurs. Does nothign if
  nothing err's. Will display a stack trace with all the function called in
before getting to an error state.
- `debug`: flags a function for debug mode. everything you execute that
  function, it'll suspend the execution of the function at the first line.
- `browse`: suspends the execution of the function wherever it's called and
  then sets the function in `debug` mode.
- `trace`: inserts debugging code into a function without editing the function.
  Useful when debugging someone else code.
- `recover`: related to `trace`, this is an error handler, allows you to modify the
  error behavior, so you can `browse` the function call stack. The normal
behavior is to get an error, function stops and then we get to the console prompt.
This function allows you to change that.

```R
lm(y - x) # this will cause an error
traceback() # will print the functions called.

debug(lm)
lm(y - x)
#prints the lm function body
Browser[2]> # this is the browser console.

options(error = recover)
# error happens we get a menu to see what we'll do with the error.
```

Debugging tools are not a substitue for thinking.
