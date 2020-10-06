variable "name" {
  type = string
}
variable "server" {
  type = string
}
variable "email" {
  type = string
}
variable "ingress_class" {
  type = string
}
variable "labels" {
  type = map(string)
}

resource "k8s_manifest" "letsencrypt_issuer" {
  content = yamlencode(local.letsencrypt_issuer)
}

locals {
  letsencrypt_issuer = {
    apiVersion = "cert-manager.io/v1"
    kind = "ClusterIssuer"
    metadata = {
      name = var.name
      labels = merge({
        name = var.name
      }, var.labels)
    }
    spec = {
      acme = {
        server = var.server
        email = var.email
        privateKeySecretRef = {
          name = var.name
        }
        solvers = [
          {
            http01 = {
              ingress = {
                class = var.ingress_class
              }
            }
          }
        ]
      }
    }
  }
}