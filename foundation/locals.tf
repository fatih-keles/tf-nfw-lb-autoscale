locals {
  name_prefix = var.project_name
  ad_name     = data.oci_identity_availability_domains.ads.availability_domains[0].name
}
