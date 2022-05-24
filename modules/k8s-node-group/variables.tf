variable "create_node_group" {
    description = "Create node group"
    type        = bool
    default     = false
}

variable "k8s_cluster_id" {
    description = "The ID of the Kubernetes cluster that this node group belongs to"
    type        = string
}

variable "k8s_node_group_name" {
    description = "Name of a specific Kubernetes node group"
    type        = string
}

variable "k8s_node_group_description" {
    description = "A description of the Kubernetes node group"
    type        = string
    default     = "terraform-created"
}

variable "labels" {
    description = "A set of key/value label pairs to assign"
    type        = map(string)
    default     = null
}

variable "k8s_node_group_scale_policy" {
    description = "Scale policy of the node group"
    type        = map(object({
        size    = optional(string)
        min     = optional(string)
        max     = optional(string)
        initial = optional(string)
    }))
}