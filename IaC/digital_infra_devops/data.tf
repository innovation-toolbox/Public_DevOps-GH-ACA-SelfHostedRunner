data "azurerm_client_config" "current" {}

data "terraform_remote_state" "share" {
  backend = "azurerm"
  config = {
    storage_account_name = var.storage_account_name
    container_name       = var.storage_account_container_name
    key                  = "share/terraform.state"
    use_azuread_auth     = true
    subscription_id      = data.azurerm_client_config.current.subscription_id
    tenant_id            = data.azurerm_client_config.current.tenant_id
  }
}

data "terraform_remote_state" "network" {
  backend = "azurerm"
  config = {
    storage_account_name = var.storage_account_name
    container_name       = var.storage_account_container_name
    key                  = "network/terraform.state"
    use_azuread_auth     = true
    subscription_id      = data.azurerm_client_config.current.subscription_id
    tenant_id            = data.azurerm_client_config.current.tenant_id
  }
}