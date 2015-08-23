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
