# Awesome Walrus Template

Terraform module which deploys Harbor on any kubernetes cluster.

## Usage

```hcl
module "harbor" {
  source                = "./modules/harbor"        # Path to the Harbor module

  release_name          = var.release_name          # The name of the Helm release.
  namespace_name        = var.namespace_name        # The namespace where Harbor will be installed.
  chart_version         = var.chart_version         # The version of the Harbor Helm chart to be used.
  harbor_admin_password = var.harbor_admin_password # Admin password for Harbor.
  domain_name           = var.domain_name           # Domain name for Harbor, e.g., 'dev.domainname.com'.
  dash_domain_name      = var.dash_domain_name      # Domain name with dashes, e.g., 'dev-domainname-com'.
}
```

## Examples

- ...
- ...

## Contributing
 
Please read our [contributing guide](./docs/CONTRIBUTING.md) if you're interested in contributing to Walrus template.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.23.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.11.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | >= 1.5.7 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.23.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.11.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_namespace.example](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [helm_release.example](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_namespace_name"></a> [namespace_name](#input_namespace_name) | Namespace where Harbor will be installed. | string | "harbor-system" | no |
| <a name="input_helm_release_name"></a> [helm_release_name](#input_helm_release_name) | Name for the Harbor Helm release. | string | "harbor" | no |
| <a name="input_helm_chart_version"></a> [helm_chart_version](#input_helm_chart_version) | Version of the Harbor Helm chart. | string | "1.15.0" | no |
| <a name="input_harbor_admin_password"></a> [harbor_admin_password](#input_harbor_admin_password) | Admin password for Harbor. | string sensitive | no | yes |
| <a name="input_domain_name"></a> [domain_name](#input_helm_domain_name) | domain name for Harbor, e.g. 'dev.domainname.com'. | string | no | yes |
| <a name="input_dash_domain_name"></a> [dash_domain_name](#input_dash_domain_name) | domain name with dash, e.g. 'dev-domainname-com'. | string | no | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_harbor_external_url"></a> [harbor\_external\_url](#output\_harbor\_external\_url) | The external URL for Harbor. |
| <a name="output_walrus_environment_id"></a> [walrus\_environment\_id](#output\_walrus\_environment\_id) | The id of environment where deployed in Walrus. |
| <a name="output_walrus_environment_name"></a> [walrus\_environment\_name](#output\_walrus\_environment\_name) | The name of environment where deployed in Walrus. |
| <a name="output_walrus_project_id"></a> [walrus\_project\_id](#output\_walrus\_project\_id) | The id of project where deployed in Walrus. |
| <a name="output_walrus_project_name"></a> [walrus\_project\_name](#output\_walrus\_project\_name) | The name of project where deployed in Walrus. |
| <a name="output_walrus_resource_id"></a> [walrus\_resource\_id](#output\_walrus\_resource\_id) | The id of resource where deployed in Walrus. |
| <a name="output_walrus_resource_name"></a> [walrus\_resource\_name](#output\_walrus\_resource\_name) | The name of resource where deployed in Walrus. |
<!-- END_TF_DOCS -->

## License

Copyright (c) 2023 [Seal, Inc.](https://seal.io)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at [LICENSE](./LICENSE) file for details.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
