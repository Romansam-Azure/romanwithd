# IP Groups
resource "azurerm_ip_group" "store_np_frontend" {
  name                = "IPG-Store-NonProd-Frontend"
  location            = var.location
  resource_group_name = var.resource_group_name

  cidrs = var.store_np_frontend

  tags = {
    Environment = "NonProd"
    Application = "Store"
  }
}