include "root" {
    path = find_in_parent_folders()
}

terraform {
    source = "${get_parent_terragrunt_dir()}/../modules//k8s-cluster"
}

dependency "vpc" {
    config_path = "../vpc"
    mock_outputs = {
        subnets = [
            {
                "v4_cidr_blocks" = "10.191.0.0/16",
                "zone" = "ru-central1-a"
                "id" = "000000000"
            }
        ]
        vpc_id = "000000000"
    }
    mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}

inputs = {
    k8s_cluster_name = "slurm-stage"
    k8s_cluster_version = "1.21"
    k8s_cluster_release_channel = "STABLE"
    vpc_id = dependency.vpc.outputs.vpc_id
    k8s_cluster_maintenance_autoupgrade = true
    k8s_cluster = {
        zonal = {
            location = [for s in "${dependency.vpc.outputs.subnets}": {
                "zone" = s.zone
                "subnet_id" = s.id
            } if s.zone == "ru-central1-a"]
        }
    }
}

dependencies {
    paths = ["../vpc"]
}