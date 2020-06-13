#### Model directory 

Las especificaciones y los test que incorporan la aplicación ss definen las siguientes unidades para cada parámetro:

	-Frequency MHz
	-Distance km
	-Effective Radiated Power Watts
	-lat Tx Latitude decimal degrees -70/+70
	-lon Tx Longitude decimal degrees -180/+180
	-rla  Rx Latitude for PPA (decimal degrees) -70/+70
	-rlo  Rx Longitude for PPA (decimal degrees)
	-txh Tx Height (above ground) Meters
	-m Metric units of measurement, if -m set:
		altitudeLR /= METERS_PER_FOOT;	/* 10ft * 0.3 = 3.3m */
		max_range /= KM_PER_MILE;	/* 10 / 1.6 = 7.5 */
		altitude /= METERS_PER_FOOT;
		tx_site[0].alt /= METERS_PER_FOOT;	/* Feet to metres */
		tx_site[1].alt /= METERS_PER_FOOT;	/* Feet to metres */
		clutter /= METERS_PER_FOOT;	/* Feet to metres */

		WHERE

		#define DEG2RAD		1.74532925199e-02
		#define	EARTHRADIUS	20902230.97
		#define	METERS_PER_MILE 1609.344
		#define	METERS_PER_FOOT 0.3048
		#define	KM_PER_MILE	1.609344
		#define	FEET_PER_MILE	5280.0
		#define FOUR_THIRDS	1.3333333333333
	
> ALGORITHM

Clase: **COST231**<br>
Complejidad: MEDIA

Este modelo extensión de Hata model extiende la frecuencia de trabajo hasta 2000MHz. Para áreas urbanas con  GSM-1800.

	𝑃𝐿𝑑𝑏=46.33+33.9log𝑓−13.82log(h𝑏)−𝑎(h𝑚)+[44.9−6.55log(h𝑏)]log⁡(𝑑)
Atributos:<br>

	- f Freq
	- TxH Height Tx
	- RxH Height Rx
	- d: distance
	- mode (Urbano, Suburbano, rural)
Frecuencia 150 - 2000 MHz

Métodos:

	- COST231pathLoss(float f, float TxH, float RxH, float d, int mode)

Clase: **ecc33**<br>
Complejidad: MEDIA

Electronic Communication Committee (ECC). También se trata de una extrapolación del Okumura Hata model para ser usado para frecuencias superiores a 3GHz .
Atributos:<br>

	- f Freq
	- TxH Height Tx
	- RxH Height Rx
	- d: distance
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
	- d: distance
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
- d: distance
- mode (Urbano, Suburbano, rural)

Métodos:

	- EricssonpathLoss(float f, float TxH, float RxH, float d, int mode)

Clase: **fspl** (free space path loss)<br>
Complejidad: FACIL

Es un modelo muy simple que solamente tiene en cuenta distancia y frecuencia y no asume elevaciones en el terreno. Se puede mejorar. Se puede mejorar con la función knife edge diffraction (ked) que añade alturas de antenas y elevaciones.	
	
	𝑃𝐿𝑑𝑏=32.44+20log𝑑+20log⁡(𝑓)
Puede verse afectada por la diferencia entre la ganancia de la antena transmisora y receptora. 𝐺𝑡−𝐺𝑟
Atributos:<br>

	- f Freq
	- d distance
	- mode
Admite cualquier frecuencia y distancia.

Métodos:
	
	- double FSPLpathLoss(float f, float d);


Clase: **hata**<br>
Complejidad: MEDIA

Se usa principalmente para entornos urbanos con edificios altos. Generalmente para una transmisión Ant_tx-Mobile station. El modelo asume que el tx es más alto que la altura media de los tejados. 150 to 1500 MHzz con altura mínima para la antena transmisora de 30m a 1000m y distancia hasta 100km. Costhata model es una extensión de este modelo. 
Atributos:<br>

	- f Freq
	- TxH Height Tx
	- RxH Height Rx
	- d: distance
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

Line of Sight. Devuelve un si/no. Se extiende hasta los 100GHz. Utiliza datos del terreno y altura de las antenas.
Más que un modelo es una clase que pueden implementar los demás modelos para ir determinando los puntos que tienen visión directa respecto al tx. Estos puntos se guardan en un array mask[][] y aparecerán en verde en el PPM.
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
	- d distance
	- t: Terrain permittivity: 1 - 15 (Bad to Good)

Métodos:

	- Eouble SoilPathLoss(float f, float d, float t);

Clase: **sui**<br>
Complejidad: MEDIA

Stanford University Interim

Atributos:

	- f Freq
	- TxH Height Tx
	- RxH Height Rx
	- d: distance
	- mode (Urbano, Suburbano, rural)<br>

Métodos:

	- SUIpathLoss(double f, double TxH, double RxH, double d, int mode);

