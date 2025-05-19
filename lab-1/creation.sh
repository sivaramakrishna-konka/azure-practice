#!/bin/bash
# Set variables
RG_NAME="siva"
SUBSCRIPTION_ID="7e309973-d2af-4e07-bfda-38c57b92643f"
VNET_NAME="siva-vnet"
SUBNET_NAME="siva-subnet-1"
NSG_NAME="siva-nsg"
VM_NAME="siva-vm"
LOCATION="eastus"
VNET_CIDR="10.1.0.0/16"
SUBNET_CIDR="10.1.1.0/24"
ADMIN_USERNAME="azure"
ADMIN_PASSWORD="Ravindrakoushik9@"

# 1. Create Resource Group
az group create \
  --name $RG_NAME \
  --location $LOCATION \
  --subscription $SUBSCRIPTION_ID

# 2. Apply Read-Only Lock to Resource Group

# 3. Create Virtual Network (VNet)
az network vnet create \
  --resource-group $RG_NAME \
  --name $VNET_NAME \
  --address-prefix $VNET_CIDR \
  --location $LOCATION

# 4. Create Subnet
az network vnet subnet create \
  --resource-group $RG_NAME \
  --vnet-name $VNET_NAME \
  --name $SUBNET_NAME \
  --address-prefix $SUBNET_CIDR

# 5. Create Network Security Group (NSG)
az network nsg create \
  --resource-group $RG_NAME \
  --name $NSG_NAME \
  --location $LOCATION

# 6. Create NSG Rules (Allow SSH on port 22 and HTTP on port 80 from anywhere)
az network nsg rule create \
  --resource-group $RG_NAME \
  --nsg-name $NSG_NAME \
  --name AllowSSH \
  --priority 100 \
  --protocol Tcp \
  --destination-port-ranges 22 80 \
  --access Allow \
  --source-address-prefixes '*' \
  --destination-address-prefixes '*' \
  --direction Inbound


# 7. Create Virtual Machine (Ubuntu 24.04 LTS)
az vm create \
  --resource-group $RG_NAME \
  --name $VM_NAME \
  --image Ubuntu Server 24.04 LTS - x64 Gen2 \
  --admin-username $ADMIN_USERNAME \
  --admin-password $ADMIN_PASSWORD \
  --size Standard_B1s \
  --location $LOCATION \
  --vnet-name $VNET_NAME \
  --subnet $SUBNET_NAME \
  --nsg $NSG_NAME \
  --public-ip-sku Standard \
  --no-wait