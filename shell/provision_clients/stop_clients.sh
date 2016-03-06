#!/bin/bash
info_file=$1
index=0

## Read accounts and their corresponding projects
declare -a vms zones accounts projects
while IFS=, read vm zone account project; do
	vms[$index]=$vm
	zones[$index]=$zone
	accounts[$index]=$account
	projects[$index]=$project
	echo " Stopping $index instance: $vm $zone $account $project "
	echo " Configure the account and the project as: $account , $project "
	gcloud config set account $account
	gcloud config set project $project
	gcloud config set compute/zone $zone
	gcloud compute instances stop $vm
	index=$(($index+1))
done < $info_file

echo " All stoped vms ${vms[@]} "
echo " All zones: ${zones[@]} "
echo " All accounts: ${accounts[@]} "
echo " All projects: ${projects[@]} "
