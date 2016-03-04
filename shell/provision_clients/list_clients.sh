#!/bin/bash
account_file=$1
prefix=$2
output_file=$3
index=0

touch $output_file

## Read all available accounts and projects
declare -a accounts projects
while IFS=, read account project; do
	accounts[$index]=$account
	projects[$index]=$project
	echo "List servers with prefix $prefix in account $account and project $project !"
	gcloud config set account $account
	gcloud config set project $project
	gcloud compute instances list |grep $prefix |awk '{print $1","$5}' >> $output_file 
	index=$(($index+1))
done < $account_file
