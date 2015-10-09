## These 2 function will work together to calculate the inverse of a
## matrix and cache is results
## The function makeCacheMatrix will take a matrix and create a matrix
## "object" that will allow operations over it.
## The function cacheSolve will cache the inverse of a matrix and store
## in the object provided by makeCacheMatrix, when a inverse hasn't been
## calculated, then cacheSolve will do it and store the result in the 
## matrix "object".
##
## Example:
## x <- matrix(c(4, 2, 7, 6), 2, 2)
## y <- matrix(c(3, 3.2, 3.5, 3.6), 2, 2)
## xo <- makeCacheMatrix(x)
## xo$get() # the matrix
## xo$getInverse() # NULL
## cacheSolve(xo)
## xo$get() # the matrix
## xo$getInverse() # the inverse
## xo$set(y) # assign a new matrix.
## xo$get() # the new matrix
## xo$getInverse() # NULL
## cacheSolve(xo)
## xo$get() # the new matrix
## xo$getInverse() # the new inverse
## xo$getInverse() # the cached inverse

## Will create an "object" that contain the following function
##
## set(matrix): will set a new matrix.
## get(): will return the specified matrix.
## getInverse(): will return the invese of the matrix.
## setInverse(matrix): will set the inverse of the matrix.
##
## The method get Inverse will return the last inverse calculated, if the
## matrix changes by calling the set method the method getInverse will
## return NULL, indicating that a new inverse needs to be calculated.

makeCacheMatrix <- function(x = matrix()) {
    # WIll cache the inverse of this matrix
    xInverse <- NULL

    # Function definition
    set <- function(newMatrix) {
        xInverse <<- NULL
        x <<- newMatrix
    }

    get <- function() x

    getInverse <- function() xInverse

    setInverse <- function(inverse) {
        xInverse <<- inverse
    }


    list(set = set,
         get = get, 
         getInverse = getInverse,
         setInverse = setInverse
         )
}


## Will cache the specified "object" matrix and make sure that we always
## access the latest cached matrix inverse. Whenno inverse cache exists
## a new one will be calculated, cached and returned.

cacheSolve <- function(x, ...) {
    # First we ask for the inverse. Initially, there's no inverse, the
    # same will happen when a new matix has been set.
    inverse <- x$getInverse()

    # If we have an inverse, we return that.
    if (!is.null(inverse)) {
        return(inverse)
    }
    
    # No inverse calculated, we calculate and cache the result.
    inverse <- solve(x$get(), ...)
    x$setInverse(inverse)

    ## return the inverse
    inverse
}
