OpenWorldGen
============

A program that generates projections of randomly-generated planets. The user can specify various attributes of the world in advance such as average temperature, ocean coverage, and roughness. Runs a climate simulation to calculate the distribution of biomes on the planet. Returns an image of specified dimensions, format, and projection.

Notice:
The code I'm using is currently written in Python, but I'm translating it into R.

Climates
--------
This project will use the Koppen Climate Classification system. This is not implemented yet. See the Wikipedia page for details on how it works.

Projections
-----------
Equirectangular and all cylindric equal-area projections are implemented. The file projections.r contains the functions used to map x,y coordinates in pixels to locations in 3D space.

Currently, the units of the 3D coordinates are in km. I'm doing this to make scaling easy and later possibly allow for calculations based on the planet's mass, rotation speed, and size.

Elevation
---------
This is the next feature I will implement.
