resource "azurerm_container_registry" "acr" {
  name                = var.container_registry_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  admin_enabled       = true


  // ACR encryption can only be applied when using the Premium Sku.
  #   encryption {
  #     enabled            = true
  #     key_vault_key_id   = data.azurerm_key_vault_key.service-identity-generated-key.id
  #     identity_client_id = azurerm_user_assigned_identity.service-identity.client_id
  #   }

  depends_on = [
    azurerm_resource_group.rg
  ]

}


resource "azurerm_role_assignment" "k8_cluster_permission" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "acrpull"
  principal_id         = azurerm_kubernetes_cluster.k8.kubelet_identity[0].object_id

  depends_on = [
    azurerm_container_registry.acr,
    azurerm_kubernetes_cluster.k8
  ]
}

resource "null_resource" "docker_push" {
  provisioner "local-exec" {
    command = <<-EOT
        docker login ${azurerm_container_registry.acr.login_server} 
        docker push ${azurerm_container_registry.acr.login_server}
      EOT
  }
}