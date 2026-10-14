output "private_dns_zone_ids" {
  value = values(azurerm_private_dns_zone.private_dns_zones)[*].id
}
