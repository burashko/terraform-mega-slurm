data "yandex_client_config" "client" {}

locals {
  folder_id = var.folder_id == null ? data.yandex_client_config.client.folder_id : var.folder_id
}

resource "random_string" "random" {
  length    = 4
  lower     = true
  special   = false
  min_lower = 4
}

resource "yandex_iam_service_account" "this" {
  name = "${var.k8s_cluster_name}-${random_string.random.result}"
}

resource "yandex_resourcemanager_folder_iam_member" "this" {
  folder_id = local.folder_id
  member    = "serviceAccount:${yandex_iam_service_account.this.id}"
  role      = "editor"
}

resource "yandex_kubernetes_cluster" "this" {
    count                   = var.k8s_cluster != null ? 1 : 0
    name                    = var.k8s_cluster_name
    description             = var.k8s_cluster_description
    folder_id               = local.folder_id
    labels                  = var.labels
    network_id              = var.vpc_id
    service_account_id      = yandex_iam_service_account.this.id
    node_service_account_id = yandex_iam_service_account.this.id
    release_channel         = var.k8s_cluster_release_channel

    master {
        version            = var.k8s_cluster_version
        public_ip          = var.k8s_cluster_public_ip
        security_group_ids = var.k8s_cluster_sg_ids
        maintenance_policy {
            auto_upgrade = var.k8s_cluster_maintenance_autoupgrade

            dynamic "maintenance_window" {
                for_each = var.k8s_cluster_maintenance_window != null ? var.k8s_cluster_maintenance_window : []
                content {
                    day        = maintenance_window.value.day
                    start_time = maintenance_window.value.start_time
                    duration   = maintenance_window.value.duration
                }
            }
        }

        dynamic "zonal" {
            for_each = { for k, v in var.k8s_cluster: k => v if k == "zonal" }
            content {
                zone      = zonal.value.location[0].zone
                subnet_id = zonal.value.location[0].subnet_id
            }
        }

        dynamic "regional" {
            for_each = { for k, v in var.k8s_cluster: k => v if k == "regional" }
            content {
                region    = regional.value.region
                dynamic "location" {
                    for_each = regional.value.location
                    content {
                        zone      = location.value.zone
                        subnet_id = location.value.subnet_id
                    }
                }
            }
        }
    }

    depends_on = [
        yandex_resourcemanager_folder_iam_member.this
    ]
}