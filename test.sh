#!/bin/bash
mkdir tests2
RAD=10
MAXRAD=50
FRQ=446
ERP=25

while [ $RAD -le $MAXRAD ]; do
	echo "Calculating $FRQ MHz @ $ERP Watts for $RAD km radius..."
	time ./signalserver -m -sdf data -lat 51.5 -lon -0.50 -txh 15 -rxh 2 -m -dbm -rt -100 -R $RAD -erp $ERP -f $FRQ -o tests2/$RAD -pm 1 -res 1200 -t
	convert tests2/$RAD.ppm tests2/$RAD.png
#	rm tests/$RAD.ppm
#	rm tests/$RAD.*cf

        echo "Calculating $FRQ MHz @ $ERP Watts for $RAD km radius (HD mode)..."
        time ./signalserverHD -m -sdf data -lat 51.5 -lon -0.50 -txh 15 -rxh 2 -m -dbm -rt -100 -R $RAD -erp $ERP -f $FRQ -o tests2/$RAD.hd -pm 1 -res 3600 -t
        convert tests2/$RAD.hd.ppm tests2/$RAD.hd.png
#        rm tests/$RAD.hd.ppm
#        rm tests/$RAD.*cf
        let RAD=RAD+40
done


