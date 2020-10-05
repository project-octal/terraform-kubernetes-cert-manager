locals {
  app = "cert-manager"
  labels = merge({
    "app"                         = local.app
    "app.kubernetes.io/component" = var.component
    # Some more labels go here...
  }, var.labels)
}