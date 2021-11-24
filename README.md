![Project Octal: Cert-Manager](docs/images/project-octal-cert-manager.svg "Project Octal: Cert-Manager")
---

Simplifies the deployment and management of Jetstacks cert-manager on a Kubernetes cluster.

### TODO:
- Add support for the latest version of Cert Manager. 

---

#### v0.0.4 to v1.0.0 Upgrade Notes

```shell

###################
## Admission Registration
###################

# Import the mutating webhook configuration
terraform import -var-file=secrets.tfvars \
'module.cert_manager.module.cert_manager_webhook.kubernetes_manifest.mutating_webhook_configuration' \
"apiVersion=admissionregistration.k8s.io/v1beta1,kind=MutatingWebhookConfiguration,name=cert-manager-webhook"

# Import the validating webhook configuration
terraform import -var-file=secrets.tfvars \
'module.cert_manager.module.cert_manager_webhook.kubernetes_manifest.validating_webhook_configuration' \
"apiVersion=admissionregistration.k8s.io/v1beta1,kind=ValidatingWebhookConfiguration,name=cert-manager-webhook"

###################
## Custom Resource Definitions
###################

# Import the certificaterequests.cert-manager.io CRD
terraform import -var-file=secrets.tfvars \
'module.cert_manager.module.custom_resource_definitions.kubernetes_manifest.certificaterequests' \
"apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=certificaterequests.cert-manager.io"

# Import the certificates.cert-manager.io CRD
terraform import -var-file=secrets.tfvars \
'module.cert_manager.module.custom_resource_definitions.kubernetes_manifest.certificates' \
"apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=certificates.cert-manager.io"

# Import the challenges.cert-manager.io CRD
terraform import -var-file=secrets.tfvars \
'module.cert_manager.module.custom_resource_definitions.kubernetes_manifest.challenges' \
"apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=challenges.acme.cert-manager.io"

# Import the clusterissuers.cert-manager.io CRD
terraform import -var-file=secrets.tfvars \
'module.cert_manager.module.custom_resource_definitions.kubernetes_manifest.clusterissuers' \
"apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=clusterissuers.cert-manager.io"

# Import the issuers.cert-manager.io CRD
terraform import -var-file=secrets.tfvars \
'module.cert_manager.module.custom_resource_definitions.kubernetes_manifest.issuers' \
"apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=issuers.cert-manager.io"

# Import the orders.cert-manager.io CRD
terraform import -var-file=secrets.tfvars \
'module.cert_manager.module.custom_resource_definitions.kubernetes_manifest.orders' \
"apiVersion=apiextensions.k8s.io/v1,kind=CustomResourceDefinition,name=orders.acme.cert-manager.io"

###################
## Lets Encrypt Issuer
###################
terraform import -var-file=secrets.tfvars \
'module.cert_manager.module.cert_manager_issuers.module.letsencrypt_issuer[0].kubernetes_manifest.letsencrypt_issuer' \
"apiVersion=cert-manager.io/v1,kind=ClusterIssuer,name=letsencrypt-prod"

# Delete the old Cert-Manager CRD references from the statefile
terraform state rm module.cert_manager.module.cert_manager_webhook.k8s_manifest.mutating_webhook_configuration
terraform state rm module.cert_manager.module.cert_manager_webhook.k8s_manifest.validating_webhook_configuration
terraform state rm module.cert_manager.module.custom_resource_definitions.k8s_manifest.certificaterequests
terraform state rm module.cert_manager.module.custom_resource_definitions.k8s_manifest.certificates
terraform state rm module.cert_manager.module.custom_resource_definitions.k8s_manifest.challenges
terraform state rm module.cert_manager.module.custom_resource_definitions.k8s_manifest.clusterissuers
terraform state rm module.cert_manager.module.custom_resource_definitions.k8s_manifest.issuers
terraform state rm module.cert_manager.module.custom_resource_definitions.k8s_manifest.orders
terraform state rm module.cert_manager.module.cert_manager_issuers.module.letsencrypt_issuer[0].k8s_manifest.letsencrypt_issuer

# Lastly, run a Terraform apply to make sure the states are synced up.
terraform apply -var-file secrets.tfvars
```
---

### Example
```hcl-terraform
module "cert_manager" {
  source = "github.com/project-octal/terraform-kubernetes-cert-manager"

  certificate_issuers = {
    letsencrypt = {
      name              = "letsencrypt-prod"
      server            = "https://acme-v02.api.letsencrypt.org/directory"
      email             = "dylanturn@gmail.com"
      secret_base64_key = var.letsencrypt_secret_base64_key
      default_issuer : true,
      ingress_class = module.traefik.ingress_class
    }
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_k8s"></a> [k8s](#requirement\_k8s) | 0.8.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cert_manager"></a> [cert\_manager](#module\_cert\_manager) | ./cert-manager | n/a |
| <a name="module_cert_manager_cainjector"></a> [cert\_manager\_cainjector](#module\_cert\_manager\_cainjector) | ./cert-manager-cainjector | n/a |
| <a name="module_cert_manager_issuers"></a> [cert\_manager\_issuers](#module\_cert\_manager\_issuers) | ./cert-manager-issuers | n/a |
| <a name="module_cert_manager_webhook"></a> [cert\_manager\_webhook](#module\_cert\_manager\_webhook) | ./cert-manager-webhook | n/a |
| <a name="module_custom_resource_definitions"></a> [custom\_resource\_definitions](#module\_custom\_resource\_definitions) | ./custom-resource-definitions | n/a |

## Resources

| Name | Type |
|------|------|
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [random_pet.instance_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certificate_issuers"></a> [certificate\_issuers](#input\_certificate\_issuers) | An object that contains the configuration for all the enabled certificate issuers. | <pre>object({<br>    letsencrypt = object({<br>      name : string,<br>      server : string,<br>      email : string,<br>      secret_base64_key : string,<br>      default_issuer : bool,<br>      ingress_class : string<br>    })<br>    # TODO: Add support for another one so this doesnt look so silly<br>  })</pre> | <pre>{<br>  "letsencrypt": null<br>}</pre> | no |
| <a name="input_image_pull_policy"></a> [image\_pull\_policy](#input\_image\_pull\_policy) | Determines when the image should be pulled prior to starting the container. `Always`: Always pull the image. \| `IfNotPresent`: Only pull the image if it does not already exist on the node. \| `Never`: Never pull the image | `string` | `"Always"` | no |
| <a name="input_image_repository"></a> [image\_repository](#input\_image\_repository) | The image repository to use when pulling images | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | (optional) A map that consists of any additional labels that should be included with resources created by this module. | `map(string)` | `{}` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace that Cert-Manager will reside in. | `string` | `"cert-manager"` | no |
| <a name="input_namespace_annotations"></a> [namespace\_annotations](#input\_namespace\_annotations) | Additional namespace annotations. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cert_issuer"></a> [cert\_issuer](#output\_cert\_issuer) | n/a |
<!-- END_TF_DOCS -->