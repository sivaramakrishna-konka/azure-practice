#!/bin/bash
RG_NAME="vnetp"
SUBSCRIPTION_ID="7e309973-d2af-4e07-bfda-38c57b92643f"
LOCATION="eastus"
ADMIN_USERNAME="azure"
ADMIN_PASSWORD="Ravindrakoushik9@"

# Resource Group
az group create \
  --name $RG_NAME \
  --location $LOCATION \
  --subscription $SUBSCRIPTION_ID

# Vnets
az network vnet create \
  --resource-group $RG_NAME \
  --name ullagallu \
  --address-prefix 10.1.0.0/16 \
  --location eastus

az network vnet create \
  --resource-group $RG_NAME \
  --name addanki \
  --address-prefix 192.168.0.0/16 \
  --location eastus

az network vnet create \
  --resource-group $RG_NAME \
  --name darsi \
  --address-prefix 172.16.0.0/16 \
  --location westus

# Subnets
az network vnet subnet create \
  --resource-group $RG_NAME \
  --vnet-name ullagallu \
  --name ullagallu-subnet \
  --address-prefix 10.1.1.0/24

az network vnet subnet create \
  --resource-group $RG_NAME \
  --vnet-name addanki \
  --name addanki-subnet \
  --address-prefix 192.168.1.0/24

az network vnet subnet create \
  --resource-group $RG_NAME \
  --vnet-name darsi \
  --name darsi-subnet \
  --address-prefix 172.16.1.0/24
# NSGs
az network nsg create \
  --resource-group $RG_NAME \
  --name east-nsg \
  --location eastus
az network nsg rule create \
  --resource-group $RG_NAME \
  --nsg-name east-nsg  \
  --name AllowSSH \
  --priority 100 \
  --protocol Tcp \
  --destination-port-ranges '*' \
  --access Allow \
  --source-address-prefixes '*' \
  --destination-address-prefixes '*' \
  --direction Inbound

az network nsg create \
  --resource-group $RG_NAME \
  --name west-nsg \
  --location westus
az network nsg rule create \
  --resource-group $RG_NAME \
  --nsg-name west-nsg \
  --name AllowSSH \
  --priority 100 \
  --protocol Tcp \
  --destination-port-ranges '*' \
  --access Allow \
  --source-address-prefixes '*' \
  --destination-address-prefixes '*' \
  --direction Inbound
# vms
az vm create \
  --resource-group $RG_NAME \
  --name ullagallu-vm \
  --image Canonical:ubuntu-24_04-lts:server:latest \
  --admin-username $ADMIN_USERNAME \
  --admin-password $ADMIN_PASSWORD \
  --size Standard_B1s \
  --location eastus \
  --vnet-name ullagallu \
  --subnet ullagallu-subnet \
  --nsg east-nsg  \
  --public-ip-sku Standard

az vm create \
  --resource-group $RG_NAME \
  --name addanki-vm \
  --image Canonical:ubuntu-24_04-lts:server:latest \
  --admin-username $ADMIN_USERNAME \
  --admin-password $ADMIN_PASSWORD \
  --size Standard_B1s \
  --location eastus \
  --vnet-name addanki \
  --subnet addanki-subnet \
  --nsg east-nsg  \
  --public-ip-sku Standard

az vm create \
  --resource-group $RG_NAME \
  --name darsi-vm \
  --image Canonical:ubuntu-24_04-lts:server:latest \
  --admin-username $ADMIN_USERNAME \
  --admin-password $ADMIN_PASSWORD \
  --size Standard_B1s \
  --location westus \
  --vnet-name darsi \
  --subnet darsi-subnet \
  --nsg west-nsg  \
  --public-ip-sku Standard