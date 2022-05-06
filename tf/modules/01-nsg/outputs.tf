# Output variable definitions
output "id" {
  description = "Network security group id"
  value       = azurerm_network_security_group.nsg.id
}