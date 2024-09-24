#! /usr/bin/env bash
VMName="exam3"
RG="examgroup"
az group create --name $RG --location norwayeast
az vm create --resource-group $RG --name $VMName --image Ubuntu2204 --admin-username azureuser --generate-ssh-keys --size Standard_B1s --custom-data @docker-init.sh
az vm open-port --resource-group $RG --name $VMName --port 8080
IP=$(az vm show -d -g $RG -n $VMName --query publicIps -o tsv)
echo "$VMName IP: $IP."