data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}

data "oci_core_private_ips" "network_firewall_ip" {
  subnet_id  = oci_core_subnet.firewall_public.id
  ip_address = var.network_firewall_private_ip

  depends_on = [oci_network_firewall_network_firewall.this]
}
