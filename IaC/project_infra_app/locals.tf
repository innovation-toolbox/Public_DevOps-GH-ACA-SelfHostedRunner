locals {
  resource_lowercase_array  = [lower(var.environment), substr(lower(var.location), 0, 2), lower(var.domain), lower(var.application_name), var.resource_group_name_suffix]
  resource_suffix_kebabcase = join("-", local.resource_lowercase_array)

  tags = merge(
    var.tags,
    tomap(
      {
        "Deployment"       = "terraform",
        "ProjectFolder"    = "aca-devops",
        "ProjectSubFolder" = "project_infra_app",
        "Environment"      = var.environment,
        "Domain"           = var.domain,
        "Location"         = var.location,
      }
    )
  )
}

