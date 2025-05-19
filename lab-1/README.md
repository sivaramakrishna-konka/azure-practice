# Notes
# Class-1
- Small Intro 
# Class-2
1. Azure Hierarchy
Tenant ID
office 365 azure cloud  Microsoft dynamics single tenant for all Microsoft products
subscription on azure cloud[We have multiple subscriptions like dev, stage, prod]
RG[Collections of Resources][like subscriptions we have multiple RG]
- Vnet
- vm
- nsg ....
Region[Central India]
Zones[zone-1,zone-2,zone-3]
# Class-3
- Must Define RG in one region but resources in RG can be another region also
- RG is a Collection of resources
- To avoid unintend deletion of RG we just apply the locks
  - We have to types of locks[read-only,delete]
# Lab
1. Create RG siva
2. Create Vnet siva IP address range 10.1.0.0/16
   - Create 3 subnets 10.1.1.0/24 10.1.2.0/24 10.1.3.0/24
3. Create NSG
   add rule 100 allow 22 and 80 from anywhere
4. Launch VM with on vnet with above NSG and on above Subnets
5. First create all the above resources manually
6. Then using azure cli commands
7. Entire Lab can be practice like 5 and 6
8. During Project InfrassetUp use terraform