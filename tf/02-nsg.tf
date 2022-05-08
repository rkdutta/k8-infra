module "spoke_acr_privatelinkendpoints_nsg" {
  source                      = "./modules/01-nsg"
  resource_group_name         = azurerm_resource_group.rg.name
  resource_group_location     = azurerm_resource_group.rg.location
  network_security_group_name = "nsg-acr-privatelinkendpoint"
  security_rule = [
    {
      name                                       = "AllowAll443InFromVnet"
      priority                                   = 1001
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_range                     = "443"
      source_address_prefix                      = "VirtualNetwork"
      destination_address_prefix                 = "VirtualNetwork"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_ranges                    = []
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_ranges                         = []
      description                                = ""
      destination_port_range                     = "*"
      }, {
      name                                       = "DenyAllInbound"
      priority                                   = 1002
      direction                                  = "Inbound"
      access                                     = "Deny"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = "*"
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_ranges                    = []
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_ranges                         = []
      description                                = ""
      destination_port_range                     = "*"
    },
    {
      name                                       = "DenyAllOutbound"
      priority                                   = 1003
      direction                                  = "Inbound"
      access                                     = "Deny"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = "*"
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_ranges                    = []
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_ranges                         = []
      description                                = ""
      destination_port_range                     = "*"
    }
  ]
  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "spoke_application_gateway_nsg" {
  source                      = "./modules/01-nsg"
  resource_group_name         = azurerm_resource_group.rg.name
  resource_group_location     = azurerm_resource_group.rg.location
  network_security_group_name = "nsg-spoke-application-gateway"
  security_rule = [
    {
      name                                       = "Allow443Inbound"
      priority                                   = 1001
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_range                     = "443"
      source_address_prefix                      = "Internet"
      destination_address_prefix                 = "VirtualNetwork"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_ranges                    = []
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_ranges                         = []
      description                                = ""
      destination_port_range                     = "*"
      }, {
      name                                       = "AllowControlPlaneInbound"
      priority                                   = 1002
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = "GatewayManager"
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_ranges                    = []
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_ranges                         = []
      description                                = ""
      destination_port_range                     = "65200-65535"
    },
    {
      name                                       = "AllowAllOutbound"
      priority                                   = 1003
      direction                                  = "Outbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = "*"
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_ranges                    = []
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_ranges                         = []
      description                                = ""
      destination_port_range                     = "*"
    },
    {
      name                                       = "AllowAllOutbound"
      priority                                   = 1003
      direction                                  = "Outbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = "*"
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_ranges                    = []
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_ranges                         = []
      description                                = ""
      destination_port_range                     = "*"
    }
  ]
  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "spoke_cluster_nodes_nsg" {
  source                      = "./modules/01-nsg"
  resource_group_name         = azurerm_resource_group.rg.name
  resource_group_location     = azurerm_resource_group.rg.location
  network_security_group_name = "nsg-spoke-cluster-nodes"
  security_rule = [
    {
      name                                       = "Allow443Inbound"
      priority                                   = 1001
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_range                     = "443"
      source_address_prefix                      = "Internet"
      destination_address_prefix                 = "VirtualNetwork"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_ranges                    = []
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_ranges                         = []
      description                                = ""
      destination_port_range                     = "*"
      }, {
      name                                       = "AllowControlPlaneInbound"
      priority                                   = 1002
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = "GatewayManager"
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_ranges                    = []
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_ranges                         = []
      description                                = ""
      destination_port_range                     = "65200-65535"
    },
    {
      name                                       = "AllowAllOutbound"
      priority                                   = 1003
      direction                                  = "Outbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = "*"
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_ranges                    = []
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_ranges                         = []
      description                                = ""
      destination_port_range                     = "*"
    },
    {
      name                                       = "AllowAllOutbound"
      priority                                   = 1003
      direction                                  = "Outbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = "*"
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_ranges                    = []
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_ranges                         = []
      description                                = ""
      destination_port_range                     = "*"
    }
  ]
  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "spoke_cluster_ingress_nsg" {
  source                      = "./modules/01-nsg"
  resource_group_name         = azurerm_resource_group.rg.name
  resource_group_location     = azurerm_resource_group.rg.location
  network_security_group_name = "nsg-spoke-cluster-ingress"
  security_rule = [
    {
      name                                       = "Allow443Inbound"
      priority                                   = 1001
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_range                     = "443"
      source_address_prefix                      = "Internet"
      destination_address_prefix                 = "VirtualNetwork"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_ranges                    = []
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_ranges                         = []
      description                                = ""
      destination_port_range                     = "*"
      }, {
      name                                       = "AllowControlPlaneInbound"
      priority                                   = 1002
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = "GatewayManager"
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_ranges                    = []
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_ranges                         = []
      description                                = ""
      destination_port_range                     = "65200-65535"
    },
    {
      name                                       = "AllowAllOutbound"
      priority                                   = 1003
      direction                                  = "Outbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = "*"
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_ranges                    = []
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_ranges                         = []
      description                                = ""
      destination_port_range                     = "*"
    },
    {
      name                                       = "AllowAllOutbound"
      priority                                   = 1003
      direction                                  = "Outbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = "*"
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_ranges                    = []
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_ranges                         = []
      description                                = ""
      destination_port_range                     = "*"
    }
  ]
  depends_on = [
    azurerm_resource_group.rg
  ]
}
module "bastion_nsg" {
  source                      = "./modules/01-nsg"
  resource_group_name         = azurerm_resource_group.rg.name
  resource_group_location     = azurerm_resource_group.rg.location
  network_security_group_name = "nsg-bastion"
  security_rule = [
    {
      name                                       = "GatewayManager"
      priority                                   = 1001
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_range                     = "443"
      source_address_prefix                      = "GatewayManager"
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_ranges                    = []
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_ranges                         = []
      description                                = ""
      destination_port_range                     = "*"
    },
    {
      name                                       = "Internet-Bastion-PublicIP"
      priority                                   = 1002
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_range                     = "443"
      source_address_prefix                      = "*"
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_ranges                    = []
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_ranges                         = []
      description                                = ""
      destination_port_range                     = "*"
      }, {
      name                                       = "OutboundVirtualNetwork"
      priority                                   = 1001
      direction                                  = "Outbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_ranges                    = ["22", "3389"]
      source_address_prefix                      = "*"
      destination_address_prefix                 = "VirtualNetwork"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_ranges                    = []
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_ranges                         = []
      description                                = ""
      destination_port_range                     = "*"
      }, {
      name                                       = "OutboundToAzureCloud"
      priority                                   = 1002
      direction                                  = "Outbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_range                     = "443"
      source_address_prefix                      = "*"
      destination_address_prefix                 = "AzureCloud"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_ranges                    = []
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_ranges                         = []
      description                                = ""
      destination_port_range                     = "*"
    }
  ]
  depends_on = [
    azurerm_resource_group.rg
  ]
}