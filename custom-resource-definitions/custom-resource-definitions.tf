resource "k8s_manifest" "certificaterequests" {
  content = templatefile("${path.module}/certificaterequests.cert-manager.io.yml", {})
}
resource "k8s_manifest" "certificates" {
  content = templatefile("${path.module}/certificates.cert-manager.io.yml", {})
}
resource "k8s_manifest" "challenges" {
  content = templatefile("${path.module}/challenges.acme.cert-manager.io.yml", {})
}
resource "k8s_manifest" "clusterissuers" {
  content = templatefile("${path.module}/clusterissuers.cert-manager.io.yml", {})
}
resource "k8s_manifest" "issuers" {
  content = templatefile("${path.module}/issuers.cert-manager.io.yml", {})
}
resource "k8s_manifest" "orders" {
  content = templatefile("${path.module}/orders.acme.cert-manager.io.yml", {})
}