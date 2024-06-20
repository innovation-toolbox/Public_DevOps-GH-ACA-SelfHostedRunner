resource "azurerm_role_assignment" "container_app_job_acr_pull" {
  principal_id         = azurerm_user_assigned_identity.container_app_job_identity.principal_id
  role_definition_name = "AcrPull"
  scope                = data.terraform_remote_state.network.outputs.container_registry_id
}