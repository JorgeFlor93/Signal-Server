# Signal Server
Multi-threaded radio propagation simulator based upon SPLAT! by Alex Farrant QCVS, 2E0TDW. 

SPLAT! Project started in 1997 by John A. Magliacane, KD2BD

This server application will generate RF coverage predictions, producing either 2D profile plots (Point-to-Point) or 360 degree polar plots in WGS-84 projection as PPM Bitmaps.
For detailed information and historical reference data related to this project see the SPLAT! documentation. Propagation models added to this project have been sourced from reputable academic sources and all efforts have been taken to ensure their accurate implementation. Not all models are ITU ratified and you use them entirely at your own risk.

WARNING: The accuracy of the output is directly proportional to the accuracy of the inputs and the time taken defining and validating them. 


## Requirements
* Linux
* GCC,G++
* Multicore CPU (optional)
* ~2GB Memory
* SRTM terrain tile(s) or ASCII Grid tile(s)

Signal Server is a very resource intensive multicore application. Only publish it for common use if you know what you are doing and you are advised to wrap it with another script to perform input validation.

Additional programs/scripts will be required to prepare inputs such as .sdf tiles (srtm2sdf.c), 3D antenna patterns (.ant) and user defined clutter (.udt) or manipulate the bitmap output (.ppm). More information can be found in the SPLAT! project.

## Installation
```
make
```

## Test
```
./test.sh
```

## Parameters
```
Version: Signal Server 3.05 (Built for 100 DEM tiles at 1200 pixels)
License: GNU General Public License (GPL) version 2

Radio propagation simulator by Alex Farrant QCVS, 2E0TDW
Based upon SPLAT! by John Magliacane, KD2BD

Usage: signalserver [data options] [input options] [output options] -o outputfile

Data:
     -sdf Directory containing SRTM derived .sdf DEM tiles
     -lid ASCII grid tile (LIDAR) with dimensions and resolution defined in header
     -udt User defined point clutter as decimal co-ordinates: 'latitude,longitude,height'
     -clt MODIS 17-class wide area clutter in ASCII grid format
Input:
     -lat Tx Latitude (decimal degrees) -70/+70
     -lon Tx Longitude (decimal degrees) -180/+180
     -txh Tx Height (above ground)
     -rla (Optional) Rx Latitude for PPA (decimal degrees) -70/+70
     -rlo (Optional) Rx Longitude for PPA (decimal degrees) -180/+180
     -f Tx Frequency (MHz) 20MHz to 100GHz (LOS after 20GHz)
     -erp Tx Effective Radiated Power (Watts) including Tx+Rx gain
     -rxh Rx Height(s) (optional. Default=0.1)
     -rxg Rx gain dBi (optional for text report)
     -hp Horizontal Polarisation (default=vertical)
     -gc Random ground clutter (feet/meters)
     -m Metric units of measurement
     -te Terrain code 1-6 (optional)
     -terdic Terrain dielectric value 2-80 (optional)
     -tercon Terrain conductivity 0.01-0.0001 (optional)
     -cl Climate code 1-6 (optional)
     -rel Reliability for ITM model 50 to 99 (optional)
     -resample Resample Lidar input to specified resolution in meters (optional)
Output:
     -dbm Plot Rxd signal power instead of field strength
     -rt Rx Threshold (dB / dBm / dBuV/m)
     -o Filename. Required. 
     -R Radius (miles/kilometers)
     -res Pixels per tile. 300/600/1200/3600 (Optional. LIDAR res is within the tile)
     -pm Propagation model. 1: ITM, 2: LOS, 3: Hata, 4: ECC33,
     	  5: SUI, 6: COST-Hata, 7: FSPL, 8: ITWOM, 9: Ericsson, 10: Plane earth, 11: Egli VHF/UHF
     -pe Propagation model mode: 1=Urban,2=Suburban,3=Rural
     -ked Knife edge diffraction (Already on for ITM)
Debugging:
     -t Terrain greyscale background
     -dbg Verbose debug messages
     -ng Normalise Path Profile graph
     -haf Halve 1 or 2 (optional)
     -nothreads Turn off threaded processing
```

### REFERENCE DATA
Signal server is designed for most of the environments and climates on Planet Earth but Polar region support is limited above extreme latitudes. (Svalbard is ok).
It can run with or without terrain data and can even be used to simulate radiation of other EM emissions like light.

