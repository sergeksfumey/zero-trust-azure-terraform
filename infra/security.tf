
resource "azurerm_network_security_group" "web_nsg" {
  name                = "nsg-web"
  location            = var.location
  resource_group_name = azurerm_resource_group.zero_trust_rg.name

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }
}
