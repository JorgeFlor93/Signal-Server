#!/bin/sh

#
# Requires:
#   - gdal_sieve.py
#   - ogr2ogr (GDAL)
#		- topojson (node.js)
# obtained from: https://gist.github.com/petesaia

# Grab the relative directory for source file.
SRC_DIR=`dirname $1`

# Which raster to compress.
ORG_FILE="$1"
ADD_COL="$2"

# Final output file.
OUTPUT_FILE="$1.json"

echo "Processing $ORG_FILE."

# Where to output the new file.
TMP_DIR=$SRC_DIR/tmp

# The amount of times the file should be passed over.
ITERATIONS=4

# Threshold for each iteration.
THRESHOLD=40

# TopoJSON area threshold for simplification.
TOPO_COMPRESSION=0.0001

# Setup internal vars.
_CUR=$THRESHOLD
_COMPRESSION=$(($ITERATIONS * $THRESHOLD))

#rm -rf $TMP_DIR
mkdir -p $TMP_DIR

# Start sieve passes.
gdal_sieve.py -st $THRESHOLD -4 $ORG_FILE $TMP_DIR/output-"$THRESHOLD".tiff

while [ $_CUR -le $_COMPRESSION ]; do
	let _PREV=$_CUR
	let _CUR=$_CUR+$THRESHOLD
	echo "Compressing output-$_PREV.tiff into $_CUR.tiff"
	gdal_sieve.py -st $THRESHOLD -4 "$TMP_DIR/output-$_PREV.tiff" \
		"$TMP_DIR/output-$_CUR.tiff"
	rm "$TMP_DIR/output-$_PREV.tiff"
done

# Raster to vector.
gdal_polygonize.py $TMP_DIR/output-"$_CUR".tiff \
	-f "ESRI Shapefile" $TMP_DIR vector n

if [ ! -z "$ADD_COL" ]; then
  echo "Adding $ADDCOL information"
  ogrinfo  "$TMP_DIR/vector.shp" -sql "ALTER TABLE vector ADD COLUMN fname character(32)"
  ogrinfo  "$TMP_DIR/vector.shp" -dialect SQLite -sql "UPDATE vector SET fname ='$ADD_COL'"
fi

# Change shapefile to geojson without the 0 layer, which is water. and simply to ~ 100m resolution
echo "Change shapefile to geojson without the 0 layer, which is water."
# and simply to ~ 100m resolution
# ogr2ogr -f "GeoJSON" -where "n != 0" "$TMP_DIR/geojson.json" "$TMP_DIR/vector.shp"
ogr2ogr -f "GeoJSON" "$TMP_DIR/geojson.json" "$TMP_DIR/vector.shp"
# Convert to compressed TopoJSON.
# topojson -o $OUTPUT_FILE --no-stitch-poles -s $TOPO_COMPRESSION \
#	-p -- "$TMP_DIR/geojson.json"

# Clean up.
#rm -rf $TMP_DIR
