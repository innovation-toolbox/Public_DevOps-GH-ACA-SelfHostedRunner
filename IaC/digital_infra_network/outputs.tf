output "vnet_id" {
  value       = azurerm_virtual_network.this.id
  description = "The ID of the virtual network"
}

output "subnet_paas_id" {
  value       = azurerm_subnet.subnet_paas.id
  description = "The ID of the PaaS subnet"  
}

output "subnet_container_apps_environment_id" {
  value       = azurerm_subnet.subnet_container_apps_environment.id
  description = "The ID of the Container Apps Environment subnet"  
}

output "subnet_app_service_id" {
  value       = azurerm_subnet.subnet_app_service.id
  description = "The ID of the App Service subnet"  
}

output "subnet_bastion_id" {
  value       = azurerm_subnet.subnet_bastion.id
  description = "The ID of the Azure Bastion subnet"  
}

output "key_vault_id" {
  value       = azurerm_key_vault.this.id
  description = "The ID of the key vault"  
}

output "key_vault_name" {
  value       = azurerm_key_vault.this.name
  description = "The name of the key vault"  
}

output "key_vault_vm_password_secret_id" {
  value       = azurerm_key_vault_secret.vm_password.id
  description = "The ID of the VM password secret"
}

output "key_vault_vm_password_secret_name" {
  value       = azurerm_key_vault_secret.vm_password.name
  description = "The name of the VM password secret"
}

output "container_registry_id" {
  value       = azurerm_container_registry.this.id
  description = "The ID of the container registry"
}

output "private_dns_zone_web_id" {
  value       = azurerm_private_dns_zone.web.id
  description = "The ID of the private DNS zone for web"  
}