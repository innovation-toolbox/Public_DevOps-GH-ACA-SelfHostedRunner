resource "azurerm_private_dns_zone_virtual_network_link" "container_registry" {
  name                  = format("pdzvnl-cr-%s", local.resource_suffix_kebabcase)
  private_dns_zone_name = azurerm_private_dns_zone.container_registry.name
  resource_group_name   = azurerm_private_dns_zone.container_registry.resource_group_name
  virtual_network_id    = azurerm_virtual_network.this.id
  tags                  = local.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "web" {
  name                  = format("pdzvnl-%s", local.resource_suffix_kebabcase)
  private_dns_zone_name = azurerm_private_dns_zone.web.name
  resource_group_name   = azurerm_private_dns_zone.web.resource_group_name
  virtual_network_id    = azurerm_virtual_network.this.id
  tags                  = local.tags
}