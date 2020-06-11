Las clases definidas en la aplicación CloudRF son:

##### *inputs.hh*<br>
Clase: **global-inputs**<br>
Métodos:<br>

	- int LoadSDF_SDF(char \*name, int winfiles) 
		   Here X lines of DEM will be read until IPPD is reached.
		   Each .sdf tile contains 1200x1200 = 1.44M 'points'
		   Each point is sampled for 1200 resolution!
param1 archivo, param2 no se define. Se lee un fichero .sdf con información DEM y se almacenan en la primera struct dem disponible. Elevation data, maximum and minimum elevations, and quadrangle limits.
Aquí se guardan en las variables globales de la clase common.h los máximos  y mínimos.
	
	- int LoadSDF(char \*name, int winfiles) 
Primero llama a LoadSDF_SDF, si devuelve -1 continúa si no termina. Carga un .sdf comprimido. Si no es posible se supondrá la BTS y su propagación a nivel del mar. Devuelve 0 todo bien, -1 error o errno.

	- int LoadPAT(char \*az_filename, char \*el_filename) 
		Processes antenna pattern
Se llama en el main, cuando se lee el parámetro -o. 
Lee ficheros azimuth y elevations. Devuelve 0 todo bien, -1 error o errno.
	
	- int LoadSignalColors(struct site xmtr)
variable struct site de common.h la cual contiene entre otros el filename de ahí q no necesite pasarlo, ya lo tiene almacenado de alguna función anterior. Carga unos valores por defecto de los colores. Devuelve errno en caso de error.

	- int LoadLossColors(struct site xmtr)
Carga valores de la variable struct region de common.h. 

	- int LoadDBMColors(struct site xmtr)
Carga colores por defecto.
	
	- int LoadTopoData(int max_lon, int min_lon, int max_lat, int min_lat)
Esta función carga los archivos SDF necesarios para cubrir los límites de la región especificada. Almacena la info en un extern char string\[] declarado en common.h

	- int LoadUDT(char \*filename)
User-Define Terrain, carga un fichero de DEM especificado por el usuario. errno si error.

	- int loadLIDAR(char \*filename, int resample);
	- int loadClutter(char \*filename, double radius, struct site tx)
param1 fichero, param2  radio para indicar el límite, param 3 struct de common.h con información del lugar de propagación. Devuelve 0 todo bien, -1 error o errno.
	
	- int averageHeight(int h, int w, int x, int y)
param, altura, ancho y 2 enteros que definen las posiciones. Usa la estructura dem(máximos y mínimos de los ejes cardinales) de common.h. Devuelve la altura media de las elevaciones en torno a al punto especificado por los enteros y se devuelve redondeada.

Estos métodos funcionan como herrramientas/scripts. Se ayudan de los atributos definidos en clases de diferentes ficheros: *common.h, main.hh, tiles.hh*.

##### *common.h*<br>
Clase: **dem**<br>
Atributos:

	-float min_north
	- float max_north
	- float min_west
	- float max_west
	- int max_el
	- int min_el
	- short \**data
	- unsigned char \**mask
	- unsigned char \**signal
DEM Digital elevations model. 

Clase: **site**<br>
Almacena las coordenadas de la antena transmisora.

Atributos:<br>

	- double lat;
	- double lon
	- float alt
	- char name
	- char filename

Clase: **path**<br>
Aparece en las funciones de cálculo y copia de elevaciones, clutter, Azimuth.
Atributos:<br>

	- double lat
	- double lon
	- double elevation
	- double distance
	- int length

Clase: **LR**<br>
Almacena atributos, parámetros de entrada.
Atributos:

	- double eps_dielect
	- double sgm_conductivity
	- double eno_ns_surfref
	- double frq_mhz
	- double conf
	- double rel
	- double erp
	- int radio_climate
	- int pol
	- float antenna_pattern

Clase: **region**
Atributos:

	- unsigned char color
	- int level
	- int levels

