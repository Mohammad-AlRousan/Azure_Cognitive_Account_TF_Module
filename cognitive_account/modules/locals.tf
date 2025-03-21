
locals {
  resource_block = try(azurerm_cognitive_account.this[0], azurerm_ai_services.this[0])
  private_endpoint_application_security_group_associations = { for assoc in flatten([
    for pe_k, pe_v in var.private_endpoints : [
      for asg_k, asg_v in pe_v.application_security_group_associations : {
        asg_key         = asg_k
        pe_key          = pe_k
        asg_resource_id = asg_v
      }
    ]
  ]) : "${assoc.pe_key}-${assoc.asg_key}" => assoc }

  has_system_assigned_identity = var.managed_identities.system_assigned
  has_user_assigned_identity   = length(var.managed_identities.user_assigned_resource_ids) > 0
  identity_type                = local.has_system_assigned_identity && local.has_user_assigned_identity ? "SystemAssigned, UserAssigned" : local.has_user_assigned_identity ? "UserAssigned" : "SystemAssigned"
  is_openai                    = var.type == "OpenAI"
  is_aiservices                = var.type == "AIServices"
  has_user_assigned_identities = length(var.managed_identities.user_assigned_resource_ids) > 0
}
