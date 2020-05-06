Las clases definidas en la aplicación CloudRF son:

##### *image-ppm.hh*<br>
Clase: **image_dispache_table_t**<br>
Atributos:<br>
Métodos:<br>
- init, add_pixel, set_pixel: Se inicializa y se crean los pixeles de las imágenes<br>

> Aquí se ha instanciado esta clase y sus respectivos métodos mientras que en **image.hh** se definen(*image_dispache_table*).

##### *image.hh*<br>

Clase: **image_ctx**<br>
Atributos:<br>
- width, height, model, format, initialized, \*canvas,\* next_pixel, \*extension, \*dt<br>
Métodos:<br>
> Los atributos de esta clase son usados por las clases *global-image.hh, image_dispatch_table, image_dispache_table_t*.

Clase: **global-image.hh**<br>
Atributos:<br>
Métodos:<br>
- image_set_format(int format): Cambia el formato por defecto de la imagen.<br>
- int image_init(image_ctx_t \*ctx, const size_t width, const size_t height, const int model, const int format): Inicializa la imagen con una serie de atributos(Debe llamarse primero antes de escribir cualquier dato).<br>
- image_add_pixel, image_set_pixel, image_get_pixel, image_write, image_free: Leen y escriben en un fichero. Estas funciones simplemente envuelven los métodos definidos en **image_dispache_table_t**.<br>
> Estos métodos vienen algo explicados en *image.cc*
> Manejo de la salida de la imagen. Permite mejores formatos de salida. Se define esta clase para instanciar y manipular la interfaz ya comentada *image_dispache_table*.

Clase: **image_dispatch_table**<br>
Atributos:<br>
Métodos:<br>
- init(image_ctx_t*), 
- add_pixel(image_ctx_t*,const uint8_t,const uint8_t,const uint8_t,const uint8_t)
- set_pixel(image_ctx_t*,const size_t,const size_t,const uint8_t,const uint8_t,const uint8_t,const uint8_t)
- get_pixel(image_ctx_t*,const size_t,const size_t,const uint8_t*,const uint8_t*,const uint8_t*,const uint8_t*)
- write(image_ctx_t*,FILE*)
- free(image_ctx_t*)
> Estas funciones envuelven los métodos de las clase global-image.hh y image_ctx

##### *inputs.hh*<br>
Clase: **global-inputs**<br>
Atributos:<br>
Métodos:<br>
LoadSDF_SDF(char \*name, int winfiles): Carga en memoria el *name* de un archivo .sdf sin comprimir el cual contiene datos DEM.<br>
LoadSDF(char \*name, int winfiles): Carga un .sdf comprimido. Si no es posible se supondrá la BTS y su propagación a nivel del mar<br>
LoadPAT(char \*az_filename, char \*el_filename): Lee PAT ficheros .az y .el.<br>
LoadSignalColors(struct site xmtr);<br>
LoadLossColors(struct site xmtr);<br>
LoadDBMColors(struct site xmtr);<br>
LoadTopoData(int max_lon, int min_lon, int max_lat, int min_lat);<br>
LoadUDT(char \*filename): User-Define Terrain, carga un fichero de DEM especificado por el usuario.<br>
loadLIDAR(char \*filename, int resample);<br>
loadClutter(char \*filename, double radius, struct site tx);<br>
averageHeight(int h, int w, int x, int y);<br>
> Estos métodos funcionan como herrramientas/scripts. Se ayudan de los atributos definidos en clases de diferentes ficheros: *common.h, main.hh, tiles.hh*.

##### *common.h*<br>
Clase: **dem**<br>
Atributos:<br>
float min_north;
- float max_north;
- float min_west;
- float max_west;
- int max_el;
- int min_el;
- short \**data;
- unsigned char \**mask;
- unsigned char \**signal;
Métodos:<br>

Clase: **site**<br>
Atributos:<br>
- double lat;
- lon;
- alt;
- name;
- filename;
Métodos:<br>

Clase: **path**<br>
Atributos:<br>
- lat;
- lon;
- elevation;
- distance;
- length;
Métodos:<br>

Clase: **LR**<br>
Atributos:<br>
- eps_dielect;
- sgm_conductivity;
- eno_ns_surfref;
- frq_mhz;
- conf;
- rel;
- erp;
- radio_climate;
- int pol;
- float antenna_pattern[361][1001];
Métodos:<br>

Clase: **region**<br>
Atributos:<br>
- color[128][3];
- level[128];
- levels;
Métodos:<br>
> Las clases global-MAIN o global-inputs usane stas clases aquí definidas.

##### *global-MAIN*<br>
Clase: **dem**<br>
Atributos:<br>
Métodos:<br>
