# Author: Will Beason
# BARELY FUNCTIONAL
#
# Calculates the temperature based on elevation and latitude.


source("projections.R", local = TRUE)

BaseTemp <- function(res, projection = "Equirectangular") {
    theta.set <- EquirectangularY(res[2])
    longitude.set <- abs(theta.set - pi/2)
    base.temp.set <- c()
    
    # Some constants - don't change these!
    thresh.1 <- 22 * pi / 180
    slope.1 <- 180 / (5.5 * pi)
    slope.2 <- 43
    adj.max.2 <- 43 * 22 * pi / 180
    
    for (i in 1:length(longitude.set)) {
        if (longitude.set[i] < thresh.1) {
            base.temp.set[i] <- 25 - longitude.set[i] * slope.1
        } else {
            base.temp.set[i] <- max(21 + adj.max.2 - 43 * longitude.set[i], -25)
        }
    }
    
    return(base.temp.set)
}

GetTemp <- function(height.array, sea.level, projection = "Equirectangular") {
    res <- dim(height.array)[2:1]
    
    tempY <- BaseTemp(res, projection)
    
    temp.array <- array(tempY, dim = res[c(2, 1)])
    
    is.land <- height.array > sea.level
    above.sea <- height.array - sea.level
    temp.array <- temp.array - (is.land * above.sea * 7)
    
    return(temp.array)
}
