provider "azurerm" {
  features {}

  skip_provider_registration = true
}

terraform {
  backend "azurerm" {
    resource_group_name = "1-8959905e-playground-sandbox"
    storage_account_name = "mystorage786"
    container_name = "container-tf.state"
    key = "path/to/my/key/terraform.tfstate"
  }
}
