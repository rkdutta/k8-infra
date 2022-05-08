resource "azurerm_bastion_host" "aks_bastion_host" {
  name                = "vm-bastion"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.vnet_hub["AzureBastionSubnet"].id
    public_ip_address_id = azurerm_public_ip.aks_bastion_host_ip.id
  }
  depends_on = [
    azurerm_resource_group.rg,
    azurerm_virtual_network.vnet_hub,
    azurerm_public_ip.aks_bastion_host_ip
  ]
}