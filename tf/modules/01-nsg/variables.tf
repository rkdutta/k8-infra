# Input variable definitions

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}
variable "resource_group_location" {
  description = "location of the resource group"
  type        = string
}
variable "network_security_group_name" {
  description = "location of the resource group"
  type        = string
}

variable "security_rule" {
  description = "default rules"
  type = list(object({
    name                                       = string
    priority                                   = number
    direction                                  = string
    access                                     = string
    protocol                                   = string
    source_port_range                          = string
    destination_port_range                     = string
    source_address_prefix                      = string
    destination_address_prefix                 = string
    description                                = string
    destination_address_prefixes               = list(string)
    destination_application_security_group_ids = list(string)
    destination_port_ranges                    = list(string)
    source_address_prefixes                    = list(string)
    source_application_security_group_ids      = list(string)
    source_port_ranges                         = list(string)

  }))

  default = [{
    name                                       = "allow-tcp"
    priority                                   = 100
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_port_range                          = "*"
    destination_port_range                     = "*"
    source_address_prefix                      = "*"
    destination_address_prefix                 = "*"
    description                                = "default tcp rule"
    destination_address_prefixes               = []
    destination_application_security_group_ids = []
    destination_port_ranges                    = []
    source_address_prefixes                    = []
    source_application_security_group_ids      = []
    source_port_ranges                         = []
  }]

}