
resource "azurerm_ai_services" "this" {
  count = var.type != "OpenAI" ? 1 : 0

  location                           = var.location
  name                               = var.name
  resource_group_name                = var.resource_group_name
  sku_name                           = var.sku_name
  custom_subdomain_name              = var.custom_subdomain_name
  fqdns                              = var.fqdns
  local_authentication_enabled       = var.local_auth_enabled
  outbound_network_access_restricted = var.outbound_network_access_restricted
  public_network_access              = var.public_network_access_enabled ? "Enabled" : "Disabled"
  tags                               = var.tags

  dynamic "identity" {
    for_each = local.has_system_assigned_identity || local.has_user_assigned_identity ? { this = var.managed_identities } : {}

    content {
      type         = local.identity_type
      identity_ids = identity.value.user_assigned_resource_ids
    }
  }

  dynamic "network_acls" {
    for_each = var.network_acls == null ? [] : [var.network_acls]

    content {
      default_action = network_acls.value.default_action
      ip_rules       = network_acls.value.ip_rules

      dynamic "virtual_network_rules" {
        for_each = compact(network_acls.value.virtual_network_rules)

        content {
          subnet_id                            = virtual_network_rules.value.subnet_id
          ignore_missing_vnet_service_endpoint = virtual_network_rules.value.ignore_missing_vnet_service_endpoint
        }
      }
    }
  }

  dynamic "storage" {
    for_each = var.storage == null ? [] : var.storage

    content {
      storage_account_id = storage.value.storage_account_id
      identity_client_id = storage.value.identity_client_id
    }
  }
}
