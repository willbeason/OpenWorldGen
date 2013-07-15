OpenWorldGen
============

An R program that generates projections of randomly-generated planets. The user can specify various attributes of the world in advance such as average temperature, ocean coverage, and roughness. Runs a climate simulation to calculate the distribution of biomes on the planet. Returns an image of specified dimensions, format, and projection.

Notice:
The code I'm using is currently written in Python, but I'm translating it into R.


These are the five things to be completed before I'll call this 0.1.0. When I release 0.1.0, it will be possible to render a world with a single command.

1. Projections
--------------
Equirectangular and all cylindric equal-area projections are implemented. The file projections.r contains the functions used to map x,y coordinates in pixels to locations in 3D space.

Currently, the units of the 3D coordinates are in km. I'm doing this to make scaling easy and later possibly allow for calculations based on the planet's mass, rotation speed, and size.

2. Elevation
------------
Uses 3D fractal Perlin noise to generate elevation.

3. Sea Level
------------
In progress. Allows the user to set the percent of the planet which is covered in water. For now, the program will naively set all water levels to be constant. Later on, will permit dry land below sea level and lakes above sea level based on climate simulations.

4. Climates
-----------
Once sea levels work, climates will be implemented. This project will use the Koppen Climate Classification system.

5. Rendering
------------
Within R, uses the image() command to translate a matrix of numbers into colors to display. Barely implemented.