Clase: **global-common**<br>
Conjunto de atributos usados en la mayoría de clases para almacenar todo tipo de información y para manejar las anteriores clases definidas en este archivo.
Atributos:

	- #define DEG2RAD		1.74532925199e-02
	- #define	EARTHRADIUS	20902230.97
	- #define	METERS_PER_MILE 1609.344
	- #define	METERS_PER_FOOT 0.3048
	- #define	KM_PER_MILE	1.609344
	- #define	FEET_PER_MILE	5280.0
	- #define FOUR_THIRDS	1.3333333333333
	- extern int MAXPAGES;
	- extern int ARRAYSIZE;
	- extern int IPPD;
	- extern double min_north;
	- extern double max_north;
	- extern double min_west;
	- extern double max_west;
	- extern int ippd;
	- extern int MAXRAD;
	- extern int mpi;
	- extern int max_elevation;
	- extern int min_elevation;
	- extern int contour_threshold;
	- extern int loops;
	- extern int jgets;
	- extern int width;
	- extern int height;
	- extern double earthradius;
	- extern double north;
	- extern double east;
	- extern double south;
	- extern double west;
	- extern double max_range;
	- extern double dpp;
	- extern double ppd;
	- extern double yppd;
	- extern double fzone_clearance;
	- extern double clutter;
	- extern double dBm;
	- extern double loss;
	- extern double field_strength;
	- extern \__thread double *elev;
	- extern double westoffset;
	- extern double eastoffset;
	- extern double delta;
	- extern double cropLat;
	- extern double cropLon;
	- extern char string[];
	- extern char sdf_path[];
	- extern char gpsav;
	- extern unsigned char got_elevation_pattern;
	- extern unsigned char got_azimuth_pattern;
	- extern unsigned char metric;
	- extern unsigned char dbm;
	- extern struct dem *dem;
	- extern \__thread struct path path;
	- extern struct LR LR;
	- extern struct region region;
	- extern int debug;

##### *main.hh*

Clase: **global-MAIN**<br>

Se van analizando los parámetros de entrada, se detectan errores y se asignan las correspondencias.

Métodos:<br>

	- int ReduceAngle(double angle)
Devuelve un argumento normalizado para un ángulo entero entre 0 y 180 grados.
	
	- double LonDiff(double lon1, double lon2) 
		/*This function returns the short path longitudinal
		difference between longitude1 and longitude2
		as an angle between -180.0 and +180.0 degrees.
		If lon1 is west of lon2, the result is positive.
		If lon1 is east of lon2, the result is negative.*/
Devuelve la diferencia longitudinal entre 2 longitudes como un ángulo entre -180º y 180º

	- int PutMask(double lat, double lon, int value)
	- int OrMask(double lat, double lon, int value)
	- int GetMask(double lat, double lon)
Almacena en una variable struct dem[][].mask[][] información áreas de cobertura, en el tercer parámeretro: *int value*.
Estas dos funciones establecen y resetean los bits en la mask basándose en la long y lat del punto. Se recombinan con los datos de la topología cuando se generan los mapas topográficos al invocar la llamada de SignalServer. Devuelve la máscara de bits basada en lat y lon calculada en OrMask(...).

	- int PutSignal(double lat, double lon, unsigned char signal)
	- unsigned char GetSignal(double lat, double lon)
PutSignal escribe un valor de señal entre 0-255 (que representa el valor RGB que dentrá el punto en concreto en el ppm). El tercer parámetro *unsigned char signal* almacena dicho valor en dem[indx].signal[x][y].
GetSignal devuelve el valor de intensidad de señal en un punto(dem[].signal[][]) especificado en las parámetros de entrada.


	- double GetElevation(struct site location)
Devuelve la elevación DEM almacenada en struct dem previamente (al cargar los archivos .sdf)

	- int AddElevation(double lat, double lon, double height, int size)
		/* This function adds a user-defined terrain feature
		   (in meters AGL) to the digital elevation model data
		   in memory.  Does nothing and returns 0 for locations
		   not found in memory. */

user defain terrain

	- double dist(double lat1, double lon1, double lat2, double lon2)
Mejora de la HAVERSINE FORMULA

	- double Distance(struct site site1, struct site site2)
Devuelve la distancia en millas entre 2 localizaciones en la misma esfera (HAVERSINE FORMULA)

	- double Azimuth(struct site source, struct site destination)
