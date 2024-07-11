provider "azurerm" {
  features {}

  subscription_id = "912670cb-ebac-4492-bb26-5255f1c10379"
  client_id       = "df93244f-8c19-49a9-8be3-318e1fc51cce"
  client_secret   = "OW68Q~pUrPNz-4oZHmOaNRR.bwkMFXp9_nfl8bbq"
  tenant_id       = "cbc5e1a5-61bf-47b3-961a-7697f3be4586"
}



terraform {
  backend "azurerm" {
    resource_group_name  = "tfstategroup"
    storage_account_name = "terrastorageaccountasad"
    container_name       = "statecontainer"
    key                  = "mytfstate.tfstate"
  }
}
