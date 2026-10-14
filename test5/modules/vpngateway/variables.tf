variable "location" {
  type        = string
  description = "The location where the resources will be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the resources will be created."
}

variable "subnet_id" {
  description = "The full Azure resource ID of the remote virtual network."
  type        = string
}

variable "public_ip_address_id" {
  description = "The public IP address of the on-premises environment."
  type        = string
}

variable "vpn_gw_sku" {
  description = "The SKU of the VPN Gateway. Accepted values are VpnGw1, VpnGw2, VpnGw3, etc."
  type        = string
  default     = "VpnGw1"
}

variable "vpn_gateway_name" {
  description = "The name of the VPN Gateway."
  type        = string
  default     = "vgw-tes-rom-prd-aue-01"
}

variable "local_gateway_name" {
  description = "The name of the Local Network Gateway."
  type        = string
  default     = "lgw-tes-rom-prd-aue-01"
}

variable "local_gateway_name2" {
  description = "The name of the Local Network Gateway."
  type        = string
  default     = "lgw-tes-rom-prd-aue-02"
}

variable "ip_configuration" {
  description = "The name of the IP configuration."
  type        = string
  default     = "vnetGatewayConfig"
}

variable "private_ip_address_allocation" {
  description = "The allocation method for the private IP address. Usually, this will be Dynamic or Static."
  type        = string
}

variable "vpn_type" {
  description = "The type of VPN. Accepted values are PolicyBased or RouteBased."
  type        = string
  default     = "RouteBased"
}

variable "gateway_type" {
  description = "The type of the gateway. Typically, this will be Vpn."
  type        = string
  default     = "Vpn"
}

variable "enable_bgp" {
  description = "Enable BGP for the VPN Gateway."
  type        = bool
  default     = true
}

variable "enable_active_active" {
  description = "If true, an active-active Virtual Network Gateway will be created. If false, an active-standby gateway will be created."
  type        = bool
  default     = false
}

variable "gateway_address" {
  description = "The IP address of the on-premises VPN gateway."
  type        = string
}

variable "gateway_address2" {
  description = "The IP address of the on-premises VPN gateway."
  type        = string
}

variable "address_space" {
  description = "The address space of the on-premises network."
  type        = list(string)
}

variable "address_space2" {
  description = "The address space of the on-premises network."
  type        = list(string)
}

variable "local_gateway_connection_name" {
  description = "The name of the connection between the Virtual Network Gateway and the Local Network Gateway."
  type        = string
}

variable "local_gateway_connection_name2" {
  description = "The name of the connection between the Virtual Network Gateway and the Local Network Gateway."
  type        = string
}
