variable "namespace" {
  type = string
}
variable "letsencrypt" {
  type = object({
    name: string,
    server: string,
    email: string,
    secret_base64_key: string,
    ingress_class: string
  })
  default = null
}
