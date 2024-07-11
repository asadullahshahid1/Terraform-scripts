variable "location" {
  type    = string
  default = "Central US"
}

variable "resource_group_name" {
  type    = string
  default = "rg"
}

variable "virtual_network_name" {
  type    = string
  default = "vnet"
}

variable "address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "subnet_name" {
  type    = string
  default = "subnet"
}

variable "address_prefixes" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "public_ip_name" {
  type    = string
  default = "public_ip"
}

variable "allocation_method" {
  type    = string
  default = "Dynamic"
}

variable "nsg_name" {
  type    = string
  default = "nsg"
}

variable "nic_name" {
  type    = string
  default = "nic"
}

variable "vm_name" {
  type    = string
  default = "vm"
}

variable "vm_size" {
  type    = string
  default = "Standard_DS1_v2"
}

variable "computer_name" {
  type    = string
  default = "vm"
}

variable "ssh_key_name" {
  description = "Name of the SSH key"
  type        = string
  default     = "ssh-key"
}
