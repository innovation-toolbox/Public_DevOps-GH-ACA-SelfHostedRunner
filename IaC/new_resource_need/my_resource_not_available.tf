# resource "azapi_resource" "resource_group" {
#   type      = "Microsoft.Resources/resourceGroups@2022-09-01"
#   name      = "rg-test-api"
#   location  = "westeurope"
#   parent_id = format("/subscriptions/%s", data.azurerm_client_config.current.subscription_id)
#   tags = {
#     tagName1 = "tagValue1"
#     tagName2 = "tagValue2",
#     tagName3 = "tagValue3"
#   }
#   #   body = jsonencode({
#   #     properties = {}
#   #     managedBy = "string"
#   #   })
# }

resource "azurerm_resource_group" "resource_group" {
  name     = "rg-test-api"
  location = "westeurope"
  tags = {
    tagName1 = "tagValue1"
    tagName2 = "tagValue2",
    tagName3 = "tagValue3"
  }
}

# moved {
#   from = azapi_resource.resource_group
#   to   = azurerm_resource_group.resource_group
# }
