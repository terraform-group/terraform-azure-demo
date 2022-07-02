terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-demo"
    storage_account_name = "tfstateadmin111"
    container_name       = "tfstate"
    key                  = "env/dev/network/terraform-network.tfstate"
  }
}