output "peering_id" {
  description = "The id of the newly created virtual network peering in on first virtual netowork. "
  value       = "${azurerm_virtual_network_peering.peering.id}"
}
