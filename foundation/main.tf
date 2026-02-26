# -------------------------
# VCN
# -------------------------
resource "oci_core_vcn" "this" {
  compartment_id = var.compartment_ocid
  cidr_block     = var.vcn_cidr
  display_name   = "${local.name_prefix}-vcn"
  dns_label      = var.dns_label
}

# -------------------------
# Gateways
# -------------------------
resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "${local.name_prefix}-igw"
  enabled        = true
}

resource "oci_core_nat_gateway" "nat" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "${local.name_prefix}-nat"
}

# Optional but recommended if you’ll access OCI services privately (Object Storage, etc.)
# You can add Service Gateway later if needed.

# -------------------------
# Route Tables
# -------------------------
resource "oci_core_route_table" "public_lb_rt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "${local.name_prefix}-public-lb-rt"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw.id
  }

  route_rules {
    destination       = var.app_subnet_cidr
    destination_type  = "CIDR_BLOCK"
    network_entity_id = data.oci_core_private_ips.network_firewall_ip.private_ips[0].id
  }
}

resource "oci_core_route_table" "firewall_public_rt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "${local.name_prefix}-firewall-public-rt"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat.id
  }
}

resource "oci_core_route_table" "app_rt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "${local.name_prefix}-app-rt"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = data.oci_core_private_ips.network_firewall_ip.private_ips[0].id
  }

  route_rules {
    destination       = var.lb_public_subnet_cidr
    destination_type  = "CIDR_BLOCK"
    network_entity_id = data.oci_core_private_ips.network_firewall_ip.private_ips[0].id
  }
}

resource "oci_core_route_table" "db_rt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "${local.name_prefix}-db-rt"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat.id
  }
}


# -------------------------
# Subnets
# -------------------------
resource "oci_core_subnet" "firewall_public" {
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_vcn.this.id
  cidr_block        = var.firewall_public_subnet_cidr
  display_name      = "${local.name_prefix}-firewall-public-subnet"
  route_table_id    = oci_core_route_table.firewall_public_rt.id
  security_list_ids = [oci_core_security_list.firewall.id]

  prohibit_public_ip_on_vnic = false
  dns_label                  = "fwpub"
}

resource "oci_core_subnet" "lb_public" {
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_vcn.this.id
  cidr_block        = var.lb_public_subnet_cidr
  display_name      = "${local.name_prefix}-lb-public-subnet"
  route_table_id    = oci_core_route_table.public_lb_rt.id
  security_list_ids = [oci_core_security_list.lb.id]

  prohibit_public_ip_on_vnic = false
  dns_label                  = "lbpub"
}


resource "oci_core_subnet" "app_private" {
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_vcn.this.id
  cidr_block        = var.app_subnet_cidr
  display_name      = "${local.name_prefix}-app-private-subnet"
  route_table_id    = oci_core_route_table.app_rt.id
  security_list_ids = [oci_core_security_list.app.id]

  prohibit_public_ip_on_vnic = true
  dns_label                  = "app"
}

resource "oci_core_subnet" "db_private" {
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_vcn.this.id
  cidr_block        = var.db_subnet_cidr
  display_name      = "${local.name_prefix}-db-private-subnet"
  route_table_id    = oci_core_route_table.db_rt.id
  security_list_ids = [oci_core_security_list.db.id]

  prohibit_public_ip_on_vnic = true
  dns_label                  = "db"
}

# -------------------------
# OCI Network Firewall
# -------------------------
resource "oci_network_firewall_network_firewall_policy" "this" {
  compartment_id = var.compartment_ocid
  display_name   = "${local.name_prefix}-nfw-policy"
}

resource "oci_network_firewall_network_firewall_policy_security_rule" "allow_all" {
  action                     = "ALLOW"
  name                       = "allow-all"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.this.id

  condition {}
}

resource "oci_network_firewall_network_firewall" "this" {
  compartment_id             = var.compartment_ocid
  display_name               = "${local.name_prefix}-nfw"
  subnet_id                  = oci_core_subnet.firewall_public.id
  ipv4address                = var.network_firewall_private_ip
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.this.id
}

# -------------------------
# OCI Network Firewall Traffic Logging
# -------------------------
resource "oci_logging_log_group" "nfw" {
  compartment_id = var.compartment_ocid
  display_name   = "${local.name_prefix}-nfw-log-group"
}

resource "oci_logging_log" "nfw_traffic" {
  display_name   = "${local.name_prefix}-nfw-traffic-log"
  log_group_id   = oci_logging_log_group.nfw.id
  log_type       = "SERVICE"
  is_enabled     = true

  configuration {
    source {
      source_type = "OCISERVICE"
      service     = "ocinetworkfirewall"
      category    = "trafficlog"
      resource    = oci_network_firewall_network_firewall.this.id
    }
  }
}
