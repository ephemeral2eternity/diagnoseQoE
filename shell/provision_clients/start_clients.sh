#!/bin/bash
vm_zone="europe-west1-b"
image="dashclient"

for i in {1..10};
do
	vmname="client$i"
	echo "Provision VM $vmname in zone $vm_zone using image $image !"
done