Devuelve el Azimuth al destino desde la fuente.

	- double ElevationAngle(struct site source, struct site destination)
Devuelve el angulo de elevación al destino visto desde la fuente.

	- void ReadPath(struct site source, struct site destination)
Almacena en path struct una secuencia de puntos entre fuente-destino

	- double ElevationAngle2(struct site source, struct site destination, double er)
Igual q ElevationAngle() sólo q esta vez si hay un obstacula en la ruta, el ángulo es fuente-primer_obstáculo. *er* representa el Radiod e la tierra (earth radius)

	- double ReadBearing(char \*input)
Esta función recibe una entrada númera en forma de string(40.1463 o 40 08 23  en formato grado, minuto segundo)  y devuelve su ángulo equivalente en grados como un número decimal.

	- void ObstructionAnalysis(struct site xmtr, struct site rcvr, double f, FILE \*outfile)
A cada punto entre tx y rx va calculando los cosenos en el path para ir analizando las obstrucciones.

Estos métodos vienen algo definidas en el main.cc

El main contiene funciones free dem(), free site(), para liberar estas estructuras y no sobrecargar espacio en memoria. También del tipo alloc para reservar.

##### *outputs.hh*<br>
Clase: **global-outputs**<br>

¿Cuál es la diferencia en cada uno de estos métodos? IMPORTANTE. a priori todos devuelven lo mismo pero de una forma particular<br>

Métodos:<br>

	- void DoPathLoss(char \*filename, unsigned char geo, unsigned char kml, unsigned char ngs, struct site \*xmtr, unsigned char txsites)
		This function generates a topographic map in Portable Pix Map
		(PPM) format based on the content of flags held in the mask[][]
		array (only). 
Param1 fichero, param2 3 y 4 ??, param5 struct site almacena datos del lugar, param6 no se usa. 
       
	- int DoSigStr(char \*filename, unsigned char geo, unsigned char kml, unsigned char ngs, struct site \*xmtr, unsigned char txsites); 
	This function generates a topographic map in Portable Pix Map
	(PPM) format based on the signal strength values held in the
	signal[][] arrayreturn 0 correct or errno. 

	- DoRxdPwr(char \*filename, unsigned char geo, unsigned char kml, unsigned char ngs, struct site \*xmtr, unsigned char txsites):
	This function generates a topographic map in Portable Pix Map
	(PPM) format based on the signal power level values held in the
	signal[][] array.
Cargamos la intensidad de señal en cada punto según lo almacenado en la clase struct dem (dBm=dem[].signal[][]).
	   
	- void DoLOS(char \*filename, unsigned char geo, unsigned char kml, unsigned char ngs, struct site \*xmtr, unsigned char txsites); 
	This function generates a topographic map in Portable Pix Map
	(PPM) format based on the signal power level values held in the
	signal[][] array. 
	   
	- void **PathReport(struct site source, struct site destination, char \*name, char graph_it, int propmodel, int pmenv, double rxGain)**

PathReport: Es en esta función donde se pasa el modelo de propagación y parámetros como el submodelo, radio_climate, Polarización, ganancia recibida. 
Cálcula el coseno del ángulo de elevación sobre el terreno. 
Compara ángulos para saber si existen obstrucciones. Se le puede indicar tipo de fichero y si no se supone .png. Los modelos de propagación retornan un double con las pérdidas. 
		
	- void SeriesData(struct site source, struct site destination, char \*name, unsigned char fresnel_plot, unsigned char normalised)
Estas funciones invocan a la función ADD_PIXEL para añadir color a los pixeles que representan la intensidad de propagación(ADD_PIXEL(image.hh) > image_add_pixel(definida image.cc) > DISPATCH_TABLE(image.cc) > image_dispatch_table_t*(image-ppm.hh) > ppm_add_pixel (finalmente en image-ppm.cc)). Generan un color para la propagación en un punto. Estas funciones generan un mapa topográfico ppm basado en el nivel de intensidad de la señal almacenado en el array signal[][]. La imagen generada se rota 90º en el sentido de las aguajs del reloj desde su representación dem[][] de tal forma que el norte apunte hacia arriba y el este hacia la derecha. Tanto dem[][] como signal[][] son atributos del fichero common.h. 

