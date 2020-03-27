#!/bin/bash
mkdir tests
RAD=5
MAXRAD=50
FRQ=446
ERP=25

echo "Running 50cm LIDAR test..."
./signalserverLIDAR -lid data/sk3587_50cm.asc -lat 53.383 -lon -1.468 -txh 8 -f $FRQ -erp 1 -rxh 2 -m -dbm -rt -90 -o tests/1 -R 0.5 -t
echo "Converting to PNG..."
convert tests/1.ppm -transparent white -channel Alpha PNG32:tests/1.png

echo "Running 30m Meridian test..."
./signalserverLIDAR -lid data/N051E000_AVE_DSM.tif.asc,data/N051W001_AVE_DSM.tif.asc -lat 51.472 -lon 0.0096 -txh 12 -f $FRQ -erp 5 -rxh 2 -m -dbm -rt -100 -o tests/2 -R 10 -t
echo "Converting to PNG..."
convert tests/2.ppm -transparent white -channel Alpha PNG32:tests/2.png


echo "Running soak test out to $MAXRAD"

while [ $RAD -lt $MAXRAD ]; do
	echo "Calculating $FRQ MHz @ $ERP Watts for $RAD km radius..."
	time ./signalserver -m -sdf data -lat 51.5 -lon -0.50 -txh 15 -rxh 2 -m -dbm -rt -100 -R $RAD -erp $ERP -f $FRQ -o tests/$RAD -pm 1 -res 1200 -t
	convert tests/$RAD.ppm tests/$RAD.png
	rm tests/$RAD.ppm
	rm tests/$RAD.*cf

        echo "Calculating $FRQ MHz @ $ERP Watts for $RAD km radius (HD mode)..."
        time ./signalserverHD -m -sdf data -lat 51.5 -lon -0.50 -txh 15 -rxh 2 -m -dbm -rt -100 -R $RAD -erp $ERP -f $FRQ -o tests/$RAD.hd -pm 1 -res 3600 -t
        convert tests/$RAD.hd.ppm tests/$RAD.hd.png
        rm tests/$RAD.hd.ppm
        rm tests/$RAD.*cf
        let RAD=RAD+5
done


