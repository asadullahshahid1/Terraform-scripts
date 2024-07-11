provider "azurerm" {
  features {}

  client_id       = var.arm_client_id
  client_secret   = var.arm_client_secret
  subscription_id = var.arm_subscription_id
  tenant_id       = var.arm_tenant_id
}




terraform {
  backend "azurerm" {
    resource_group_name  = "tfstategroup"
    storage_account_name = "terrastorageaccountasad"
    container_name       = "statecontainer"
    key                  = "mytfstate.tfstate"
  }
}
