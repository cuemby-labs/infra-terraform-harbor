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
  description = "The version of the Helm chart."
  type        = string
  default     = "1.16.0"
}

variable "resources" {
  description = "Resource limits and requests for Harbor Helm release."
  type        = map(object({
    limits = object({
      cpu    = string
      memory = string
    })
    requests = object({
      cpu    = string
      memory = string
    })
  }))

  default = {
    portal = {
      limits = {
        cpu    = "100m"
        memory = "256Mi"
      }
      requests = {
        cpu    = "100m"
        memory = "256Mi"
      }
    }
    jobservice = {
      limits = {
        cpu    = "100m"
        memory = "256Mi"
      }
      requests = {
        cpu    = "100m"
        memory = "256Mi"
      }
    }
    registry = {
      limits = {
        cpu    = "100m"
        memory = "256Mi"
      }
      requests = {
        cpu    = "100m"
        memory = "256Mi"
      }
    }
    trivy = {
      limits = {
        cpu    = "1000m"
        memory = "1Gi"
      }
      requests = {
        cpu    = "200m"
        memory = "512Mi"
      }
    }
    redis = {
      limits = {
        cpu    = "100m"
        memory = "256Mi"
      }
      requests = {
        cpu    = "100m"
        memory = "256Mi"
      }
    }
    database = {
      limits = {
        cpu    = "100m"
        memory = "256Mi"
      }
      requests = {
        cpu    = "100m"
        memory = "256Mi"
      }
    }
    core = {
      limits = {
        cpu    = "100m"
        memory = "256Mi"
      }
      requests = {
        cpu    = "100m"
        memory = "256Mi"
      }
    }
  }
}

variable "replicas" {
  description = "Replicas for Harbor pods."
  type        = map(number)

  default = {
    portal     = 1
    jobservice = 1
    registry   = 1
    trivy      = 1
    redis      = 1
    database   = 1
    core       = 1
  }
}

variable "hpa_core_config" {
  description = "Configuration for the HPA targeting the Harbor core Deployment"
  type        = object({
    min_replicas              = string
    max_replicas              = string
    target_cpu_utilization    = string
    target_memory_utilization = string
  })

  default = {
    min_replicas              = 1
    max_replicas              = 5
    target_cpu_utilization    = 80
    target_memory_utilization = 80
  }
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