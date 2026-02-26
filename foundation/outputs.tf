output "compartment_ocid" { value = var.compartment_ocid }

output "vcn_id" { value = oci_core_vcn.this.id }

output "firewall_public_subnet_id" { value = oci_core_subnet.firewall_public.id }
output "lb_public_subnet_id" { value = oci_core_subnet.lb_public.id }
output "app_private_subnet_id" { value = oci_core_subnet.app_private.id }
output "db_private_subnet_id" { value = oci_core_subnet.db_private.id }

output "igw_id" { value = oci_core_internet_gateway.igw.id }
output "nat_id" { value = oci_core_nat_gateway.nat.id }

output "network_firewall_policy_id" { value = oci_network_firewall_network_firewall_policy.this.id }
output "network_firewall_id" { value = oci_network_firewall_network_firewall.this.id }
output "network_firewall_private_ip" { value = oci_network_firewall_network_firewall.this.ipv4address }

output "lb_public_ip_id" {
  value = oci_core_public_ip.lb_reserved.id
}

output "lb_public_ip" {
  value = oci_core_public_ip.lb_reserved.ip_address
}

# -------------------------
# FSS Outputs
# -------------------------

output "fss_id" {
  value = oci_file_storage_file_system.fss.id
}

output "fss_mount_target_id" {
  value = oci_file_storage_mount_target.fss.id
}

output "fss_mount_ip" {
  value = oci_file_storage_mount_target.fss.ip_address
}

output "fss_export_path" {
  value = var.fss_export_path
}

output "availability_domain" {
  value = local.ad_name
}
