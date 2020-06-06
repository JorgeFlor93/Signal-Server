#!/bin/bash
mkdir 10km
mkdir 50km
PM=1
FRQ=450

#signalserver command res = 1200, not HD

while [ $PM -le 11 ]
do
	if [[ $PM -ge 7 && $PM -lt 11 ]]; then 
		FRQ=1500 
	else 
		FRQ=450 
	fi
	echo "./signalserver Mode:$PM FRQ:$FRQ Radius 10km..."
	time ../signalserver -sdf ../data -lat 40.402770 -lon -3.710738 -txh 25 -f $FRQ -erp 20 -rxh 2 -rt 10 -o 10km/10_MODE:$PM -R 10 -res 1200 -pm $PM -pe 1
	echo "./signalserver Mode:$PM FRQ:$FRQ Radius 50km..."
	time ../signalserver -sdf ../data -lat 40.402770 -lon -3.710738 -txh 25 -f $FRQ -erp 20 -rxh 2 -rt 10 -o 50km/50_MODE:$PM -R 50 -res 1200 -pm $PM -pe 1
	let PM=PM+1
done



