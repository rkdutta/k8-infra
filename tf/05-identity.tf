resource "azurerm_user_assigned_identity" "kv_vault_managed_identity" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  name                = "id-akv-managed-identity"
  depends_on = [
    azurerm_resource_group.rg,
    azurerm_key_vault.akv
  ]
}

resource "azurerm_role_assignment" "kv_vault_managed_identity_secret_reader" {
  scope                = azurerm_key_vault.akv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.kv_vault_managed_identity.principal_id
  depends_on = [
    azurerm_key_vault.akv,
    azurerm_resource_group.rg
  ]
}

resource "null_resource" "k8_default_namespace_pod_identity_binding_permission-new" {
  provisioner "local-exec" {
    command = <<-EOT
        az aks pod-identity add --resource-group ${azurerm_resource_group.rg.name} --cluster-name ${azurerm_kubernetes_cluster.k8.name} --namespace default  --name id-default-ns-pod-identity --identity-resource-id ${azurerm_user_assigned_identity.kv_vault_managed_identity.id}
      EOT
  }
  depends_on = [
    azurerm_kubernetes_cluster.k8,
    azurerm_user_assigned_identity.kv_vault_managed_identity,
    null_resource.enable_pod_identity
  ]
}

resource "azurerm_role_assignment" "kv_vault_managed_identity_key_reader" {
  scope                = azurerm_key_vault.akv.id
  role_definition_name = "Key Vault Crypto User"
  principal_id         = azurerm_user_assigned_identity.kv_vault_managed_identity.principal_id
  depends_on = [
    azurerm_key_vault.akv,
    azurerm_resource_group.rg
  ]
}

resource "null_resource" "k8_flux_pod_identity_binding_permission" {
  provisioner "local-exec" {
    command = <<-EOT
        az aks pod-identity add --resource-group ${azurerm_resource_group.rg.name} --cluster-name ${azurerm_kubernetes_cluster.k8.name} --namespace flux-system  --name id-flux-system-pod-identity --identity-resource-id ${azurerm_user_assigned_identity.kv_vault_managed_identity.id}
      EOT
  }
  depends_on = [
    azurerm_kubernetes_cluster.k8,
    azurerm_user_assigned_identity.kv_vault_managed_identity,
    null_resource.enable_pod_identity
  ]
}