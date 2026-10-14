output "vnet_outputs" {
  value = local.vnet_outputs
}

output "subnet_outputs" {
  value = local.subnet_outputs
}

# for debugging purposes

# output "config_map" {
#   value = local.config_map
# }

# output "route_tables" {
#   value = module.route_tables
# }

# output "network_security_groups" {
#   value = module.network_security_groups
# }

# output "subnets" {
#   value = module.subnets
# }

# output "virtual_networks" {
#   value = module.virtual_networks
# }
