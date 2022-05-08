resource "azurerm_public_ip" "aks_firewall_public_IP" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }

  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_public_ip" "aks_bastion_host_ip" {
  name                = "ip-bastion"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"

  depends_on = [
    azurerm_resource_group.rg,
    azurerm_virtual_network.vnet_hub,
    azurerm_kubernetes_cluster.k8
  ]

}