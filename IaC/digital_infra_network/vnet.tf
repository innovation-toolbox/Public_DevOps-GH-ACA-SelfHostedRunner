resource "azurerm_virtual_network" "this" {
  name                = format("vnet-%s", local.resource_suffix_kebabcase)
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [format("%s%s", var.vnet_address_prefix, var.vnet_address_suffix)]
  tags                = local.tags
}
