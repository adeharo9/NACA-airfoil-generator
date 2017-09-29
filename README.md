# NACA Airfoil Generator
**NACA Airfoil Generator of NACA 4 Digit Series, 5 Digit Series and 6 Series** made with **MATLAB 2012b** for **MATLAB**

For some examples of results, please visit [Examples](https://github.com/adeharo9/NACA-Airfoil-Generator/tree/master/Examples) folder.

## About the program

This function generates a set of points containing the coordinates of a NACA airfoil from the **NACA 4 Digit Series, NACA 5 Digit Series and NACA 6 Series** given its number and, as additional features, the chord, the number of points to be calculated, spacing type (between linear and cosine spacing), opened or closed trailing edge and the angle of attack of the airfoil.  
It also plots the airfoil for further comprovation if it is the required one by the user.

### INPUT DATA
	n --> NACA number (4, 5 or 6 digits)

### OPTIONAL INPUT DATA
	c --> Chord of airfoil (m) (1 m default)  
	s --> Number of points of airfoil (1000 default)  
	cs --> Linear or cosine spacing (0 or 1 respectively) (1 default)  
	cte --> Opened or closed trailing edge (0 or 1 respectively) (0 default)  
	alpha --> Angle of attack (º) (0º default)  

### OUTPUT DATA
	x_e --> Extrados x coordinate of airfoil vector (m)  
	x_i --> Intrados x coordinate of airfoil vector (m)  
	y_e --> Extrados y coordinate of airfoil vector (m)  
	y_i --> Intrados y coordinate of airfoil vector (m)

## Bibliography
1. Ladson, Charles L.; and Brooks, Cuyler W., Jr.: *Development of a Computer Program To Obtain Ordinates for NACA 6- and 6A-Series Airfoils*. NASA TM X-3069, 1974.
2. Ladson, Charles L.; and Brooks, Cuyler W., Jr.: *Development of a Computer Program To Obtain Ordinates for NACA 4-Digit, 4-Digit Modified, 5-Digit, and 16-Series Airfoils*. NASA TM-3284, 1975.
3. Ladson, Charles L.; Brooks, Cuyler W., Jr.; and Hill, Acquilla S.: *Computer Program To Obtain Ordinates for NACA Airfoils*. NASA TM X-4741, 1996.
4. Abbott, Ira H.; and Von Doenhoff, Albert E.: *Theory of Wing Sections*. Dover Publ., Inc., 1959.
5. Abbott, Ira H.; Von Doenhoff, Albert E.; and Stivers, Louis S., Jr.: *Summary of Airfoil Data*. NACA Rep. 824, 1945.
