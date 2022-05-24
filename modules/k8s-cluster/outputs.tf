output "cluster_id" {
    description = "ID of a new Kubernetes cluster"
    value       = var.k8s_cluster != null ? yandex_kubernetes_cluster.this[0].id : null
}