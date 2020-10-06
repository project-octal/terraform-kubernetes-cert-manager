locals {
  image_repository = var.image_repository == null ? "quay.io" : var.image_repository
  app = "cainjector"
  labels = merge({
    "app"                         = local.app
    "app.kubernetes.io/component" = var.component
    # Some more labels go here...
  }, var.labels)
}