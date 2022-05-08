resource "azurerm_virtual_network" "vnet_hub" {
  name                = "vnet_hub"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.200.0.0/24"]

  subnet {
    name           = "AzureFirewallSubnet"
    address_prefix = "10.200.0.0/26"

  }
  subnet {
    name           = "AzureBastionSubnet"
    address_prefix = "10.200.0.64/27"
    security_group = module.bastion_nsg.id
  }
  subnet {
    name           = "GatewaySubnet"
    address_prefix = "10.200.0.96/27"
  }

  tags = {
    component = "hub"
  }

  depends_on = [
    azurerm_resource_group.rg,
    module.bastion_nsg
  ]
}
locals {
  hub_subnets = [
    azurerm_virtual_network.vnet_hub.subnet.*.id,
    azurerm_virtual_network.vnet_hub.subnet.*.name
  ]
}
output "AzureFirewallSubnet_id" {

  value = matchkeys(local.hub_subnets[0], local.hub_subnets[1], ["AzureFirewallSubnet"])[0]
}
output "AzureBastionSubnet_id" {

  value = matchkeys(local.hub_subnets[0], local.hub_subnets[1], ["AzureBastionSubnet"])[0]
}
output "GatewaySubnet_id" {

  value = matchkeys(local.hub_subnets[0], local.hub_subnets[1], ["GatewaySubnet"])[0]
}

resource "azurerm_virtual_network" "vnet_spoke" {
  name                = "vnet_spoke"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.240.0.0/16"]

  subnet {
    name           = "ACRSubnet"
    address_prefix = "10.240.4.32/28"
    security_group = module.spoke_acr_privatelinkendpoints_nsg.id
  }
  subnet {
    name           = "ApplicationGatewaySubnet"
    address_prefix = "10.240.4.16/28"
    security_group = module.spoke_application_gateway_nsg.id
  }
  subnet {
    name           = "IngressSubnet"
    address_prefix = "10.240.4.0/28"
    security_group = module.spoke_cluster_ingress_nsg.id
  }
  subnet {
    name           = "NodepoolSubnet"
    address_prefix = "10.240.0.0/22"
    security_group = module.spoke_cluster_nodes_nsg.id
  }
  tags = {
    component = "spoke"
  }
  depends_on = [
    azurerm_resource_group.rg,
    module.spoke_cluster_nodes_nsg,
    module.spoke_cluster_ingress_nsg,
    module.spoke_application_gateway_nsg,
    module.spoke_acr_privatelinkendpoints_nsg
  ]
}
locals {
  spoke_subnets = [
    azurerm_virtual_network.vnet_spoke.subnet.*.id,
    azurerm_virtual_network.vnet_spoke.subnet.*.name
  ]
}

output "ACRSubnet_id" {

  value = matchkeys(local.spoke_subnets[0], local.spoke_subnets[1], ["ACRSubnet"])[0]
}
output "ApplicationGatewaySubnet_id" {

  value = matchkeys(local.spoke_subnets[0], local.spoke_subnets[1], ["ApplicationGatewaySubnet"])[0]
}
output "IngressSubnet_id" {

  value = matchkeys(local.spoke_subnets[0], local.spoke_subnets[1], ["IngressSubnet"])[0]
}
output "NodepoolSubnet_id" {

  value = matchkeys(local.spoke_subnets[0], local.spoke_subnets[1], ["NodepoolSubnet"])[0]
}

resource "azurerm_virtual_network_peering" "vnetPeeringHubToSpoke" {
  name                      = "peer-hub-spoke"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet_hub.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_spoke.id

  depends_on = [
    azurerm_resource_group.rg,
    azurerm_virtual_network.vnet_hub,
    azurerm_virtual_network.vnet_spoke
  ]
}

resource "azurerm_virtual_network_peering" "vnetPeeringSpokeToHub" {
  name                      = "peer-spoke-hub"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet_spoke.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_hub.id
  depends_on = [
    azurerm_resource_group.rg,
    azurerm_virtual_network.vnet_hub,
    azurerm_virtual_network.vnet_spoke
  ]
}
