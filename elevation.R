# Author: Will Beason
# FUNCTIONAL ENOUGH
#
# Functions which genereate noise and apply it to an array of coordinates.
# Currently only uses Perlin Fractal noise.

GetHeight <- function(rel.pos, sur.noise, roughness, depth) {
    # Given a position and the surrounding noise, get the height.
    # Uses linear interpolation
    
    altitude <- 0
    
    for (i in 1:depth) {
        x.2 <- rel.pos[i, 1]
        x.1 <- 1 - x.2
        y.2 <- rel.pos[i, 2]
        y.1 <- 1 - y.2
        z.2 <- rel.pos[i, 3]
        z.1 <- 1 - z.2
        
        xy.11 <- x.1 * y.1
        xy.12 <- x.1 * y.2
        xy.21 <- x.2 * y.1
        xy.22 <- x.2 * y.2
        
        x111 <- sur.noise[i, 1] * xy.11 * z.1
        x112 <- sur.noise[i, 5] * xy.11 * z.2
        x121 <- sur.noise[i, 3] * xy.12 * z.1
        x122 <- sur.noise[i, 7] * xy.12 * z.2
        x211 <- sur.noise[i, 2] * xy.21 * z.1
        x212 <- sur.noise[i, 6] * xy.21 * z.2
        x221 <- sur.noise[i, 4] * xy.22 * z.1
        x222 <- sur.noise[i, 8] * xy.22 * z.2
        
        c.altitude <- x111 + x112 + x121 + x122 + x211 + x212 + x221 + x222
        d.altitude <- c.altitude * roughness ^ (i - 1)
        altitude <- altitude + d.altitude
    }
    
    return(altitude)
}

GenHeights <- function(pos.array, noise = "Perlin", max.feature.size = 3000,
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
    
    feature.size <- max.feature.size * roughness ^ (0:(depth-1))
    inv.feature.size <- 1 / feature.size
    
    noise.set <- array(3*rnorm(noise.size^3), dim=rep(noise.size, 3))
    the.dim <- dim(pos.array)[1:2]
    altitude.array <- array(integer(prod(the.dim)), dim=the.dim)
    
    for (y in 1:dim(pos.array)[1]) {
        print(y)
        for (x in 1:dim(pos.array)[2]) {
            pos <- pos.array[y, x, ]
            
            cor.1 <- (-1 + floor(outer(pos, inv.feature.size))) %% 
                noise.size + 1
            cor.2 <- cor.1 %% noise.size + 1
            x.n <- cbind(cor.1[1, ], cor.2[1, ])
            y.n <- cbind(cor.1[2, ], cor.2[2, ])
            z.n <- cbind(cor.1[3, ], cor.2[3, ])
            
            sur.noise <- array(double(depth * 8), dim=c(depth, 8))
            for (i in 1:depth) {
                sur.noise[i, ] <- c(noise.set[x.n[i, ], y.n[i, ], z.n[i, ]])
            }
            rel.pos <- outer(inv.feature.size, pos) %% 1
            
            altitude.array[y, x] <- GetHeight(rel.pos, sur.noise,
                                              roughness, depth)
        }
    }
    return(altitude.array)
}

