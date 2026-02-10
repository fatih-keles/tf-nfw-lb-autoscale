# -------------------------
# File Storage Service
# -------------------------

resource "oci_file_storage_file_system" "fss" {
  availability_domain = local.ad_name
  compartment_id      = var.compartment_ocid
  display_name        = "${var.project_name}-fss"
}

# -------------------------
# Mount Target
# -------------------------

resource "oci_file_storage_mount_target" "fss" {
  availability_domain = local.ad_name
  compartment_id      = var.compartment_ocid
  subnet_id           = oci_core_subnet.app_private.id
  display_name        = "${var.project_name}-fss-mt"

  nsg_ids = [
    oci_core_network_security_group.fss.id
  ]
}

# -------------------------
# Export Set
# -------------------------

resource "oci_file_storage_export" "fss" {
  export_set_id  = oci_file_storage_mount_target.fss.export_set_id
  file_system_id = oci_file_storage_file_system.fss.id
  path           = var.fss_export_path

  export_options {
    source                         = var.app_subnet_cidr
    access                         = "READ_WRITE"
    identity_squash                = "NONE"
    require_privileged_source_port = false
  }
}
