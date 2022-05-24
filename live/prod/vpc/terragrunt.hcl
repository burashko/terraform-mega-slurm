include "root" {
    path = find_in_parent_folders()
}

terraform {
    source = "github.com/pauljamm/yc-terraform-modules//networking"
}

# Temporary :)
generate "config" {
    path = "terraform.tfvars"
    if_exists = "overwrite"

    contents = <<EOF
labels              = { tag = "prod" }
network_description = "terraform-created"
network_name        = "prod"
domain_name         = "test.com"
create_vpc = true
subnets = [

  {
    "v4_cidr_blocks" : "10.191.0.0/16",
    "zone" : "ru-central1-a"
  },
  {
    "v4_cidr_blocks" : "10.121.0.0/16",
    "zone" : "ru-central1-b"
  },
  {
    "v4_cidr_blocks" : "10.131.0.0/16",
    "zone" : "ru-central1-c"
  },
]
EOF
}

inputs = {
    create_vpc = false
    network_name = "prod"
}