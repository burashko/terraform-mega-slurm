variable "k8s_cluster_name" {
    description = "Name of a specific Kubernetes cluster"
    type        = string
}

variable "k8s_cluster_description" {
    description = "A description of the Kubernetes cluster"
    type        = string
    default     = "terraform-created"
}

variable "folder_id" {
    description = "The ID of the folder that the Kubernetes cluster belongs to"
    type        = string
    default     = null
}

variable "labels" {
    description = "A set of key/value label pairs to assign."
    type        = map(string)
    default     = null
}

variable "vpc_id" {
    description = "The ID of the cluster network"
    type        = string
}

variable "k8s_cluster_version" {
    description = "Version of Kubernetes that will be used for master"
    type        = string
}

variable "k8s_cluster_public_ip" {
    description = "If true Kubernetes master will have visible ipv4 address"
    type        = bool
    default     = false
}

variable "k8s_cluster_sg_ids" {
    description = "List of security group IDs to which the Kubernetes cluster belongs"
    type        = list(string)
    default     = null
}

variable "k8s_cluster_maintenance_autoupgrade" {
    description = "Boolean flag that specifies if master can be upgraded automatically"
    type        = bool
    default     = true
}

variable "k8s_cluster_maintenance_window" {
    description = "Specifies maintenance window"
    type        = set(object({
        day        = optional(string)
        start_time = string
        duration   = string
    }))
    default     = null
}

variable "k8s_cluster" {
    description = "Set type of Master and initialize parameters"
    type        = map(object({
        region   = optional(string)
        location = list(object({
            zone      = string
            subnet_id = string
        }))
    }))
    default     = null
}

variable "k8s_cluster_az" {
    description = "ID of the availability zone"
    type        = string
    default     = null
}

variable "k8s_cluster_subnet_id" {
    description = "ID of the subnet"
    type        = string
    default     = null
}

#variable "k8s_cluster_service_account_id" {
#    description = "Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster"
#    type        = string
#}
#
#variable "k8s_cluster_node_service_account_id" {
#    description = "Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics"
#    type        = string
#}

variable "k8s_cluster_release_channel" {
    description = "Cluster release channel"
    type        = string
}