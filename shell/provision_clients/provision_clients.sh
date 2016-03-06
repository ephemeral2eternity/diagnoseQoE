#!/bin/bash
client_file=$1
image="dashclient"

while IFS=, read server zone account project; do
	echo "#########################################################################################################"
	echo "Set the account and the project as: $account , $project !"
	gcloud config set account $account
	gcloud config set project $project
	# Add chenw-gcloud.txt as keys to all the projects
	gcloud compute project-info add-metadata --metadata-from-file sshKeys=senbof-pub.txt
	echo "Provision cache agent $server in zone $zone !"
	gcloud compute instances create $server --image dashclient --machine-type f1-micro --can-ip-forward --network default --scope cloud-platform,logging-write,compute-rw,storage-full,userinfo-email --zone=$zone
done < $client_file
