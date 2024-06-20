resource "azurerm_user_assigned_identity" "container_app_job_identity" {
  location            = azurerm_resource_group.this.location
  name                = format("id-aca-job-%s", local.resource_suffix_kebabcase)
  resource_group_name = azurerm_resource_group.this.name
}
