include "root" {
    path = find_in_parent_folders()
}

terraform {
    source = "github.com/pauljamm/yc-terraform-modules//networking"
}

inputs = {
    network_name = "stage"
}