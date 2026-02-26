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

variable "psql_db_name" {
  type = string
}

variable "psql_db_version" {
  type = string
}

variable "psql_instance_count" {
  type = number
}

variable "psql_shape" {
  type    = string
  default = "PostgreSQL.VM.Standard.E5.Flex"
}

variable "psql_ocpus" {
  type = number
}

variable "psql_memory_gbs" {
  type = number
}

variable "psql_admin_username" {
  type = string
}

variable "psql_admin_password" {
  type      = string
  sensitive = true
}

variable "psql_backup_start" {
  type    = string
  default = "02:00"
}

variable "psql_backup_copy_region" {
  type = string
}

variable "psql_backup_retention_days" {
  type    = number
  default = 1
}

variable "psql_default_config_display_name" {
  type    = string
  default = "PostgreSQL.X86-15-0_20"
}
