# Author: Will Beason
# NOT FUNCTIONAL
#
# Function which renders a color array

#setwd("C:/Users/Beason4251/Pictures/OpenWorldGen")
#setwd("~/GitHub/OpenWorldGen")

source("projections.R", local = TRUE)
source("elevation.R", local = TRUE)
source("sealevel.R", local = TRUE)
source("temperature.R", local = TRUE)

ChooseColor <- function(height.array, sea.level) {
    color.array <- test.height > sea.level
    mode(color.array) <- "integer"
    
    return(color.array)
}

Render <- function(color.array) {
    # color.array is an array of colors
    
    #bmp("test4.bmp", width = 1600, height = 800, units = "px")
    par(mar = c(0, 0, 0, 0) )
    #image(t(color.array), col = c("#0000FF", "#00FF00", "#AAAAAA"), xaxt = "n", yaxt = "n")
    image(t(color.array), col = terrain.colors(100), xaxt = "n", yaxt = "n")
    #dev.off()
}

test.proj <- GenProjection(c(400, 200))
test.height <- GenHeights(test.proj)
sea.level <- SeaLevel(test.height)
color.array <- ChooseColor(height.array, sea.level)
temperature.array <- GetTemp(test.height, sea.level)
Render(color.array)
Render(test.height)
Render(temperature.array)

just.above <- test.height * (test.height > sea.level)
Render(just.above)

par(mar = c(1,1,1,1))
contour(t(temperature.array))
