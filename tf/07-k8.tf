//aks
data "azurerm_virtual_network" "vnet_spoke" {
  name                = azurerm_virtual_network.vnet_spoke.name
  resource_group_name = azurerm_virtual_network.vnet_spoke.resource_group_name
  depends_on = [
    azurerm_virtual_network.vnet_spoke
  ]
}

data "azurerm_subnet" "vnet_spoke" {
  for_each             = toset(data.azurerm_virtual_network.vnet_spoke.subnets)
  name                 = each.value
  virtual_network_name = data.azurerm_virtual_network.vnet_spoke.name
  resource_group_name  = data.azurerm_virtual_network.vnet_spoke.resource_group_name

  depends_on = [
    data.azurerm_virtual_network.vnet_spoke
  ]
}

resource "azurerm_kubernetes_cluster" "k8" {
  name                                = "private-aks"
  location                            = azurerm_resource_group.rg.location
  resource_group_name                 = azurerm_resource_group.rg.name
  dns_prefix                          = "private-aks"
  node_resource_group                 = "MC_paid_private_aks"
  public_network_access_enabled       = false
  private_cluster_enabled             = true
  sku_tier                            = "Free"
  azure_policy_enabled                = true
  role_based_access_control_enabled   = true
  private_cluster_public_fqdn_enabled = false
  private_dns_zone_id                 = "System"


  azure_active_directory_role_based_access_control {
    managed                = true
    admin_group_object_ids = ["aae7ddcf-1437-44cf-a7f3-feb6d511140f"]
    azure_rbac_enabled     = true
    tenant_id              = data.azurerm_client_config.current.tenant_id
  }

  auto_scaler_profile {
    scan_interval = "60s"
  } 

  default_node_pool {
    name = "controlplane"
    //node_count = 1
    min_count                    = 2
    max_count                    = 3
    vm_size                      = "Standard_B2s"
    os_disk_size_gb              = 30
    enable_auto_scaling          = true
    type                         = "VirtualMachineScaleSets"
    zones                        = [1, 2, 3]
    node_taints                  = ["CriticalAddonsOnly=true:NoSchedule"]
    vnet_subnet_id               = data.azurerm_subnet.vnet_spoke["NodepoolSubnet"].id
    only_critical_addons_enabled = true
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "calico"

    dns_service_ip     = "10.0.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
    service_cidr       = "10.0.0.0/16"

    load_balancer_sku = "standard"
    #outbound_type     = "loadBalancer"
    outbound_type = "userDefinedRouting"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    tier = "Production",
    type = "Controlplane"
  }

  depends_on = [
    azurerm_key_vault.akv,
    azurerm_resource_group.rg,
    azurerm_virtual_network.vnet_spoke
  ]

}


resource "azurerm_kubernetes_cluster_node_pool" "k8_cluster_node_pool" {
  name                  = "worker1"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8.id
  vm_size               = "Standard_B2s"
  //node_count            = 0
  min_count           = 2
  max_count           = 3
  vnet_subnet_id      = data.azurerm_subnet.vnet_spoke["NodepoolSubnet"].id
  os_disk_size_gb     = 30
  enable_auto_scaling = true
  zones               = [1, 2, 3]
  node_taints         = []

  tags = {
    tier = "Production",
    type = "worker"
  }
  depends_on = [
    azurerm_kubernetes_cluster.k8,
    azurerm_resource_group.rg,
    azurerm_virtual_network.vnet_spoke
  ]
}


//temporary block as it is in public review
//local user should have manager identity operator permission
resource "null_resource" "enable_pod_identity" {
  provisioner "local-exec" {
    command = <<-EOT
        az aks update -g ${azurerm_resource_group.rg.name} -n ${azurerm_kubernetes_cluster.k8.name} --enable-pod-identity
      EOT
  }
  depends_on = [
    azurerm_kubernetes_cluster.k8
  ]
}