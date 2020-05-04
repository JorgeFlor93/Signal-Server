Las clases definidas en la aplicación CloudRF son:

###### *image-ppm.hh*<br>
Clase: **image_dispache_table_t**<br>
Atributos:<br>
Métodos:<br>
init, add_pixel, set_pixel: Se inicializa y se crean los pixeles de las imágenes<br>

> Aquí se ha instanciado esta clase y sus respectivos métodos mientras que en **image.hh** se definen(*image_dispache_table*).

###### *image.hh*<br>

Clase: **image_ctx**<br>
Atributos:<br>
width, height, model, format, initialized, \*canvas,\* next_pixel, \*extension, \*dt<br>
Métodos:<br>

Clase: **global-image.hh**<br>
Atributos:<br>
Métodos:<br>
- image_set_format(int format): Cambia el formato por defecto de la imagen.<br>
- int image_init(image_ctx_t \*ctx, const size_t width, const size_t height, const int model, const int format): Inicializa la imagen con una serie de atributos(Debe llamarse primero antes de escribir cualquier dato).<br>
- image_add_pixel, image_set_pixel, image_get_pixel, image_write, image_free: Leen y escriben en un fichero. Estas funciones simplemente envuelven los métodos definidos en **image_dispache_table_t**.<br>
> Estos métodos vienen algo explicados en *image.cc*
> Manejo de la salida de la imagen. Permite mejores formatos de salida. Se define esta clase para instanciar y manipular la interfaz ya comentada *image_dispache_table*.

Clase: **_image_dispatch_table**<br>
Atributos:<br>
Métodos:<br>
- init(image_ctx_t*), 
- add_pixel(image_ctx_t*,const uint8_t,const uint8_t,const uint8_t,const uint8_t)
- set_pixel(image_ctx_t*,const size_t,const size_t,const uint8_t,const uint8_t,const uint8_t,const uint8_t)
- get_pixel(image_ctx_t*,const size_t,const size_t,const uint8_t*,const uint8_t*,const uint8_t*,const uint8_t*)
- write(image_ctx_t*,FILE*)
- free(image_ctx_t*)

###### *inputs.hh*<br>
Clase: **LoadPAT**<br>
Atributos:<br>
Métodos:<br>
<br>

###### *common.h*<br>
Clase: **dem**<br>
Atributos:<br>
Métodos:<br>

