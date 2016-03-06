#!/bin/bash
cmd=$*
cat client_ips.csv | while IFS=, read -r a b; do
	srvName=$a
	srvIP=$b
	# echo "ssh into remote server $srvName with ip $srvIP and execute command $cmd"
	ssh -q -i /home/senbof/.ssh/senbof-gce-ssh -n senbof@$srvIP "$cmd"
	# echo $ssh_cmd
	# $ssh_cmd
done
