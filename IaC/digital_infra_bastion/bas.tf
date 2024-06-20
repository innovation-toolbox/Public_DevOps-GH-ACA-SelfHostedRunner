resource "azurerm_public_ip" "bastion" {
  name                = format("pip-bas-%s", local.resource_suffix_kebabcase)
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "this" {
  name                = format("bas-%s", local.resource_suffix_kebabcase)
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.terraform_remote_state.network.outputs.subnet_bastion_id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}