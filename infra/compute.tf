
resource "azurerm_network_interface" "vm1_nic" {
  name                = "nic-vm1"
  location            = var.location
  resource_group_name = azurerm_resource_group.zero_trust_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_core.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm1" {
  name                  = "vm-secure"
  location              = var.location
  resource_group_name   = azurerm_resource_group.zero_trust_rg.name
  network_interface_ids = [azurerm_network_interface.vm1_nic.id]
  size                  = "Standard_B2s"
  admin_username        = var.admin_username

  admin_password = "P@ssword1234!" # Replace with secret or remove for SSH key

  disable_password_authentication = false

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = {
    environment = "ZeroTrust"
  }
}
