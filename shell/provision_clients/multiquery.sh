#!/bin/bash
cmd=$*
cat clients_ips.csv | while IFS=, read -r a b; do
	srvName=$a
	srvIP=$b
	echo "ssh into remote server $srvName with ip $srvIP and execute command $cmd"
	ssh_cmd="ssh -i /home/senbof/.ssh/senbof-gce-ssh -n senbof@$srvIP $cmd"
	# echo $ssh_cmd
	$ssh_cmd
done
