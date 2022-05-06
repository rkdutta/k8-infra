data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "akv" {
  name                       = "kv-kms"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  enable_rbac_authorization  = true
  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_role_assignment" "secret_officer" {
  scope                = azurerm_key_vault.akv.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = "aae7ddcf-1437-44cf-a7f3-feb6d511140f"
  depends_on = [
    azurerm_key_vault.akv,
    azurerm_resource_group.rg
  ]
}


resource "azurerm_key_vault_secret" "testing" {
  name         = "secret-11"
  value        = "szechuan"
  key_vault_id = azurerm_key_vault.akv.id
  depends_on = [
    azurerm_key_vault.akv,
    azurerm_role_assignment.secret_officer
  ]
}

//create secret for flux-ssh for each environment (prod,stage,testing)
resource "azurerm_key_vault_key" "ssh_key_flux" {
  name         = "key-flux-production"
  key_vault_id = azurerm_key_vault.akv.id
  key_type     = "RSA"
  key_size     = 4096

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}


