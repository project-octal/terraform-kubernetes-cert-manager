terraform {
  required_version = ">= 0.13"
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "v1.13.2"
    }
    k8s = {
      source  = "banzaicloud/k8s"
      version = "0.8.0"
    }
  }
}