# Author: Will Beason
# NOT FUNCTIONAL
#
# Functions which genereate noise and apply it to an array of coordinates.


# projections.R is not required for this to run, just make testing easier
source("projections.R", local = TRUE)

test.proj <- GenProjection(c(200, 100))

GenHeights <- function(pos.array, noise = "Perlin", max.feature.size = 5000,
                       roughness = 0.25, noise.size = 10, fractal = TRUE) {
    # pos.array is the position array created by GenProjection.
    # noise currently only accepts "Perlin".
    # max.feature.size is untested and may have unexpected effects.
    # roughness is untested and may have unexpected effects.
    # noise.size tells the program how large the noise cube is.
    # fractal is currently ignored, but FALSE may be implemented later.
    
    # I'm currently using a scaling factor of 3 for converting from random
    # numbers to heights. May add an option later.
    
    noise.set <- array(3*rnorm((noise.size + 1)^3), dim=rep(noise.size + 1, 3))
    
}