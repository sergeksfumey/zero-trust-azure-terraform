terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}


resource "azurerm_network_interface" "nic_core" {
  name                = "nic-core"
  location            = var.location
  resource_group_name = azurerm_resource_group.zero_trust_rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet_core.id  # ✅ Corrected reference
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_policy_definition" "deny_public_ip_custom" {
  name         = "deny-public-ip-custom"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Deny Public IP (Custom)"

  policy_rule = jsonencode({
    "if": {
      "anyOf": [
        {
          "field": "type",
          "equals": "Microsoft.Network/publicIPAddresses"
        },
        {
          "field": "Microsoft.Network/networkInterfaces/ipConfigurations[*].publicIPAddress.id",
          "exists": true
        }
      ]
    },
    "then": {
      "effect": "deny"
    }
  })

  metadata = jsonencode({
    category = "Network",
    version  = "1.0.0"
  })
}


resource "azurerm_resource_group_policy_assignment" "deny_public_ip" {
  name                 = "deny-public-ip-assignment"
  display_name         = "Deny Public IP Assignment"
  resource_group_id    = azurerm_resource_group.zero_trust_rg.id
  policy_definition_id = azurerm_policy_definition.deny_public_ip_custom.id
  description          = "Prevents creation of public IP addresses in this resource group"
}




