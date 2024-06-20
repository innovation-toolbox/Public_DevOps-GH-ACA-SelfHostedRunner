resource "azurerm_network_interface" "this" {
  name                = format("nic-bas-%s", local.resource_suffix_kebabcase)
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = data.terraform_remote_state.network.outputs.subnet_paas_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  name                = format("vm-bas-%s", local.resource_suffix_kebabcase)
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  ##### WARNING
  ##### WARNING
  ##### WARNING: DO NOT USE SSH KEY for authentication in production
  # USE SSH KEY for authentication in production
  admin_username                  = "azureuser"
  admin_password                  = data.azurerm_key_vault_secret.network_key_vault_vm_password.value
  disable_password_authentication = false
  size                            = "Standard_B2ms"

  network_interface_ids = [
    azurerm_network_interface.this.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_virtual_machine_extension" "vm_extension_linux" {
  name                 = "vm-extension-linux"
  virtual_machine_id   = azurerm_linux_virtual_machine.this.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"
  settings             = <<SETTINGS
    {
      "script": "${filebase64("${path.module}/scripts/jumpbox-setup-cli-tools.sh")}"
    }
SETTINGS
}
