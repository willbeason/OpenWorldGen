# Author: Will Beason
# NOT FUNCTIONAL
#
# Function which renders a color array

setwd("C:/Users/Beason4251/Pictures/OpenWorldGen")
setwd("~/GitHub/OpenWorldGen")

source("projections.R", local = TRUE)
source("elevation.R", local = TRUE)
source("sealevel.R", local = TRUE)
source("temperature.R", local = TRUE)

test.proj <- GenProjection(c(1600, 800))
test.height <- GenHeights(test.proj)
sea.level <- SeaLevel(test.height)
color.array <- ChooseColor(height.array, sea.level)
temperature.array <- GetTemp(test.height, sea.level)
Render(color.array)

ChooseColor <- function(height.array, sea.level) {
    color.array <- test.height > sea.level
    mode(color.array) <- "integer"
    
    return(color.array)
}

Render <- function(color.array) {
    # color.array is an array of colors
    
    bmp("test3.bmp", width = 800, height = 400, units = "px")
    par(mar = c(0, 0, 0, 0) )
    image(t(color.array), col = c("#0000FF", "#00FF00", "#AAAAAA"), xaxt = "n", yaxt = "n")
    # image(t(color.array), col = heat.colors(100), xaxt = "n", yaxt = "n")
    dev.off()
}