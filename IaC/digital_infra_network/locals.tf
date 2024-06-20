locals {
  resource_lowercase_array  = [lower(var.environment), substr(lower(var.location), 0, 2), lower(var.domain), var.resource_group_name_suffix]
  resource_suffix_kebabcase = join("-", local.resource_lowercase_array)
  resource_suffix_lowercase = join("", local.resource_lowercase_array)

  tags = merge(
    var.tags,
    tomap(
      {
        "Deployment"       = "terraform",
        "ProjectFolder"    = "aca-devops",
        "ProjectSubFolder" = "digital_infra_network",
        "Environment"      = var.environment,
        "Domain"           = var.domain,
        "Location"         = var.location,
      }
    )
  )
}

