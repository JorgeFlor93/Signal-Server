#### Model directory 
> ALGORITHM

Clase: **cost**<br>
Complejidad: MEDIA

Atributos:<br>

	- f Freq
	- TxH Height Tx
	- RxH Height Rx
	- d: Propagation ratio
	- mode (Urbano, Suburbano, rural)
Frecuencia 150 - 2000 MHz

Métodos:

	- COST231pathLoss(float f, float TxH, float RxH, float d, int mode)

Clase: **ecc33**<br>
Complejidad: MEDIA

Atributos:<br>

	- f Freq
	- TxH Height Tx
	- RxH Height Rx
	- d: Propagation ratio
	- mode (Urbano, Suburbano, rural)
Trabaja en GHz. Diferencia entre ciudades con grandes edificios(rascacielos) y ciudades medianas (Europeas).

Métodos:

	- ECC33pathLoss(float f, float TxH, float RxH, float d, int mode);

Clase: **egli**<br>
Complejidad: FACIL

Atributos:<br>

	- f Freq
	- TxH Height Tx
	- RxH Height Rx
	- d: Propagation ratio
	- mode (Urbano, Suburbano, rural)
Frecuencias bajas max 1GHz. No tiene en cuentra otro tipos de pérdidas subyacentes.

Métodos:

	- EgliPathLoss(float f, float h1, float h2, float d);


Clase: **ericsson**<br>
Complejidad: MEDIA

Atributos:<br>
- f Freq
- TxH Height Tx
- RxH Height Rx
- d: Propagation ratio
- mode (Urbano, Suburbano, rural)

Métodos:

	- EricssonpathLoss(float f, float TxH, float RxH, float d, int mode)

Clase: **fspl** (free space path loss)<br>
Complejidad: FACIL
Es un modelo muy simple que solamente tiene en cuenta distancia y frecuencia y no asume elevaciones en el terreno. Se puede mejorar. Se puede mejorar con la función knife edge diffraction (ked) que añade alturas de antenas y elevaciones.
Atributos:<br>

	- f Freq
	- d Propagation ratio
	- mode
Admite cualquier frecuencia y distancia

Métodos:
	
	- double FSPLpathLoss(float f, float d);


Clase: **hata**<br>
Complejidad: MEDIA
Se usa principalmente para entornos urbanos con edificios altos. El modelo asume que el tx es más alto que la altura media de los tejados. 150 to 1500 MHzz con altura mínima para la antena transmisora de 30m. Costhata model es una extensión de este modelo. 
Atributos:<br>

	- f Freq
	- TxH Height Tx
	- RxH Height Rx
	- d: Propagation ratio
	- mode (Urbano, Suburbano, rural)
	
Métodos:<br>

	- double HATApathLoss(float f, float h_B, float h_M, float d, int mode);

Clase: **itwom3.0**<br>
Complejidad: ALTA
Se trata de una corrección y mejora del Longley-Rice Model (ITM). Funciona en 2 modos: Area prediction mode, usa predicciones del terreno para el cálculo luego es mas ligero en la computación y ejecución. El segundo modo es point to point mode que recibe como entrada los puntos de elevaciones exactos entre transmisor y receptor.  ITWOM contiene cálculos más precisos sobre las zonas line of sight.

Atributos:

	- pol: 0-Horizontal, 1-Vertical, 2-Circular
	- radio_climate: 1-Equatorial, 2-Continental Subtropical, 3-Maritime Tropical, 4-Desert, 5-Continental Temperate, 6-Maritime Temperate, Over Land, 7-Maritime Temperate, Over Sea.
	- conf, rel: .01 to .99
	- elev[]: [num points - 1], [delta dist(meters)], [height(meters) point 1], ..., [height(meters) point n]
	- clutter_height  	25.2 meters for compatibility with ITU-R P.1546-2.
	- clutter_density 	1.0 for compatibility with ITU-R P.1546-2.
	- delta_h_diff		
	    - optional delta h for beyond line of sight. 90 m. average.
	    - setting to 0.0 will default to use of original internal
	    - use of delta-h for beyond line-of-sight range.
	- mode_var set to 12: or to 1 for FCC ILLR	
	- enc_ncc_clcref: clutter refractivity; 1000 N-units to match ITU-R P.1546-2
	- eno=eno_ns_surfref: atmospheric refractivity at sea level; 301 N-units nominal
	- errnum: 
	    - 0- No Error.
	    - 1- Warning: Some parameters are nearly out of range.
	    - Results should be used with caution.
	    - 2- Note: Default parameters have been substituted for
	    - impossible ones.
	    - 3- Warning: A combination of parameters is out of range.
	    - Results are probably invalid.
	    - Other-  Warning: Some parameters are out of range.
	    - Results are probably invalid.

Métodos:	

	-point_to_point_ITM
        -point_to_point

Clase: **los**<br>
Complejidad: FACIL
Line of Sight. Devuelve un si/no. Se extiende hasta los 100GHz.Utiliza datos del terreno y altura de las antenas.
Atributos:<br>
Métodos:<br>

	- PlotLOSPath
	- PlotPropPath
	- PlotLOSMap
	- PlotPropagation
	- PlotPath

Clase: **pel**<br>
Complejidad: FACIL

Atributos:

	- f Freq
	- TxH Height Tx
	- RxH Height Rx

Métodos:

	- PlaneEarthLoss(float d, float TxH, float RxH);

Clase: **soil**<br>
Complejidad: FACIL

Atributos:

	- f Freq
	- d Propagation ratio
	- t: Terrain permittivity: 1 - 15 (Bad to Good)

Métodos:

	- Eouble SoilPathLoss(float f, float d, float t);

Clase: **sui**<br>
Complejidad: MEDIA

Atributos:

	- f Freq
	- TxH Height Tx
	- RxH Height Rx
	- d: Propagation ratio
	- mode (Urbano, Suburbano, rural)<br>

Métodos:

	- SUIpathLoss(double f, double TxH, double RxH, double d, int mode);

