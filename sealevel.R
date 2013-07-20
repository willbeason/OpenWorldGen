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
    
    tol <- 1
    
    i <- as.integer(pix * waterprop)
    found = FALSE
    cur.sea.area <- sum(area.vec[seq(1, i, length.out = i)])
    while (found == FALSE) {
        if (abs(cur.sea.area - sea.area) <= tol) {
            found = TRUE
        } else if (cur.sea.area < sea.area) {
            cur.sea.area <- cur.sea.area + sum(area.vec[(i + 1):(i + tol)])
            i <- i + tol
        } else {
            cur.sea.area <- cur.sea.area + sum(area.vec[(i - tol + 1):i])
            i <- i - tol
        }
    }
    
    sea.level <- height.vec[i]
    
    return(sea.level)
}

