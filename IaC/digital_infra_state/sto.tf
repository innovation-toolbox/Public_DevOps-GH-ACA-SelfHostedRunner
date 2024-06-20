resource "azurerm_storage_account" "this" {
  name                     = format("st%s", local.resource_suffix_lowercase)
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
  tags                     = local.tags
}

resource "azurerm_storage_container" "this" {
  name                  = "states"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}
