Las clases definidas en la aplicación CloudRF son:

##### *image-ppm.hh*<br>
Clase: **image_dispache_table_t**<br>
Atributos:<br>
Métodos:<br>
- ppm_init
- ppm_add_pixel 
- ppm_set_pixel
- ppm_write

> Se inicializa y se crean los pixeles de las imágenes. Aquí se ha instanciado esta clase y sus respectivos métodos mientras que en **image.hh** se definen(*image_dispache_table*).

##### *image.hh*<br>

Clase: **image_ctx**<br>
Atributos:<br>
- width, height, model, format, initialized, \*canvas,\* next_pixel, \*extension, \*dt <br>

Métodos:
> Los atributos de esta clase son usados por las clases *global-image.hh, image_dispatch_table, image_dispache_table_t*.

Clase: **global-image.hh**<br>
Atributos:<br>
Métodos:<br>
- image_set_format(int format): Cambia el formato por defecto de la imagen.<br>
- int image_init(image_ctx_t \*ctx, const size_t width, const size_t height, const int model, const int format): Inicializa la imagen con una serie de atributos(Debe llamarse primero antes de escribir cualquier dato).<br>
- image_add_pixel, image_set_pixel, image_get_pixel, image_write, image_free: Leen y escriben en un fichero. Estas funciones simplemente envuelven los métodos definidos en **image_dispache_table_t**.<br>
> Estos métodos vienen algo explicados en *image.cc*
> Manejo de la salida de la imagen. Permite mejores formatos de salida. Se define esta clase para instanciar y manipular la interfaz ya comentada *image_dispache_table*.

Clase: **<<INTERFAZ>>image_dispatch_table**<br>
Atributos:<br>
Métodos:<br>
- init(image_ctx_t*), 
- add_pixel(image_ctx_t*,const uint8_t,const uint8_t,const uint8_t,const uint8_t)
- set_pixel(image_ctx_t*,const size_t,const size_t,const uint8_t,const uint8_t,const uint8_t,const uint8_t)
- get_pixel(image_ctx_t*,const size_t,const size_t,const uint8_t*,const uint8_t*,const uint8_t*,const uint8_t*)
- write(image_ctx_t*,FILE*)
- free(image_ctx_t*)
> Estas funciones envuelven los métodos de las clase global-image.hh y image_ctx. Estos métodos no están definidos.

> Las anteriores clases realizan la construcción de la imagen bitmap, su formato RGB, resolución, y la guardan en el fichero de salida cuyo nombre proporciona el usuario.
***
##### *inputs.hh*<br>
Clase: **global-inputs**<br>
Atributos:<br>
Métodos:<br>
- LoadSDF_SDF(char \*name, int winfiles): Carga en memoria el *name* de un archivo .sdf sin comprimir el cual contiene datos DEM.<br>
- LoadSDF(char \*name, int winfiles): Carga un .sdf comprimido. Si no es posible se supondrá la BTS y su propagación a nivel del mar<br>
- LoadPAT(char \*az_filename, char \*el_filename): Lee PAT ficheros .az y .el.<br>
- LoadSignalColors(struct site xmtr);<br>
- LoadLossColors(struct site xmtr);<br>
- LoadDBMColors(struct site xmtr);<br>
- LoadTopoData(int max_lon, int min_lon, int max_lat, int min_lat);<br>
- LoadUDT(char \*filename): User-Define Terrain, carga un fichero de DEM especificado por el usuario.<br>
- loadLIDAR(char \*filename, int resample);<br>
- loadClutter(char \*filename, double radius, struct site tx);<br>
- averageHeight(int h, int w, int x, int y);<br>
> Estos métodos funcionan como herrramientas/scripts. Se ayudan de los atributos definidos en clases de diferentes ficheros: *common.h, main.hh, tiles.hh*.

##### *common.h*<br>
Clase: **dem**<br>
Atributos:
float min_north
- float max_north
- float min_west
- float max_west
- int max_el
- int min_el
- short \**data
- unsigned char \**mask
- unsigned char \**signal

Métodos:<br>

Clase: **site**<br>
Atributos:<br>
- double lat;
- lon
- alt
- name
- filename

Métodos:<br>

Clase: **path**<br>
Atributos:<br>
- lat
- lon
- elevation
- distance
- length

Métodos:<br>

