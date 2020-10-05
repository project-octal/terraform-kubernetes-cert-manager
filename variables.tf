variable "namespace" {
  type        = string
  description = "The namespace that Cert-Manager will reside in."
  default     = "cert-manager"
}
variable "namespace_annotations" {
  type        = map(string)
  description = "Additional namespace annotations."
  default     = {}
}
variable "image_repository" {
  type        = string
  description = "The image repository to use when pulling images"
  default     = "registry.hub.docker.com"
}
variable "image_pull_policy" {
  type        = string
  description = "Determines when the image should be pulled prior to starting the container. `Always`: Always pull the image. | `IfNotPresent`: Only pull the image if it does not already exist on the node. | `Never`: Never pull the image"
  default     = "Always"
}
variable "labels" {
  type        = map(string)
  description = "(optional) A map that consists of any additional labels that should be included with resources created by this module."
  default     = {}
}