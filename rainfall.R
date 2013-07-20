# Author: Will Beason
# NOT FUNCTIONAL
#
# Generates arrays of precipitation and evaporation.

GenPrecip <- function(res, projection = "Equirectangular") {
    theta.set <- EquirectangularY(res[2])
    degree.set <- abs(theta.set - pi/2) * 180 / pi
    
    precip.set <- c()
    for (i in 1:res[2]) {
        x <- degree.set[i]
        precip.set[i] <- 10 +
            290 * exp(-(x/9)^2) +
            90 * exp(-((abs(x)-40)/20)^2) -
            15 * exp(-((abs(x)-30)/8)^2)
    }
    
    return(precip.set)
}

GenEvap <- function(res, projection = "Equirectangular") {
    theta.set <- EquirectangularY(res[2])
    degree.set <- abs(theta.set - pi/2) * 180 / pi
    
    evap.set <- c()
    for (i in 1:res[2]) {
        x <- degree.set[i]
        evap.set[i] <- 135 * exp(-abs(x/47)^2.8) -
            30 * exp(-abs(x/5)^2)
    }
    
    return(evap.set)
}

