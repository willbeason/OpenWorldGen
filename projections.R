#Author: beason4251
# NOT FUNCTIONAL YET

# Functions which return the coordinate in 3D space which corresponds with a
# given pixel for their respective map projection.

# In general, these functions are for mapping the 3D noise onto the planet.
# More uses may become apparent later.

# These are some standard variables. Some projections require additional
#     variables, which will be specified inside the respective functions.
#
# x is measured from the left, in pixels.
# y is measured from the top, in pixels.
# res is a column vector which contains the dimensions of the image in x, y.
# radius is the radius of the planet, in kilometers.

GetSphericalXYZ <- function(theta, phi, radius = 6371) {
    # Maps theta and phi coordinates onto a sphere.
    # Default radius is that for Earth.
    
    px <- radius*sin(theta)*cos(phi)
    py <- radius*sin(theta)*sin(phi)
    pz <- radius*cos(theta)
    
    result <- c(px, py, pz)
    
    return(result)
}

GetEllipsoidXYZ <- function(theta, phi, radius.major = 6378,
                            radius.minor = 6356) {
    # Maps theta and phi onto an ellipsoid. For when a sphere simply isn't good
    # enough. Default radii are for Earth according to WGS 84 to the nearest km.
    
    radius <- radius.major*radius.minor /
        sqrt((radius.major * cos(theta))^2 + (radius.minor * sin(theta))^2)
    
    px <- radius*sin(theta)*cos(phi)
    py <- radius*sin(theta)*sin(phi)
    pz <- radius*cos(theta)
    
    result <- c(px, py, pz)
}

Equirectangular <- function(x, y, res) {
    # Best for mapping to a sphere in 3D. For this purpose, res[2] should be
    # twice res[1].
    
    theta <- (y/res[2])*pi
    phi <- (x/res[1])*2*pi
    
    result <- c(theta, phi)
    
    return(result)
}

CylindricEqualArea <- function(x, y, res) {
    # For equal area projections such as Gall-Peters and Hobo-Dyer
    
    y.adj <- (2 * y) / res[2] - 1
    
    if (abs(y.adj) > 1) {
        theta <- sign(y.adj)
    } else {
        theta <- acos(y.adj)
    }
    
    phi <- (x/res[1])*2*pi
    
    return(result)
}

GenProjection(res, projection = "Equirectangular", standard.parallel = 37.5) {
    # Returns an array consisting of the 3D coordinates that correspond to
    # each pixel.
    #
    # projection is which projection is being used to generate the image.
    # standard.parallel is used for cylindric equal area projection such as
    #     Gall-Peters and Hobo-Dyer.
    # For cylindric equal area projections, res[2] is ignored and replaced with
    # the appropriate value.

    
    cyl.eq.area <- c("Gall-Peters", "Hobo-Dyer")
    cyl.refs <- c(1/sqrt(2), cos(37.5*pi/180))
    
    if (projection == "Equirectangular") {
        TheProj <- Equirectangular
    } else if (projection %in% cyl.eq.area) {
        res[2] <- 
        TheProj <- CylindricEqualArea
        factor <- cyl.refs[projection == cyl.eq.area]
        res[2] <- res[1]/(factor^2 * pi)
    } else if (projection == "Cylindric Equal Area") {
        factor <- cos(standard.parallel*pi/180)
    }
    
    pos.matrix <- array(0, dim=c(res[2], res[1], 2))
    for (y in seq(0, res[2], length.out=res[2])) {
        thetaphi.row <- sapply(0:(res[1]-1), function(x) TheProj(x, y, res))
        
        
    }
    
}