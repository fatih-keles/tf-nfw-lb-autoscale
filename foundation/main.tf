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
}

resource "oci_core_route_table" "app_rt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "${local.name_prefix}-app-rt"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat.id
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
resource "oci_core_subnet" "lb_public" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  cidr_block     = var.public_lb_subnet_cidr
  display_name   = "${local.name_prefix}-lb-public-subnet"
  route_table_id = oci_core_route_table.public_lb_rt.id
  security_list_ids = [oci_core_security_list.lb.id]

  prohibit_public_ip_on_vnic = false
  dns_label                  = "lbpub"
}


resource "oci_core_subnet" "app_private" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  cidr_block     = var.app_subnet_cidr
  display_name   = "${local.name_prefix}-app-private-subnet"
  route_table_id = oci_core_route_table.app_rt.id
  security_list_ids = [oci_core_security_list.app.id]

  prohibit_public_ip_on_vnic = true
  dns_label                  = "app"
}

resource "oci_core_subnet" "db_private" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  cidr_block     = var.db_subnet_cidr
  display_name   = "${local.name_prefix}-db-private-subnet"
  route_table_id = oci_core_route_table.db_rt.id
  security_list_ids = [oci_core_security_list.db.id]

  prohibit_public_ip_on_vnic = true
  dns_label                  = "db"
}

# -------------------------
# NSGs (baseline, rules added later)
# -------------------------
resource "oci_core_network_security_group" "lb" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "${local.name_prefix}-nsg-lb"
}

resource "oci_core_network_security_group" "app" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "${local.name_prefix}-nsg-app"
}

resource "oci_core_network_security_group" "db" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "${local.name_prefix}-nsg-db"
}

resource "oci_core_network_security_group" "fss" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "${local.name_prefix}-nsg-fss"
}
