### Este documento trata sobre la funcionalidad que queremos dotar a la herramienta.
------

* __Funcionalidad que tiene actualmente la herramienta.__

La aplicación de partida es Cloud-RF. Esta es una herramienta OpenSource para el análisis de Propagación de señales de Radio-Frecuencia, pérdidas y características del terreno. Tiene soporte para multitud de estándares de telecomunicación, como VHF, GMS, UMTS, 5G, WI-Fi y Wi-Max entre otros.

La versión sobre la que vamos a trabajar es SignalServer. Se trata de una herramienta de línea de comandos o terminal de textos (shell), y lee los datos de entrada como parámetros y ficheros de datos. Dicha versión está fundamentada en la herramienta original SPLAT! (Signal Propagation, Loss, And Terrain analysis tool SPLAT!). 

SignalServer provee datos RF de ingeniería del sitio, es decir, parámetros de entrada, y produce reportes en forma de gráficos y mapas topográficos que presentan trayectorias de linea-de-vista, pérdidas por trayectorias regionales y contornos de intensidad de señal a través de los cuales se puede determinar el área de cobertura esperada de sistemas transmisores o repetidores. 
Los parámetros de la herramienta se dividen en: 

<details>  
  <summary>1. Parámetros de entrada:</summary> 
  
  ##### INPUT:
  
     * lat Tx Latitude (decimal degrees) -70/+70
     * lon Tx Longitude (decimal degrees) -180/+180
     * txh Tx Height (above ground)
     * rla (Optional) Rx Latitude for PPA (decimal degrees) -70/+70
     * rlo (Optional) Rx Longitude for PPA (decimal degrees) -180/+180
     * f Tx Frequency (MHz) 20MHz to 100GHz (LOS after 20GHz)
     * erp Tx Effective Radiated Power (Watts) including Tx+Rx gain
     * rxh Rx Height(s) (optional. Default=0.1)
     * rxg Rx gain dBi (optional for text report)
     * hp Horizontal Polarisation (default=vertical)
     * gc Random ground clutter (feet/meters)
     * m Metric units of measurement
     * te Terrain code 1-6 (optional)
     * terdic Terrain dielectric value 2-80 (optional)
     * tercon Terrain conductivity 0.01-0.0001 (optional)
     * cl Climate code 1-6 (optional)
     * rel Reliability for ITM model 50 to 99 (optional)
     * resample Resample Lidar input to specified resolution in meters (optional)
</details>
Características del modelo de telecomunicación que giran en torno a los parámetros de transmisión de la antena, distancia, unidades, tipo de entorno y clima (opcional). Algunos de los parámetros son obligatorios poara la ejecución apropiada del programa, mientras que otros son opcionales.

<br/> <details>
  <summary>2. Ficheros de datos</summary>
 
  ##### DATA:
  
     * sdf Directory containing SRTM derived .sdf DEM tiles
     * lid ASCII grid tile (LIDAR) with dimensions and resolution defined in header
     * udt User defined point clutter as decimal co-ordinates: 'latitude,longitude,height'
     * clt MODIS 17-class wide area clutter in ASCII grid format
</details>
Ficheros de datos. Adicionalmente se requiere el uso de programas/scripts como opciones de entrada. Los archivos .sdf contienen los modelos digitales del terreno (DEM). Estos existen en diferentes resoluciones, STRM, STRM v2 y STRM-3 (versión 2.1). Estas versiones ofrecen resoluciones en 1 arcosegundo (90m aprox) y 3 arcos (30m) pudiéndose obtener del sitioweb [USGS](https://dds.cr.usgs.gov/srtm/).

<br/> <details>
  <summary>3. Opciones a la salida</summary>
 
  ##### OUTPUT:
  
     * dbm Plot Rxd signal power instead of field strength
     * rt Rx Threshold (dB / dBm / dBuV/m)
     * o Filename. Required. 
     * R Radius (miles/kilometers)
     * res Pixels per tile. 300/600/1200/3600 (Optional. LIDAR res is within the tile)
     * pm Propagation model. 1: ITM, 2: LOS, 3: Hata, 4: ECC33,
     	  5: SUI, 6: COST-Hata, 7: FSPL, 8: ITWOM, 9: Ericsson, 10: Plane earth, 11: Egli VHF/UHF
     * pe Propagation model mode: 1=Urban,2=Suburban,3=Rural
     * ked Knife edge diffraction (Already on for ITM)
</details>
Los parámetros a la salida establecen el alcance de nuestra cobertura radiada -R, el modelo de propagación escogido para el cálculo, el tipo de terreno sobre el que realizamos la propagación (necesario para optimizar el cálculo realizado por los diferentes tipos de modelo) y el nombre del archivo donde se almacenan los resultados.


<br/>Su forma de uso es:
`signalserver [data options] [input options] [output options] -o outputfile`

* __Funcionalidad que tendrá cuando finalice el proyecto.__

* __De la funcionalidad que tendrá el proyecto indicar cuál ya existía cuál es nueva y cuál deja de existir con respecto a lo que ya había.__
