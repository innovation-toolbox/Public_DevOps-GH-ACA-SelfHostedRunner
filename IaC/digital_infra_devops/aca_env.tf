resource "azurerm_container_app_environment" "this" {
  name                           = format("cae-%s", local.resource_suffix_kebabcase)
  location                       = azurerm_resource_group.this.location
  resource_group_name            = azurerm_resource_group.this.name
  log_analytics_workspace_id     = data.terraform_remote_state.share.outputs.log_analytics_workspace_id
  infrastructure_subnet_id       = data.terraform_remote_state.network.outputs.subnet_container_apps_environment_id
  internal_load_balancer_enabled = true
  tags                           = local.tags
}
