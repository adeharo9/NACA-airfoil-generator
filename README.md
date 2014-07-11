#NACA Airfoil Generator
=
**NACA Airfoil Generator of NACA 4 Digit Series, 5 Digit Series and 6 Series** made with **MATLAB 2012b** for **MATLAB**

For some examples of results, please visit [Examples](https://github.com/adeharo9/NACA-Airfoil-Generator/tree/master/Examples) folder.

This function generates a set of points containing the coordinates of a NACA airfoil from the **NACA 4 Digit Series, NACA 5 Digit Series and NACA 6 Series** given its number and, as additional features, the chord, the number of points to be calculated, spacing type (between linear and cosine spacing), opened or closed trailing edge and the angle of attack of the airfoil.  
It also plots the airfoil for further comprovation if it is the required one by the user.

##INPUT DATA
=
	n --> NACA number (4, 5 or 6 digits)

##OPTIONAL INPUT DATA
=
	c --> Chord of airfoil (m) (1 m default)  
	s --> Number of points of airfoil (1000 default)  
	cs --> Linear or cosine spacing (0 or 1 respectively) (1 default)  
	cte --> Opened or closed trailing edge (0 or 1 respectively) (0 default)  
	alpha --> Angle of attack (º) (0º default)  

##OUTPUT DATA
=
	x_e --> Extrados x coordinate of airfoil vector (m)  
	x_i --> Intrados x coordinate of airfoil vector (m)  
	y_e --> Extrados y coordinate of airfoil vector (m)  
	y_i --> Intrados y coordinate of airfoil vector (m)
