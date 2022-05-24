remote_state {
    backend = "local"
    generate = {
        path      = "_backend.tf"
        if_exists = "overwrite"
    }
    config = {
        path = "${path_relative_to_include()}/terraform.tfstate"
    }
}

inputs = {
    k8s_node_group_scale_policy = {
        fixed_scale = {
            size = 1
        }
    }
}