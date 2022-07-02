resource "azurerm_virtual_network" "mynetwork" {
  name                = "my-network"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "dev"
  }
}


resource "azurerm_subnet" "mysubnet" {
  for_each             = toset(local.subnet_names)
  name                 = each.value
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.mynetwork.name
  address_prefixes     = [local.subnet_config[each.value]["address_prefixes"]]
}