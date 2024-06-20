resource "azurerm_service_plan" "this" {
  name                = format("asp-%s", local.resource_suffix_kebabcase)
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  os_type             = "Linux"
  sku_name            = var.app_service_plan_sku
  tags                = local.tags
}

resource "azurerm_linux_web_app" "this" {
  name                          = format("app-%s", local.resource_suffix_kebabcase)
  resource_group_name           = azurerm_resource_group.this.name
  location                      = azurerm_service_plan.this.location
  service_plan_id               = azurerm_service_plan.this.id
  public_network_access_enabled = false
  virtual_network_subnet_id     = data.terraform_remote_state.network.outputs.subnet_app_service_id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    
    application_stack {
      python_version = "3.9"
    }
  }
}
