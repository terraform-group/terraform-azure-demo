resource "azurerm_public_ip" "mypublicip" {
  for_each            = toset(local.vms)
  name                = local.vms_config[each.value]["public_ip_name"]
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  zones               = ["1", "2", "3"]
  sku                 = "Standard"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_public_ip" "mylbpublicip" {
  name                = "MyLBPublicIP"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = "dev"
  }
}

