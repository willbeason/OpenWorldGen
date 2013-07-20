# Author: Will Beason
# NOT FUNCTIONAL
#
# Differentiates between land and water pixels.

SeaLevel <- function(height.array, proj = "Equirectangular", waterprop = 0.708) {
    dim.x <- dim(height.array)[2]
    dim.y <- dim(height.array)[1]
    pix <- dim.x * dim.y
    if (proj == "Equirectangular") {
        y.area <- sin(seq(0, pi, length.out = dim.y))
        area.array <- array(y.area, dim = c(dim.y, dim.x))
    } else {
        stop("Other projections not implemented yet.")
    }
    
    land.total <- cbind(as.vector(height.array), as.vector(area.array))
    land.total <- land.total[order(land.total[, 1]),]
    area.vec <- land.total[, 2]
    height.vec <- land.total[, 1]
    
    total.area <- sum(land.total[, 2])
    sea.area <- waterprop * total.area
    
    for (i in 1:pix) {
        cur.level <- height.vec[i]
        
    }
    
    tol <- 2 * max(land.total[, 2])
    
    i <- as.integer(pix * waterprop)
    found = FALSE
    while (found == FALSE) {
        cur.sea.area <- sum(area.vec[seq(1, i, length.out = i)])
        if (abs(cur.sea.area - sea.area) <= tol) {
            found = TRUE
        } else if (cur.sea.area < sea.area) {
            i <- i + 1
        } else {
            i <- i - 1
        }
    }
    
    sea.level <- height.vec[i]
    
    return(sea.level)
}

