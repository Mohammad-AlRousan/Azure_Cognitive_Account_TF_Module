variable "type" {
  type        = string
  description = "Specifies the type of Cognitive Service Account. Changing this forces a new resource to be created."
  nullable    = false
}

variable "location" {
  type        = string
  description = "Specifies the Azure location for the resource. Changing this forces a new resource to be created."
  nullable    = false
}

variable "name" {
  type        = string
  description = "Specifies the name of the Cognitive Service Account. Changing this forces a new resource to be created."
  nullable    = false
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group for the Cognitive Service Account. Changing this forces a new resource to be created."
  nullable    = false
}

variable "sku_name" {
  type        = string
  description = "Specifies the SKU Name for the Cognitive Service Account."
  nullable    = false
}

variable "cognitive_deployments" {
  type = map(object({
    name                       = string
    rai_policy_name            = optional(string)
    version_upgrade_option     = optional(string)
    dynamic_throttling_enabled = optional(bool)
    model = object({
      format  = string
      name    = string
      version = optional(string)
    })
    scale = object({
      capacity = optional(number)
      family   = optional(string)
      size     = optional(string)
      tier     = optional(string)
      type     = string
    })
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  default     = {}
  description = "Configuration for Cognitive Service Account deployments."
  nullable    = false
}

variable "custom_question_answering_search_service_id" {
  type        = string
  default     = null
  description = "Specifies the ID of the Search service if `kind` is `TextAnalytics`."
}

variable "custom_question_answering_search_service_key" {
  type        = string
  default     = null
  description = "Specifies the key of the Search service if `kind` is `TextAnalytics`."
  sensitive   = true
}

variable "custom_subdomain_name" {
  type        = string
  default     = null
  description = "The subdomain name for token-based authentication. Required when `network_acls` is specified. Changing this forces a new resource to be created."
}

variable "customer_managed_key" {
  type = object({
    key_vault_resource_id = string
    key_name              = string
    key_version           = optional(string, null)
    user_assigned_identity = optional(object({
      resource_id = string
    }), null)
  })
  default     = null
  description = "Configuration for Customer Managed Key."
}

variable "dynamic_throttling_enabled" {
  type        = bool
  default     = null
  description = "Whether to enable dynamic throttling for the Cognitive Service Account."
}

variable "fqdns" {
  type        = list(string)
  default     = null
  description = "List of FQDNs allowed for the Cognitive Account."
}

variable "local_auth_enabled" {
  type        = bool
  default     = false
  description = "Whether local authentication methods are enabled for the Cognitive Account. Defaults to `true`."
}

variable "managed_identities" {
  type = object({
    system_assigned            = optional(bool, false)
    user_assigned_resource_ids = optional(set(string), [])
  })
  default     = {}
  description = "Configuration for Managed Identities."
  nullable    = false
}

variable "metrics_advisor_aad_client_id" {
  type        = string
  default     = null
  description = "The Azure AD Client ID (Application ID) for Metrics Advisor."
}

variable "metrics_advisor_aad_tenant_id" {
  type        = string
  default     = null
  description = "The Azure AD Tenant ID for Metrics Advisor."
}

variable "metrics_advisor_super_user_name" {
  type        = string
  default     = null
  description = "The super user of Metrics Advisor."
}

variable "metrics_advisor_website_name" {
  type        = string
  default     = null
  description = "The website name of Metrics Advisor."
}

variable "network_acls" {
  type = object({
    default_action = string
    ip_rules       = optional(set(string))
    virtual_network_rules = optional(set(object({
      ignore_missing_vnet_service_endpoint = optional(bool)
      subnet_id                            = string
    })))
    bypass = optional(string)
  })
  default     = null
  description = "Network ACLs configuration for the Cognitive Account."
}

variable "outbound_network_access_restricted" {
  type        = bool
  default     = null
  description = "Whether outbound network access is restricted for the Cognitive Account. Defaults to `false`."
}

variable "private_endpoints" {
  type = map(object({
    name = optional(string, null)
    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
      principal_type                         = optional(string, null)
    })), {})
    lock = optional(object({
      kind = string
      name = optional(string, null)
    }), null)
    tags                                    = optional(map(string), null)
    subnet_resource_id                      = string
    private_dns_zone_group_name             = optional(string, "default")
    private_dns_zone_resource_ids           = optional(set(string), [])
    application_security_group_associations = optional(map(string), {})
    private_service_connection_name         = optional(string, null)
    network_interface_name                  = optional(string, null)
    location                                = optional(string, null)
    resource_group_name                     = optional(string, null)
    ip_configurations = optional(map(object({
      name               = string
      private_ip_address = string
    })), {})
  }))
  default     = {}
  description = "Configuration for private endpoints on the Cognitive Service Account."
  nullable    = false
}

variable "private_endpoints_manage_dns_zone_group" {
  type        = bool
  default     = true
  description = "Whether to manage private DNS zone groups with this module."
  nullable    = false
}

variable "public_network_access_enabled" {
  type        = bool
  default     = true
  description = "Whether public network access is allowed for the Cognitive Account. Defaults to `true`."
  nullable    = false
}

variable "qna_runtime_endpoint" {
  type        = string
  default     = null
  description = "A URL to link a QnAMaker cognitive account to a QnA runtime."
}

variable "rai_policies" {
  type = map(object({
    name             = string
    base_policy_name = string
    mode             = string
    content_filters = optional(list(object({
      blocking           = bool
      enabled            = bool
      name               = string
      severity_threshold = string
      source             = string
    })))
    custom_block_lists = optional(list(object({
      source          = string
      block_list_name = string
      blocking        = bool
    })))
  }))
  default     = {}
  description = "Configuration for Responsible AI (RAI) policies."
  nullable    = false
}

variable "storage" {
  type = list(object({
    identity_client_id = optional(string)
    storage_account_id = string
  }))
  default     = null
  description = "Configuration for storage accounts."
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "A mapping of tags to assign to the resource."
}
