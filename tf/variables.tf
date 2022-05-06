variable "resource_group_name" {
  type        = string
  default     = "paid"
  description = "name of the resource group"
}
variable "resource_group_location" {
  type        = string
  default     = "westeurope"
  description = "Location of the resource group."
}
variable "azurerm_key_vault_name" {
  type        = string
  default     = "kv-kms"
  description = "key vault name"
}
variable "container_registry_name" {
  type        = string
  default     = "privatecontainerregistry"
  description = "Name of the container registry"
}
