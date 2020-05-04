Las clases definidas en la aplicación CloudRF son:

######*image-ppm.hh*<br>
Clase: **image_dispache_table_t**<br>
Atributos:<br>
Métodos:<br>
init:<br>
add_pixel:<br>
set_pixel:<br>

> Existe una interfaz de *image_dispache_table* definida en **image.hh**. Es en este fichero donde se crea también una clase estructura *_image_ctx* para manipular e instanciar los métodos de *image-ppm.hh*.

*image.hh*<br>
Clase: **image_ctx**<br>
Atributos:
width<br>
height<br>
model<br>
format<br>
initialized<br>
canvas<br>
next_pixel<br>
extension<br>
dt<br>
Métodos:<br>
init:<br>
add_pixel:<br>
set_pixel:<br>
