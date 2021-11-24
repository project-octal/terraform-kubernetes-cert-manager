resource "kubernetes_manifest" "certificaterequests" {
  manifest = yamldecode(templatefile("${path.module}/certificaterequests.cert-manager.io.yml", {}))
}
resource "kubernetes_manifest" "certificates" {
  manifest = yamldecode(templatefile("${path.module}/certificates.cert-manager.io.yml", {}))
}
resource "kubernetes_manifest" "challenges" {
  manifest = yamldecode(templatefile("${path.module}/challenges.acme.cert-manager.io.yml", {}))
}
resource "kubernetes_manifest" "clusterissuers" {
  manifest = yamldecode(templatefile("${path.module}/clusterissuers.cert-manager.io.yml", {}))
}
resource "kubernetes_manifest" "issuers" {
  manifest = yamldecode(templatefile("${path.module}/issuers.cert-manager.io.yml", {}))
}
resource "kubernetes_manifest" "orders" {
  manifest = yamldecode(templatefile("${path.module}/orders.acme.cert-manager.io.yml", {}))
}