# Author: Will Beason
# NOT FUNCTIONAL
#
# Function which render

source("projections.R", local = TRUE)
source("elevation.R", local = TRUE)



Render <- function(color.array) {
    # color.array is an array of colors
    
    bmp("test.bmp", width = 800, height = 400, units = "px")
    par(mar = c(0, 0, 0, 0) )
    t.1 <- GenProjection(c(800, 400))
    t.2 <- as.matrix(GenHeights(t.1, max.feature.size = 2000, roughness = 0.2))
    image(t(t.2), col = c("#0000FF", "#0000FF", "#00FF00"), xaxt = "n", yaxt = "n")
    dev.off()
}