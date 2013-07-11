#Author: beason4251
# BARELY FUNCTIONAL

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

SphericalXYZ <- function(theta.set, phi.set, radius.set) {
    # Maps theta and phi coordinates onto a sphere.
    # Default radius is the average for Earth.
    x.max <- length(phi.set)
    y.max <- length(theta.set)
    
    theta.sin <- sin(theta.set)
    theta.cos <- cos(theta.set)
    phi.sin <- sin(phi.set)
    phi.cos <- cos(phi.set)
    
    px <- radius.set * outer(theta.sin, phi.cos)
    py <- radius.set * outer(theta.sin, phi.sin)
    pz.set <- theta.cos * radius.set
    pz <- rep_len(pz.set, y.max * x.max)
    
    pos.array <- array(c(px, py, pz), dim=c(y.max, x.max, 3))
    
    return(pos.array)
}

EquirectangularX <- function(x.max) {
    # Used for many projections, any where x is linearly mapped to phi
    # independent of y.
    inv.x.max <- 1 / x.max
    phi.set <- 0:(x.max - 1) * inv.x.max * 2 * pi
    
    return(phi.set)
}

EquirectangularY <- function(y.max) {
    # Specifically for equirectangular mappings.
    theta.set <- seq(0, pi, length.out = y.max)
    
    return(theta.set)
}

CylindricEqualAreaY <- function(y.max) {
    # For equal area projections such as Gall-Peters and Hobo-Dyer.
    y.set <- seq(y.max, 0, length.out = y.max)
    inv.y.max = 1 / y.max
    y.adj <- 2 * y.set * inv.y.max - 1
    
    theta.set <- vapply (y.adj, function(y) {
        if (abs(y) > 1) {
            theta <- sign(y)
        } else {
            theta <- acos(y)
        }
    }, double(1))
    
    return(theta.set)
}

GenProjection <- function(res, projection = "Equirectangular",
                          shape = "Spheroid", radius = 6371,
                          standard.parallel = 37.5) {
    # Returns a position array consisting of the 3D coordinates that correspond
    # with each pixel.
    #
    # projection is which projection is being used to generate the image.
    # shape is the shape of the planet. Currently only accepts "Spheroid".
    # radius is a number or 2-vector. A single number is used for a spherical
    # projection, and a 2-vector is used for ellipsoids and tori.
    # standard.parallel is used for cylindric equal area projection such as
    #     Gall-Peters and Hobo-Dyer.
    # For cylindric equal-area projections, res[2] is ignored and replaced with
    # the appropriate value.
    
    x.max <- res[1]
    y.max <- res[2]
    
    cyl.eq.area <- c("Lambert Cylindrical", "Behrmann", "Smyth", "Craster",
                     "Hobo-Dyer", "Gall-Peters", "Balthasart")
    
    if (shape == "Spheroid") {
        GetXYZ <- SphericalXYZ
        if (projection == "Equirectangular") {
            XProj <- EquirectangularX
            YProj <- EquirectangularY
        } else if (projection %in% cyl.eq.area) {
            XProj <- EquirectangularX
            YProj <- CylindricEqualAreaY
            cyl.refs <- c(0, 30, 37+1/15, 37.4, 37.5, 45, 50)
            factor <- cos(cyl.refs[projection == cyl.eq.area] * pi / 180)
            y.max <- x.max/(factor^2 * pi)
        } else if (projection == "Cylindric Equal Area") {
            factor <- cos(standard.parallel*pi/180)
            y.max <- x.max/(factor^2 * pi)
        }
    }
    
    phi.set <- XProj(x.max)
    theta.set <- YProj(y.max)
    
    if (length(radius) == 1) {
        radius.set <- rep_len(radius, y.max)
    } else if (shape == "Spheroid") {
        radius.prod <- prod(radius)
        radius.set <- vapply(theta.set, function(t)
            radius.prod/sqrt((radius[1] * cos(t))^2 + (radius[2] * sin(t))^2),
                             double(1))
    }
        
    
    pos.array <- SphericalXYZ(theta.set, phi.set, radius.set)
    
    return(pos.array)
}
