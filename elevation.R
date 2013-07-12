# Author: Will Beason
# NOT FUNCTIONAL
#
# Functions which genereate noise and apply it to an array of coordinates.


# projections.R is not required for this to run, just make testing easier
source("projections.R", local = TRUE)

test.proj <- GenProjection(c(200, 100), radius = 5000)

GetHeight <- function(pos, noise.set, roughness, depth) {
    # Given a position and the surrounding noise, get the height.
    # Uses linear interpolation
    
    cor.1 <- (-1 + floor(pos/
                             max.feature.size)) %% noise.size + 1
    cor.2 <- cor.1 %% noise.size + 1
    x.n <- c(cor.1[1], cor.2[1])
    y.n <- c(cor.1[2], cor.2[2])
    z.n <- c(cor.1[3], cor.2[3])
    
    surr.noise <- noise.set[x.n, y.n, z.n]
    rel.pos <- (pos / max.feature.size) %% 1
    
    x.2 <- rel.pos[1]
    x.1 <- 1 - x.1
    y.2 <- rel.pos[2]
    y.1 <- 1 - y.1
    z.2 <- rel.pos[3]
    z.1 <- 1 - z.1
    
    xy.11 <- x.1 * y.1
    xy.12 <- x.1 * y.2
    xy.21 <- x.2 * y.1
    xy.22 <- x.2 * y.2
    
    x111 <- surr.noise[1, 1, 1] * xy.11 * z.1
    x112 <- surr.noise[1, 1, 2] * xy.11 * z.2
    x121 <- surr.noise[1, 2, 1] * xy.12 * z.1
    x122 <- surr.noise[1, 2, 2] * xy.12 * z.2
    x211 <- surr.noise[2, 1, 1] * xy.21 * z.1
    x212 <- surr.noise[2, 1, 2] * xy.21 * z.2
    x221 <- surr.noise[2, 2, 1] * xy.22 * z.1
    x222 <- surr.noise[2, 2, 2] * xy.22 * z.2
    altitude <- x111 + x112 + x121 + x122 + x211 + x212 + x221 + x222
    
    return(altitude)
}

GenHeights <- function(pos.array, noise = "Perlin", max.feature.size = 5000,
                       roughness = 0.1, noise.size = 10, fractal = TRUE,
                       depth = 5) {
    # pos.array is the position array created by GenProjection.
    # noise currently only accepts "Perlin".
    # max.feature.size is untested and may have unexpected effects.
    # roughness is untested and may have unexpected effects.
    # noise.size tells the program how large the noise cube is.
    # fractal is currently ignored, but FALSE may be implemented later.
    
    # I'm currently using a scaling factor of 3 for converting from random
    # numbers to heights. May add an option later.
    
    noise.set <- array(3*rnorm(noise.size^3), dim=rep(noise.size, 3))
    the.dim <- dim(pos.array)[1:2]
    altitude.array <- array(integer(prod(the.dim)), dim=the.dim)
    
    for (y in 1:dim(pos.array)[1]) {
        for (x in 1:dim(pos.array)[2]) {
            altitude.array[y, x] <- GetHeight(pos.array[y, x, ], noise.set,
                                              roughness, depth)
        }
    }
    return(altitude.array)
}