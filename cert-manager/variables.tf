variable "name" {
  type    = string
  default = "cert-manager"
}
variable "component" {
  type    = string
  default = "controller"
}
variable "namespace" {
  type = string
}
variable "image_repository" {
  type = string
}
variable "image_pull_policy" {
  type = string
}
variable "labels" {
  type = map(string)
}