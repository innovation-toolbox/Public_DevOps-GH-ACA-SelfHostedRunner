<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =3.91.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.91.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.91.0/docs/resources/key_vault) | resource |
| [azurerm_key_vault_secret.vm_password](https://registry.terraform.io/providers/hashicorp/azurerm/3.91.0/docs/resources/key_vault_secret) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.91.0/docs/resources/resource_group) | resource |
| [azurerm_subnet.subnet_app_service](https://registry.terraform.io/providers/hashicorp/azurerm/3.91.0/docs/resources/subnet) | resource |
| [azurerm_subnet.subnet_bastion](https://registry.terraform.io/providers/hashicorp/azurerm/3.91.0/docs/resources/subnet) | resource |
| [azurerm_subnet.subnet_container_apps_environment](https://registry.terraform.io/providers/hashicorp/azurerm/3.91.0/docs/resources/subnet) | resource |
| [azurerm_subnet.subnet_paas](https://registry.terraform.io/providers/hashicorp/azurerm/3.91.0/docs/resources/subnet) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.91.0/docs/resources/virtual_network) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.91.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_service_subnet_address_suffix"></a> [app\_service\_subnet\_address\_suffix](#input\_app\_service\_subnet\_address\_suffix) | App Service Plan Subnet Address Suffix | `string` | `".4.0/26"` | no |
| <a name="input_bastion_subnet_address_suffix"></a> [bastion\_subnet\_address\_suffix](#input\_bastion\_subnet\_address\_suffix) | Bastion Subnet Address Suffix | `string` | `".4.64/26"` | no |
| <a name="input_container_apps_environment_subnet_address_suffix"></a> [container\_apps\_environment\_subnet\_address\_suffix](#input\_container\_apps\_environment\_subnet\_address\_suffix) | Container Apps Environment Subnet Address Suffix | `string` | `".2.0/23"` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | The domain name | `string` | `"ntwrk"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name | `string` | `"dev"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the resources should be created | `string` | `"westeurope"` | no |
| <a name="input_paas_subnet_address_suffix"></a> [paas\_subnet\_address\_suffix](#input\_paas\_subnet\_address\_suffix) | Platform as a Service Subnet Address Suffix | `string` | `".0.0/24"` | no |
| <a name="input_resource_group_name_suffix"></a> [resource\_group\_name\_suffix](#input\_resource\_group\_name\_suffix) | The resource group name suffix | `string` | `"01"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The custom tags for all resources | `map(any)` | `{}` | no |
| <a name="input_vnet_address_prefix"></a> [vnet\_address\_prefix](#input\_vnet\_address\_prefix) | Vnet Address prefix | `string` | `"10.0"` | no |
| <a name="input_vnet_address_suffix"></a> [vnet\_address\_suffix](#input\_vnet\_address\_suffix) | Vnet Address suffix | `string` | `".0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_vault_id"></a> [key\_vault\_id](#output\_key\_vault\_id) | The ID of the key vault |
| <a name="output_key_vault_name"></a> [key\_vault\_name](#output\_key\_vault\_name) | The name of the key vault |
| <a name="output_key_vault_vm_password_secret_id"></a> [key\_vault\_vm\_password\_secret\_id](#output\_key\_vault\_vm\_password\_secret\_id) | The ID of the VM password secret |
| <a name="output_key_vault_vm_password_secret_name"></a> [key\_vault\_vm\_password\_secret\_name](#output\_key\_vault\_vm\_password\_secret\_name) | The name of the VM password secret |
| <a name="output_subnet_app_service_id"></a> [subnet\_app\_service\_id](#output\_subnet\_app\_service\_id) | The ID of the App Service subnet |
| <a name="output_subnet_bastion_id"></a> [subnet\_bastion\_id](#output\_subnet\_bastion\_id) | The ID of the Azure Bastion subnet |
| <a name="output_subnet_container_apps_environment_id"></a> [subnet\_container\_apps\_environment\_id](#output\_subnet\_container\_apps\_environment\_id) | The ID of the Container Apps Environment subnet |
| <a name="output_subnet_paas_id"></a> [subnet\_paas\_id](#output\_subnet\_paas\_id) | The ID of the PaaS subnet |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | The ID of the virtual network |
<!-- END_TF_DOCS -->