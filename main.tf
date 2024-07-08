# Create virtual network
resource "azurerm_virtual_network" "my_terraform_network" {
  name                = "my-first-terraform-network"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = "1-8959905e-playground-sandbox"
}

# Create subnet
resource "azurerm_subnet" "my_terraform_subnet" {
  name                 = "my-first-terraform-subnet"
  resource_group_name  = "1-8959905e-playground-sandbox"
  virtual_network_name = azurerm_virtual_network.my_terraform_network.name
  address_prefixes     = ["10.0.1.0/24"]

  depends_on = [
    azurerm_virtual_network.my_terraform_network
  ]
}


# Create public IPs
resource "azurerm_public_ip" "my_terraform_public_ip" {
  name                = "my-first-terraform-PublicIP"
  location            = "East US"
  resource_group_name = "1-8959905e-playground-sandbox"
  allocation_method   = "Dynamic"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "my_terraform_nsg" {
  name                = "my-first-terraform-NetworkSecurityGroup"
  location            = "East US"
  resource_group_name = "1-8959905e-playground-sandbox"
# Note that this rule will allow all external connections from internet to SSH port
  
  security_rule {
    name                       = "SSH"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create network interface
resource "azurerm_network_interface" "my_terraform_nic" {
  name                = "my-first-terraform-myNIC"
  location            = "East US"
  resource_group_name = "1-8959905e-playground-sandbox"

  ip_configuration {
    name                          = "my-first-terraform-nic-configuration"
    subnet_id                     = azurerm_subnet.my_terraform_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my_terraform_public_ip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "my-nsg-assoc" {
  network_interface_id      = azurerm_network_interface.my_terraform_nic.id
  network_security_group_id = azurerm_network_security_group.my_terraform_nsg.id
}

# Create (and display) an SSH key
resource "tls_private_key" "secureadmin_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "my_terraform_vm" {
  name                  = "my-first-terraform-VM"
  location              = "East US"
  resource_group_name   = "1-8959905e-playground-sandbox"
  network_interface_ids = [azurerm_network_interface.my_terraform_nic.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "my-first-terraform-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "my-first-terraform-vm"
  admin_username                  = "secureadmin"

  disable_password_authentication = true

  admin_ssh_key {
    username   = "secureadmin"
    public_key = tls_private_key.secureadmin_ssh.public_key_openssh
  }
}
# Create a blob storage account
resource "azurerm_storage_account" "mystorage786" {
  name                     = "mystorage786"
  resource_group_name      = "1-8959905e-playground-sandbox"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create a blob container
resource "azurerm_storage_container" "container_tfstate" {
  name                  = "container_tfstate"
  storage_account_name  = azurerm_storage_account.mystorage786
  container_access_type = "private"
}
