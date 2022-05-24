resource "yandex_kubernetes_node_group" "this" {
    count       = var.create_node_group ? 1 : 0
    cluster_id  = var.k8s_cluster_id
    name        = var.k8s_node_group_name
    description = var.k8s_node_group_description
    labels      = var.labels

    instance_template {
        platform_id = "standard-v2"
    }

    scale_policy {
        dynamic "fixed_scale" {
            for_each = { for k, v in var.k8s_node_group_scale_policy: k => v if k == "fixed_scale" }
            content {
                size = fixed_scale.value.size
            }
        }

        dynamic "auto_scale" {
            for_each = { for k, v in var.k8s_node_group_scale_policy: k => v if k == "auto_scale" }
            content {
                min     = auto_scale.value.min
                max     = auto_scale.value.max
                initial = auto_scale.value.initial
            }
        }
    }
}