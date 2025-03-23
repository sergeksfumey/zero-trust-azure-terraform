output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "policy_assignment_id" {
  value = azurerm_resource_group_policy_assignment.deny_public_ip.id
}




