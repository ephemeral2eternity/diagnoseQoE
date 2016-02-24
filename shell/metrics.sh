#!/bin/bash

csvfile=$1

data=$(
	while read line
	do
		echo -n "'${line}' "
	done < $csvfile
)

echo $data

pmdumptext -t 1sec -m -u -S @13:00 -T @03:28 $data -d , -a /var/log/pcp/pmlogger/senbof-01/20160222.0 > ~/rsts/all.csv
