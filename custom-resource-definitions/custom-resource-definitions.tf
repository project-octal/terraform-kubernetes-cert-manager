resource "kubernetes_manifest" "certificaterequests" {
  field_manager {
    force_conflicts = true
  }
  manifest = yamldecode(templatefile("${path.module}/certificaterequests.cert-manager.io.yml", {}))
}
resource "kubernetes_manifest" "certificates" {
  field_manager {
    force_conflicts = true
  }
  manifest = yamldecode(templatefile("${path.module}/certificates.cert-manager.io.yml", {}))
}
resource "kubernetes_manifest" "challenges" {
  field_manager {
    force_conflicts = true
  }
  manifest = yamldecode(templatefile("${path.module}/challenges.acme.cert-manager.io.yml", {}))
}
resource "kubernetes_manifest" "clusterissuers" {
  field_manager {
    force_conflicts = true
  }
  manifest = yamldecode(templatefile("${path.module}/clusterissuers.cert-manager.io.yml", {}))
}
resource "kubernetes_manifest" "issuers" {
  field_manager {
    force_conflicts = true
  }
  manifest = yamldecode(templatefile("${path.module}/issuers.cert-manager.io.yml", {}))
}
resource "kubernetes_manifest" "orders" {
  field_manager {
    force_conflicts = true
  }
  manifest = yamldecode(templatefile("${path.module}/orders.acme.cert-manager.io.yml", {}))
}