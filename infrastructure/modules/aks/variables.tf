variable "log_analytics_workspace_id" {
  type        = string
  description = "log analytics workspace id"
}

variable "subnet_aks_id" {
  type        = string
  description = "Specifies the resource id of the tenantmgmt subnet"
}

# general

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment"
}

variable "default_tags" {
  type = map(any)
  default = {
    "Project"   = "acr"
    "Owner"     = "me"
    "CreatedBy" = "me"
  }
}

variable "aks_prefix" {
  type        = string
  default     = "aks"
  description = "Prefix of the AKS name that's combined with name of the AKS"
}
variable "diag_prefix" {
  type        = string
  default     = "diag"
  description = "Prefix of the Diagnostic Settings resource."
}

variable "rg_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with name of the resource group."
}

// ========================== Azure Kubernetes services (AKS) ==========================
variable "rg_name" {
  description = "(Required) The name of the resource group in which to create the AKS. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "Location in which to deploy the AKS"
  type        = string
  default     = "westeurope"
}

variable "cluster_name" {
  description = "(Required) Specifies the name of the AKS cluster."
  type        = string
}

variable "dns_prefix" {
  description = "(Optional) DNS prefix specified when creating the managed cluster. Changing this forces a new resource to be created."
  type        = string
}

variable "private_cluster_enabled" {
  description = "Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "azure_rbac_enabled" {
  description = "(Optional) Is Role Based Access Control based on Azure AD enabled?"
  default     = true
  type        = bool
}

variable "admin_group_object_ids" {
  description = "(Optional) A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster."
  default     = ["c63746fd-eb61-4733-b7ed-c7de19c17901"]
  type        = list(string)
}

variable "role_based_access_control_enabled" {
  description = "(Required) Is Role Based Access Control Enabled? Changing this forces a new resource to be created."
  default     = true
  type        = bool
}

variable "automatic_upgrade_channel" {
  description = "(Optional) The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, and stable."
  default     = "stable"
  type        = string

  validation {
    condition     = contains(["patch", "rapid", "stable"], var.automatic_upgrade_channel)
    error_message = "The upgrade mode is invalid."
  }
}

variable "aks_sku_tier" {
  description = "(Optional) The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free."
  default     = "Free"
  type        = string

  validation {
    condition     = contains(["Free", "Paid"], var.aks_sku_tier)
    error_message = "The sku tier is invalid."
  }
}

variable "kubernetes_version" {
  description = "Specifies the AKS Kubernetes version"
  default     = "1.32.0"
  type        = string
}

variable "default_node_pool_vm_size" {
  description = "Specifies the vm size of the default node pool"
  default     = "Standard_B4ms"
  type        = string
}

variable "default_node_pool_availability_zones" {
  description = "Specifies the availability zones of the default node pool"
  default     = ["1", "2", "3"]
  type        = list(string)
}

variable "network_docker_bridge_cidr" {
  description = "Specifies the Docker bridge CIDR"
  default     = "172.17.0.1/16"
  type        = string
}

variable "network_dns_service_ip" {
  description = "Specifies the DNS service IP"
  default     = "10.25.0.10"
  type        = string
}

variable "network_service_cidr" {
  description = "Specifies the service CIDR"
  default     = "10.25.0.0/16"
  type        = string
}

variable "network_plugin" {
  description = "Specifies the network plugin of the AKS cluster"
  default     = "azure"
  type        = string //kubnet -//CNI-azure
}

variable "network_policy" {
  description = "Specifies the network policy of the AKS cluster"
  default     = "azure"
  type        = string //azure or calico
}

variable "outbound_type" {
  description = "(Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer and userDefinedRouting. Defaults to loadBalancer."
  type        = string
  default     = "userDefinedRouting"

  validation {
    condition     = contains(["loadBalancer", "userDefinedRouting"], var.outbound_type)
    error_message = "The outbound type is invalid."
  }
}

variable "default_node_pool_name" {
  description = "Specifies the name of the default node pool"
  default     = "agentpool"
  type        = string
}

variable "default_node_pool_subnet_name" {
  description = "Specifies the name of the subnet that hosts the default node pool"
  default     = "SystemSubnet"
  type        = string
}

variable "default_node_pool_subnet_address_prefix" {
  description = "Specifies the address prefix of the subnet that hosts the default node pool"
  default     = ["10.0.0.0/20"]
  type        = list(string)
}

variable "default_node_pool_auto_scaling_enabled" {
  description = "(Optional) Whether to enable auto-scaler. Defaults to false."
  type        = bool
  default     = true
}

variable "default_node_pool_host_encryption_enabled" {
  description = "(Optional) Should the nodes in this Node Pool have host encryption enabled? Defaults to false."
  type        = bool
  default     = false
}

variable "default_node_pool_node_public_ip_enabled" {
  description = "(Optional) Should each node have a Public IP Address? Defaults to false. Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "default_node_pool_max_pods" {
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  type        = number
  default     = 110
}

variable "default_node_pool_node_labels" {
  description = "(Optional) A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule). Changing this forces a new resource to be created."
  type        = map(any)
  default     = {}
}

variable "default_node_pool_os_disk_type" {
  description = "(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created."
  type        = string
  default     = "Ephemeral"
}

variable "default_node_pool_max_count" {
  description = "(Required) The maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to min_count."
  type        = number
  default     = 5
}

variable "default_node_pool_min_count" {
  description = "(Required) The minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to max_count."
  type        = number
  default     = 2
}

variable "default_node_pool_node_count" {
  description = "(Optional) The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be a value in the range min_count - max_count."
  type        = number
  default     = 2
}

# variable "log_analytics_workspace_id" {
#   description = "(Optional) The ID of the Log Analytics Workspace which the OMS Agent should send data to. Must be present if enabled is true."
#   type        = string
# }

# variable "tenant_id" {
#   description = "(Required) The tenant id of the system assigned identity which is used by master components."
#   type        = string
# }

variable "aks_log_analytics_retention_days" {
  description = "Specifies the number of days of the retention policy"
  type        = number
  default     = 30
}

# variable "ingress_application_gateway" {
#   description = "Specifies the Application Gateway Ingress Controller addon configuration."
#   type = object({
#     enabled      = bool
#     gateway_id   = string
#     gateway_name = string
#     subnet_cidr  = string
#     subnet_id    = string
#   })
#   default = {
#     enabled      = false
#     gateway_id   = null
#     gateway_name = null
#     subnet_cidr  = null
#     subnet_id    = null
#   }
# }

variable "azure_policy" {
  description = "Specifies the Azure Policy addon configuration."
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "http_application_routing" {
  description = "Specifies the HTTP Application Routing addon configuration."
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "kube_dashboard" {
  description = "Specifies the Kubernetes Dashboard addon configuration."
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "admin_username" {
  description = "(Required) Specifies the Admin Username for the AKS cluster worker nodes. Changing this forces a new resource to be created."
  type        = string
  default     = "azadmin"
}

variable "ssh_public_key" {
  description = "(Required) Specifies the SSH public key used to access the cluster. Changing this forces a new resource to be created."
  type        = string
  default     = "~/.ssh/k8s.id_rsa.pub"
}

variable "aks_tags" {
  description = "(Optional) Specifies the tags of the AKS"
  type        = map(any)
  default     = {}
}
