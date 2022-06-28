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
}
variable "image_name" {
  type = string
}
variable "image_repository" {
  type = string
}
variable "image_pull_policy" {
  type = string
}
variable "service_account_annotations" {
  type    = map(string)
  default = null
}
variable "deployment_annotations" {
  type    = map(string)
  default = {}
}
variable "labels" {
  type = map(string)
}