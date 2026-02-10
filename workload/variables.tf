variable "region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "fss_mount_path" {
  type = string
}

variable "bucket" {
  type = string
}

variable "namespace" {
  type = string
}

variable "app_instance_count" {
  type    = number
  default = 2
}

variable "app_shape" {
  type = string
}

variable "app_ocpus" {
  type = number
}

variable "app_memory_gbs" {
  type = number
}

variable "ssh_public_key" {
  type = string
}

variable "user_name" {
  type = string
}

variable "user_passwd_hash" {
  type = string
}

variable "waf_allowed_country_code" {
  type    = string
  default = "AE"
}
