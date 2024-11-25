#
# Harbor variables
#

variable "helm_release_name" {
  description = "The name of the Helm release."
  type        = string
  default     = "harbor"
}

variable "namespace_name" {
  description = "The namespace where the Helm release will be installed."
  type        = string
  default     = "harbor-system"
}

variable "helm_chart_version" {
  description = "The version of the ingress-nginx Helm chart."
  type        = string
  default     = "1.15.0"
}

#
# Harbor manifest variables
#

variable "harbor_admin_password" {
  type        = string
  description = "Admin password for Harbor"
  sensitive   = true
  default     = ""
}

variable "domain_name" {
  type        = string
  description = "domain name for Harbor, e.g. 'dev.domainname.com'"
  default     = "dev.domainname.com"
}

variable "dash_domain_name" {
  type        = string
  description = "domain name with dash, e.g. 'dev-domainname-com'"
  default     = "dev-domainname-com"
}

variable "issuer_name" {
  type        = string
  description = "origin issuer name for annotation cert-manager.io/issuer:"
  default     = "origin-ca-issuer"
}

variable "issuer_kind" {
  type        = string
  description = "origin issuer kind for annotation cert-manager.io/issuer-kind:"
  default     = "ClusterOriginIssuer"
}

#
# Walrus Contextual Fields
#

variable "context" {
  description = <<-EOF
Receive contextual information. When Walrus deploys, Walrus will inject specific contextual information into this field.

Examples:
```
context:
  project:
    name: string
    id: string
  environment:
    name: string
    id: string
  resource:
    name: string
    id: string
```
EOF
  type        = map(any)
  default     = {}
}