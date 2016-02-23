#!/bin/bash
f=$1

cat $f | while read LINE; do
	metric=$LINE
	echo $metric
	pmdumptext -t 1sec -m -u -S @13:00 -T @03:28 $metric -d , -a /var/log/pcp/pmlogger/senbof-01/20160222.13.28.0 > ~/rsts/$metric.csv
done
