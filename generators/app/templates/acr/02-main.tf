############################### AZURE CONTAINER REGISTRY ##############################################

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.acr_sku
  admin_enabled       = true
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "attach_acr_to_aks" {
  principal_id                     = data.azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}
