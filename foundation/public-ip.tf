resource "oci_core_public_ip" "lb_reserved" {
  compartment_id = var.compartment_ocid
  lifetime       = "RESERVED"
  display_name   = "${local.name_prefix}-lb-public-ip"
}
