resource "azurerm_resource_group" "tfdemo" {
  name     = "terraform-demo"
  location = "East US"
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstateadmin111"
  resource_group_name      = azurerm_resource_group.tfdemo.name
  location                 = azurerm_resource_group.tfdemo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
  }
}


resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
  depends_on = [
    azurerm_storage_account.tfstate
  ]
}