Clase: **LR**<br>
Atributos:
- eps_dielect
- sgm_conductivity
- eno_ns_surfref
- frq_mhz
- conf
- rel
- erp
- radio_climate
- int pol
- float antenna_pattern

Métodos:<br>

Clase: **region**<br>
Atributos:
- color
- level
- levels

Métodos:<br>
> Las clases global-MAIN o global-inputs usane stas clases aquí definidas.

##### *main.hh*<br>
Clase: **global-MAIN**<br>
Atributos:<br>
Métodos:<br>
- int ReduceAngle(double angle);
- double LonDiff(double lon1, double lon2);
- int PutMask(double lat, double lon, int value);
- int OrMask(double lat, double lon, int value);
- int GetMask(double lat, double lon);
- int PutSignal(double lat, double lon, unsigned char signal);
- unsigned char GetSignal(double lat, double lon);
- double GetElevation(struct site location);
- int AddElevation(double lat, double lon, double height, int size);
- double Distance(struct site site1, struct site site2);
- double Azimuth(struct site source, struct site destination);
- double ElevationAngle(struct site source, struct site destination);
- void ReadPath(struct site source, struct site destination);
- double ElevationAngle2(struct site source, struct site destination, double er);
- double ReadBearing(char *input);
- void ObstructionAnalysis(struct site xmtr, struct site rcvr, double f,
			 FILE *outfile);
> Estos métodos vienen algo definidas en el main.cc

#### Model directory 
> ALGORITHM

Clase: **cost**<br>
Atributos:<br>
- f Freq
- TxH Height Tx
- RxH Height Rx
- d: Propagation ratio
- mode (Urbano, Suburbano, rural)
Métodos:<br>
- COST231pathLoss(float f, float TxH, float RxH, float d, int mode)

Clase: **ecc33**<br>
Atributos:<br>
- f Freq
- TxH Height Tx
- RxH Height Rx
- d: Propagation ratio
- mode (Urbano, Suburbano, rural)
Métodos:<br>
- ECC33pathLoss(float f, float TxH, float RxH, float d, int mode);

Clase: **egli**<br>
Atributos:<br>
- f Freq
- TxH Height Tx
- RxH Height Rx
- d: Propagation ratio
- mode (Urbano, Suburbano, rural)
Métodos:<br>
- EgliPathLoss(float f, float h1, float h2, float d);


Clase: **ericsson**<br>
Atributos:<br>
- f Freq
- TxH Height Tx
- RxH Height Rx
- d: Propagation ratio
- mode (Urbano, Suburbano, rural)
Métodos:<br>
- EricssonpathLoss(float f, float TxH, float RxH, float d, int mode)

Clase: **fspl**<br>
Atributos:<br>
- f Freq
- d Propagation ratio
- mode
Métodos:<br>
- double FSPLpathLoss(float f, float d);


Clase: **hata**<br>
Atributos:<br>
- f Freq
- TxH Height Tx
- RxH Height Rx
- d: Propagation ratio
- mode (Urbano, Suburbano, rural)
Métodos:<br>
- double HATApathLoss(float f, float h_B, float h_M, float d, int mode);

Clase: **itwom3.0**<br>
<details>
<summary>Atributos:</summary>
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
</details>

<details> 
<summary>Métodos:</summary>	
    -point_to_point_ITM
    -point_to_point
</details> 

> Usa common.h

Clase: **los**<br>
Atributos:<br>
Métodos:<br>
- PlotLOSPath
- PlotPropPath
- PlotLOSMap
- PlotPropagation
- PlotPath

Clase: **pel**<br>
Atributos:
- f Freq
- TxH Height Tx
- RxH Height Rx

Métodos:<br>
- PlaneEarthLoss(float d, float TxH, float RxH);

Clase: **soil**<br>
Atributos:
- f Freq
- d Propagation ratio
- t: Terrain permittivity: 1 - 15 (Bad to Good)

Métodos:<br>
- Eouble SoilPathLoss(float f, float d, float t);

Clase: **sui**<br>
Atributos:
- f Freq
- TxH Height Tx
- RxH Height Rx
- d: Propagation ratio
- mode (Urbano, Suburbano, rural)<br>

Métodos:<br>
- SUIpathLoss(double f, double TxH, double RxH, double d, int mode);