##### *tiles.hh*<br>	   
Clase: **tile_t**<br>
Atributos:<br>

	- union{int cols; int width}
	- union{int rows; int height}
	- union{double xll; double max_west}
	- union{double yll; double min_north}
	- union{double xur; double min_west}
	- union{double yur; double max_north}
	- double cellsize;
	- long long datastart;
	- short	nodata;
	- short max_el;
	- short	min_el;
	- short	\*data;
	- float precise_resolution;
	- float	resolution;
	- double width_deg;
	- double height_deg;
	- int ppdx;
	- int ppdy;
Métodos:<br>

	- int tile_load_lidar(tile_t\*, char \*)
Primer parámetro es un puntero a la estructura(clase) tile_t, y char* es un puntero para manejar el fichero lidar(open, read, write, close). Almacena en una struct tile_t y devuelve 0 (-1 en caso de error).

	- int tile_rescale(tile_t \*, float scale)
Puntero a estructura y el segundo parámetro indica el factor de escalado que aunque sea un float luego se convertirá con size_t y se tratará como un entero. Devuelve -1 en caso de error.

	- void tile_destroy(tile_t \*)
Puntero para liberar cualquier información asociada a un cuadro(tile).

Se usa principalmente para reescalar la imagen LIDAR ya que esta solo opta a una resolución de 2m. La resolución aumenta en múltiplos de 2(4, 6, 8). Esta función es capaz de fusionar valores de píxeles vecinos

Estructura necesaria para manejar el reescalado de las imágenes

##### *image-ppm.hh*<br>
Clase: **image_dispache_table_t**<br>

Atributos:
	
	- image_dispatch_table_t ppm_dt
atributo tipo image_dispatch_table_t para invocar sus métodos.

Métodos:<br>

	- ppm_init
	- ppm_add_pixel 
	- ppm_set_pixel
	- ppm_write

Se inicializa y se crean los pixeles de las imágenes. Aquí se ha instanciado esta clase y sus respectivos métodos mientras que en **image.hh** se definen(*image_dispache_table*).

##### *image.hh*<br>

Clase: **image_ctx**<br>
Atributos:<br>

	- width,
	- height, 
	- model, 
	- format, 
	- initialized, 
	- *canvas,
	- *next_pixel, 
	- *extension, 
	- *dt <br>
	
	-image_ctx_t
	*pimage_ctx_t
Los atributos de esta clase son usados por las clases *global-image.hh, image_dispatch_table, image_dispache_table_t*.

Clase: **global-image**<br>
Métodos:<br>

	image_set_format(int format)

Cambia el formato por defecto de la imagen

	int image_init(image_ctx_t \*ctx, const size_t width, const size_t height, const int model, const int format)

Inicializa la imagen con una serie de atributos(Debe llamarse primero antes de escribir cualquier dato).<br>

	 image_add_pixel, image_set_pixel, image_get_pixel, image_write, image_free

Leen y escriben en un fichero. Estas funciones simplemente envuelven los métodos definidos en **image_dispache_table_t**

Estos métodos vienen algo explicados en *image.cc*

Manejo de la salida de la imagen. Permite mejores formatos de salida. Se define esta clase para instanciar y manipular la interfaz ya comentada *image_dispache_table*.

Clase: **\<INTERFAZ\>image_dispatch_table**<br>
Métodos:<br>

	- init(image_ctx_t*), 
	- add_pixel(image_ctx_t*,const uint8_t,const uint8_t,const uint8_t,const uint8_t)
	- set_pixel(image_ctx_t*,const size_t,const size_t,const uint8_t,const uint8_t,const uint8_t,const uint8_t)
	- get_pixel(image_ctx_t*,const size_t,const size_t,const uint8_t*,const uint8_t*,const uint8_t*,const uint8_t*)
	- write(image_ctx_t*,FILE*)
	- free(image_ctx_t*)
	
Estas funciones envuelven los métodos de las clase global-image.hh y image_ctx. Estos métodos no están definidos.

Las anteriores clases realizan la construcción de la imagen bitmap, su formato RGB, resolución, y la guardan en el fichero de salida.
