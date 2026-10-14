data "azurerm_subnet" "frontend_subnet1" {

  name                 = "avnmsubnet"
  virtual_network_name = "testromanvnet"
  resource_group_name  = "Testresourceforroma"

}

data "azurerm_subnet" "frontend_subnet2" {

  name                 = "subnet2"
  virtual_network_name = "testromanvnet"
  resource_group_name  = "Testresourceforroma"

}