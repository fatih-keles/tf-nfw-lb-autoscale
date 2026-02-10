locals {
  compartment_ocid      = data.terraform_remote_state.foundation.outputs.compartment_ocid
  availability_domain   = data.terraform_remote_state.foundation.outputs.availability_domain
  lb_public_subnet_id   = data.terraform_remote_state.foundation.outputs.public_subnet_id
  app_private_subnet_id = data.terraform_remote_state.foundation.outputs.app_private_subnet_id
  db_private_subnet_id  = data.terraform_remote_state.foundation.outputs.db_private_subnet_id
  nsg_lb_id             = data.terraform_remote_state.foundation.outputs.nsg_lb_id
  nsg_app_id            = data.terraform_remote_state.foundation.outputs.nsg_app_id
  nsg_db_id             = data.terraform_remote_state.foundation.outputs.nsg_db_id
  fss_mount_ip          = data.terraform_remote_state.foundation.outputs.fss_mount_ip
  fss_export_path       = data.terraform_remote_state.foundation.outputs.fss_export_path
}
