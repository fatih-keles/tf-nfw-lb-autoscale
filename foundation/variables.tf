variable "region" {
  type = string
}

variable "compartment_ocid" {
  type = string
}

variable "project_name" {
  type = string
}

variable "dns_label" {
  type = string
}

variable "vcn_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "firewall_public_subnet_cidr" {
  type    = string
  default = "10.0.10.0/24"
}

variable "network_firewall_private_ip" {
  type    = string
  default = "10.0.10.10"
}

variable "lb_public_subnet_cidr" {
  type    = string
  default = "10.0.20.0/24"
}

variable "app_subnet_cidr" {
  type    = string
  default = "10.0.30.0/24"
}

variable "db_subnet_cidr" {
  type    = string
  default = "10.0.40.0/24"
}

variable "fss_export_path" {
  type = string
}
