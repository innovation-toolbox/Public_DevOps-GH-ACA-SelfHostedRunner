variable "environment" {
  type        = string
  default     = "dev"
  description = "The environment name"
  validation {
    condition     = can(regex("dev|stag|prod", var.environment))
    error_message = "The environment name value is not valid."
  }
}

variable "domain" {
  type        = string
  default     = "ntwrk"
  description = "The domain name"
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "The Azure region where the resources should be created"
}

variable "tags" {
  type        = map(any)
  description = "The custom tags for all resources"
  default     = {}
}

variable "resource_group_name_suffix" {
  type        = string
  default     = "01"
  description = "The resource group name suffix"
  validation {
    condition     = can(regex("[0-9]{2}", var.resource_group_name_suffix))
    error_message = "The resource group name suffix value is not valid."
  }
}

variable "vnet_address_prefix" {
  type        = string
  description = "Vnet Address prefix"
  default     = "10.0"
}

variable "vnet_address_suffix" {
  type        = string
  description = "Vnet Address suffix"
  default     = ".0.0/16"
}

variable "paas_subnet_address_suffix" {
  type        = string
  description = "Platform as a Service Subnet Address Suffix"
  default     = ".0.0/24"
}

variable "container_apps_environment_subnet_address_suffix" {
  type        = string
  description = "Container Apps Environment Subnet Address Suffix"
  default     = ".2.0/23"
}

variable "app_service_subnet_address_suffix" {
  type        = string
  description = "App Service Plan Subnet Address Suffix"
  default     = ".4.0/26"
}

variable "bastion_subnet_address_suffix" {
  type        = string
  description = "Bastion Subnet Address Suffix"
  default     = ".4.64/26"
}