resource "azurerm_lb" "mylb" {
  name                = "MyLoadBalancer"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = local.mylb_public_ip
  }
}

resource "azurerm_lb_backend_address_pool" "mylb" {
  loadbalancer_id = azurerm_lb.mylb.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_backend_address_pool_address" "mylb" {
  count                   = length([for k, v in azurerm_linux_virtual_machine.myserver : v.private_ip_address])
  name                    = "server-${count.index}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.mylb.id
  virtual_network_id      = local.vnet_id
  ip_address              = [for k, v in azurerm_linux_virtual_machine.myserver : v.private_ip_address][count.index]
}

resource "azurerm_lb_rule" "mylb" {
  loadbalancer_id                = azurerm_lb.mylb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.mylb.id]
}