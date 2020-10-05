variable "name" {
  type    = string
  default = "cert-manager"
}
variable "instance_id" {
  type = string
}
variable "component" {
  type    = string
  default = "controller"
}
variable "namespace" {
  type = string
}
variable "image_tag" {
  type = string
  default = "v0.13.0"
}
variable "image_name" {
  type = string
  default = "jetstack/cert-manager-cainjector"
}
variable "image_repository" {
  type = string
  default = "quay.io"
}
variable "image_pull_policy" {
  type = string
}
variable "labels" {
  type = map(string)
}