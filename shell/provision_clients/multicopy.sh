#!/bin/bash
echo "VM List file: clients_ips.csv"
srcFile=$1
dstFile=$2
echo "Copy from remote server file $srcFile to local file $dstFile !"
cat client_ips.csv | while IFS=, read -r a b; do
	srvName=$a
	srvIP=$b
	echo "scp from $srvName in folder $srcFile to localfolder $dstFile"
	scp -r -i ~/.ssh/senbof-gce-ssh senbof@$srvIP:$srcFile $dstFile
done
