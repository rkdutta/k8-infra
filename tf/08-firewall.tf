data "azurerm_virtual_network" "vnet_hub" {
  name                = azurerm_virtual_network.vnet_hub.name
  resource_group_name = azurerm_virtual_network.vnet_hub.resource_group_name
  depends_on = [
    azurerm_virtual_network.vnet_hub
  ]
}

data "azurerm_subnet" "vnet_hub" {
  for_each             = toset(data.azurerm_virtual_network.vnet_hub.subnets)
  name                 = each.value
  virtual_network_name = data.azurerm_virtual_network.vnet_hub.name
  resource_group_name  = data.azurerm_virtual_network.vnet_hub.resource_group_name

  depends_on = [
    data.azurerm_virtual_network.vnet_hub
  ]

}

resource "azurerm_firewall" "aks_firewall" {
  name                = "aks-firewall"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "AZFW_Hub"
  sku_tier            = "Standard"
  zones               = []
  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.vnet_hub["AzureFirewallSubnet"].id
    public_ip_address_id = azurerm_public_ip.aks_firewall_public_IP.id
  }
  depends_on = [
    azurerm_resource_group.rg,
    azurerm_virtual_network.vnet_hub
  ]
}