# Azure Firewall,Azure Network Gateway
- HUB-RG[10.1.0.0/16]
  - HUB-VNET
    - AzureFireWall-Subnet[10.1.10.0/24]
      - AzureFireWall
    - AzureNetwork-Gateway[10.1.20.0/24]
      - AzureNetowrkGateway
    - Windows-Subnet[10.1.1.0/24]
      - windows server
- ULLAGALLU-RG[172.16.0.0/16]
  - ULLAGALLU-SUBNET[172.16.10.0/24]
    - ULLAGALLU-VM
- ADDANKI-RG[192.168.0.0/16]
  - ADDANKI-SUBNET[192.168.10.0/24]
    - ADDANKI-VM

- PEERING BETWEEN ULLAGALLU TO HUB-VNET[Bidirectional]
- PEERING BETWEEN ADDANKI TO HUB-VNET[Bidirectional]

# AWS To test this lab we don't have any on-premises so create aws network
- VPC[10.2.0.0/16]
  - SUBN[10.2.1.0/24]
- Create VPG also 

- Enable VPN between AWS network and Azure Network

