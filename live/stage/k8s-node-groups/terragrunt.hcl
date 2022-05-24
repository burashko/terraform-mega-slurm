include "root" {
    path = find_in_parent_folders()
}

terraform {
    source = "${get_parent_terragrunt_dir()}/../modules//k8s-node-group"
}

dependency "k8s_cluster" {
    config_path = "../k8s-cluster"
    mock_outputs_allowed_terraform_commands = ["validate", "plan"]
    mock_outputs = {
        cluster_id = "000000000"
    }
}

inputs = {
    create_node_group = true
    k8s_cluster_id = dependency.k8s_cluster.outputs.cluster_id
    k8s_node_group_name = "slurm-stage-ng"
}


dependencies {
    paths = ["../vpc", "../k8s-cluster"]
}