#### -sdf 
##### Directory containing Digital Elevation Models (DEM)
SDF formatted tiles can be created by converting SRTM tiles (30m or 90m) in HGT format with the [srtm2sdf.c](https://www.google.co.uk/search?q=srtm2sdf.c) utility from SPLAT!. At the time of writing these tiles can be obtained for free from the [USGS website](https://dds.cr.usgs.gov/srtm/).


#### -lid 
##### WGS84 ASCII grid tile (LIDAR) with dimensions and resolution defined in header
LIDAR data can be used providing it is in ASCII grid format with WGS84 projection. Resolutions up to 25cm have been tested. 2m is recommended for a good trade off. Cellsize should be in degrees and co-ordinates must be in WGS84 decimal degrees.
To load multiple tiles use commas eg. -lid tile1.asc,tile2.asc. You can load in different resolution tiles and use -resample to set the desired resolution (limited by data limit).
```
ncols        2454
nrows        1467
xllcorner    -1.475333294357
yllcorner    53.378635095801
cellsize     0.000006170864
NODATA_value      0
 0 0 0 0 0 0 0 0 0 0 0 0 0 ...
```

#### -udt 
##### User defined CSV clutter file
This text file allows you to define buildings with co-ordinates and heights.
Elevations in the UDT file are evaluated and then copied into a temporary file under /tmp.  Then the contents of the temp file are scanned, and if found to be unique,
are added to the ground elevations described by the digital elevation data in memory. Height units are determined by appending M for meters or nothing for feet.
Format: latitude,longitude,height
```
54.555,-2.221,10M
54.555,-2.222,10M
54.555,-2.223,10M
```

### Antenna radiation pattern(s)
 Antenna  pattern  data is read from a pair of files having the same base name as the output file (-o), but with  .az  and .el  extensions  for azimuth and elevation patterns.  
```
045.0
0       0.8950590
1       0.8966406
2       0.8981447
3       0.8995795
4       0.9009535
5       0.9022749
```
The  first  line of the .az file specifies the direction measured clockwise in degrees from  True  North.  This is followed by azimuth headings (0 to 360 degrees) and their associated normalized field patterns (0.000 to 1.000) separated by whitespace.

The  structure of SPLAT! elevation pattern files is slightly different. The first line of the .el file specifies the amount of mechanical  beamtilt  applied  to  the  antenna.   A downward tilt is expressed as a positive angle, while an upward tilt is expressed as a negative angle.  This data is followed by the azimuthal direction of the tilt, separated by whitespace.
The remainder of the file consists of elevation angles and their radiation pattern (0.000 to 1.000) values separated by whitespace.  Elevation angles must  be  specified  over  a -10.0  to  +90.0  degree  range.  In  this  example,  the  antenna  is  tilted down 2
degrees towards an azimuth of 045.0 degrees.
```
2.0    045.0
-10.0   0.172
-9.5    0.109
-9.0    0.115
-8.5    0.155
-8.0    0.157
```

## Examples
	
### 90m resolution	
- INPUTS: 900MHz tower at 25m AGL with 5W ERP, 30km radius
- OUTPUTS: 1200 resolution, 30km radius, -90dBm receiver threshold, Longley Rice model
```
 ./signalserver -sdf /data/SRTM3 -lat 51.849 -lon -2.2299 -txh 25 -f 900 -erp 5 -rxh 2 -rt -90 -dbm -m -o test1 -R 30 -res 1200 -pm 1
```
### 30m resolution
- INPUTS: 450MHz tower at 25f AGL with 20W ERP, 10km radius
- OUTPUTS: 3600 resolution, 30km radius, 10dBuV receiver threshold, Hata model
```
./signalserverHD -sdf /data/SRTM1 -lat 51.849 -lon -2.2299 -txh 25 -f 450 -erp 20 -rxh 2 -rt 10 -o test2 -R 10 -res 3600 -pm 3
```

### 2m resolution (LIDAR)
- INPUTS: 1800MHz tower at 15m AGL with 1W ERP, 1 km radius
- OUTPUTS: 2m LIDAR resolution, 5km radius, -90dBm receiver threshold, Longley Rice model
```
./signalserverLIDAR -lid /data/LIDAR/Gloucester_2m.asc -lat 51.849 -lon -2.2299 -txh 15 -f 1800 -erp 1 -rxh 2 -rt -90 -dbm -m -o test3 -R 1 -pm 1
```
