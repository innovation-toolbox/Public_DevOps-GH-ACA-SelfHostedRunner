resource "azurerm_private_endpoint" "app_service" {
  name                = format("pe-app-%s", local.resource_suffix_kebabcase)
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = data.terraform_remote_state.network.outputs.subnet_paas_id

  private_dns_zone_group {
    name                 = "app-service-default"
    private_dns_zone_ids = [data.terraform_remote_state.network.outputs.private_dns_zone_web_id]
  }

  private_service_connection {
    is_manual_connection           = false
    name                           = format("pe-app-%s", local.resource_suffix_kebabcase)
    private_connection_resource_id = azurerm_linux_web_app.this.id
    subresource_names              = ["sites"]
  }

  depends_on = [
    azurerm_linux_web_app.this
  ]
}