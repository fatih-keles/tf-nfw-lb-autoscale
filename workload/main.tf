locals {
  compartment_ocid      = data.terraform_remote_state.foundation.outputs.compartment_ocid
  availability_domain   = data.terraform_remote_state.foundation.outputs.availability_domain
  lb_public_subnet_id   = data.terraform_remote_state.foundation.outputs.lb_public_subnet_id
  lb_public_ip_id       = data.terraform_remote_state.foundation.outputs.lb_public_ip_id
  app_private_subnet_id = data.terraform_remote_state.foundation.outputs.app_private_subnet_id
  db_private_subnet_id  = data.terraform_remote_state.foundation.outputs.db_private_subnet_id
  fss_mount_ip          = data.terraform_remote_state.foundation.outputs.fss_mount_ip
  fss_export_path       = data.terraform_remote_state.foundation.outputs.fss_export_path
}
