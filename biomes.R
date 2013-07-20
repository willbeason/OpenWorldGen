# Author: Will Beason
# NOT FUNCTIONAL
#
# Generates biomes for each pixel based on temperature and precipitation

GenBiomes(temperature.array, height.array, sea.level,
          precipitation.array, evaporation.array) {
    
    x.dim <- dim(temperature.array)[2]
    y.dim <- dim(temperature.array)[1]
    
    climate.array <- array(0, dim=dim(temperature.array))
    
    for (y in 1:y.dim) {
        for (x in 1:x.dim) {
            if (height.array[y, x] > sea.level) {
                if (temperature.array[y, x] > 18) {
                    climate.array[y, x] <- 1
                } else {
                    climate.array[y, x] <- 2
                }
            }
        }
    }
    
    return(climate.array)
}

