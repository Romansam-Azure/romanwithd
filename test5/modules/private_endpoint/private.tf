locals {
  mandatory_tags = {
    DeployedBy = "Terraform"
  }

  all_tags = merge(var.tags, local.mandatory_tags)
}

resource "azurerm_private_endpoint" "pe" {
  name                = upper("${var.pe_resource_name}-PE")
  location            = var.location
  resource_group_name = var.pe_resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = upper("${var.pe_resource_name}-connection")
    is_manual_connection           = false
    private_connection_resource_id = var.endpoint_resource_id
    subresource_names              = var.subresource_names
  }

  dynamic "private_dns_zone_group" {
    for_each = var.private_dns_zone_ids == null ? [] : [true]
    content {
      name                 = "default"
      private_dns_zone_ids = var.private_dns_zone_ids
    }
  }

  tags = local.all_tags
}

# NOTE:
#   azurerm_private_endpoint creates a PE and an associated NIC, but the tags are not added to the NIC, use this azapi resource to apply the same tags to the NIC
#   There could be extra tags on the NIC not managed by this block
#   Remove this resource will not remove the tags
resource "azapi_update_resource" "pe_nic_tags" {
  type      = "Microsoft.Resources/tags@2021-04-01"
  parent_id = azurerm_private_endpoint.pe.network_interface[0].id
  name      = "default"
  body = jsonencode({
    properties = {
      tags = local.all_tags
    }
  })
}
