terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    random = {
      source  = "random"
    }
  }
  required_version = ">= 0.13"
  experiments = [module_variable_optional_attrs]
}