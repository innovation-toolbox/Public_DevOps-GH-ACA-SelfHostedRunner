resource "azurerm_private_endpoint" "acr" {
  location            = azurerm_resource_group.this.location
  name                = format("pe-acr-%s", local.resource_suffix_kebabcase)
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = azurerm_subnet.subnet_paas.id

  private_dns_zone_group {
    name                 = "acr-default"
    private_dns_zone_ids = [azurerm_private_dns_zone.container_registry.id]
  }

  private_service_connection {
    is_manual_connection           = false
    name                           = format("pe-acr-%s", local.resource_suffix_kebabcase)
    private_connection_resource_id = azurerm_container_registry.this.id
    subresource_names              = ["registry"]
  }

  depends_on = [
    azurerm_container_registry.this
  ]
}