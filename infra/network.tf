
resource "azurerm_resource_group" "zero_trust_rg" {
  name     = "rg-zero-trust"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-zero-trust"
  location            = var.location
  resource_group_name = azurerm_resource_group.zero_trust_rg.name
  address_space       = ["10.10.0.0/16"]
}

resource "azurerm_subnet" "subnet_core" {
  name                 = "subnet-core"
  resource_group_name  = azurerm_resource_group.zero_trust_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.10.1.0/24"]
}

resource "azurerm_subnet" "subnet_bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.zero_trust_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.10.2.0/24"]
}
