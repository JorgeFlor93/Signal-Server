Format used by Signal-Server for LIDAR is as follows:

GDAL Driver AAIGrid
Type Int32

Projection EPSG:4326

Pacific Northwest LIDAR comes in esri .e00 format.  To get it into a usable form 
we can use gdal tools.

Reproject the source data to EPSG:4326   (GRS84, lat/long)
gdalwarp -t_srs EPSG:4326 -of GS7BG  -ot Float64 srcfile.e00 destfile.xyz

[user@host ~]$ gdalwarp -t_srs EPSG:4326 -of GS7BG  -ot Float64 ~/q47122a71.e00 ~/q47122a71.xyz

Convert the intermedatry file to AAIGrid Int32
gdal_translate -of AAIGrid  -ot Int32 srcfile.xyz destfile.asc

[user@host ~]$ gdal_translate -of AAIGrid  -ot Int32 ~/q47122a71.xyz ~/q47122a71.asc

The above could be pipelined to reduce intermedaty files.
