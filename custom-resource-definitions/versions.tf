terraform {
  required_version = ">= 0.13"
  required_providers {
    k8s = {
      version = ">= 0.8.0"
      source  = "banzaicloud/k8s"
    }
  }
}