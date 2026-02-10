# -------------------------
# FSS NSG rules
# -------------------------

# Ingress TCP 111, 2048, 2049, 2050 from App subnet
resource "oci_core_network_security_group_security_rule" "fss_ingress_tcp_111" {
	network_security_group_id = oci_core_network_security_group.fss.id
	direction                 = "INGRESS"
	protocol                  = "6" # TCP

	source      = var.app_subnet_cidr
	source_type = "CIDR_BLOCK"

	tcp_options {
		destination_port_range {
			min = 111
			max = 111
		}
	}

	description = "Allow TCP 111 from App subnet to FSS"
}

resource "oci_core_network_security_group_security_rule" "fss_ingress_tcp_2048" {
	network_security_group_id = oci_core_network_security_group.fss.id
	direction                 = "INGRESS"
	protocol                  = "6" # TCP

	source      = var.app_subnet_cidr
	source_type = "CIDR_BLOCK"

	tcp_options {
		destination_port_range {
			min = 2048
			max = 2048
		}
	}

	description = "Allow TCP 2048 from App subnet to FSS"
}

resource "oci_core_network_security_group_security_rule" "fss_ingress_tcp_2049" {
	network_security_group_id = oci_core_network_security_group.fss.id
	direction                 = "INGRESS"
	protocol                  = "6" # TCP

	source      = var.app_subnet_cidr
	source_type = "CIDR_BLOCK"

	tcp_options {
		destination_port_range {
			min = 2049
			max = 2049
		}
	}

	description = "Allow TCP 2049 from App subnet to FSS"
}

resource "oci_core_network_security_group_security_rule" "fss_ingress_tcp_2050" {
	network_security_group_id = oci_core_network_security_group.fss.id
	direction                 = "INGRESS"
	protocol                  = "6" # TCP

	source      = var.app_subnet_cidr
	source_type = "CIDR_BLOCK"

	tcp_options {
		destination_port_range {
			min = 2050
			max = 2050
		}
	}

	description = "Allow TCP 2050 from App subnet to FSS"
}

# Ingress UDP 111, 2048 from App subnet
resource "oci_core_network_security_group_security_rule" "fss_ingress_udp_111" {
	network_security_group_id = oci_core_network_security_group.fss.id
	direction                 = "INGRESS"
	protocol                  = "17" # UDP

	source      = var.app_subnet_cidr
	source_type = "CIDR_BLOCK"

	udp_options {
		destination_port_range {
			min = 111
			max = 111
		}
	}

	description = "Allow UDP 111 from App subnet to FSS"
}

resource "oci_core_network_security_group_security_rule" "fss_ingress_udp_2048" {
	network_security_group_id = oci_core_network_security_group.fss.id
	direction                 = "INGRESS"
	protocol                  = "17" # UDP

	source      = var.app_subnet_cidr
	source_type = "CIDR_BLOCK"

	udp_options {
		destination_port_range {
			min = 2048
			max = 2048
		}
	}

	description = "Allow UDP 2048 from App subnet to FSS"
}

# Egress TCP 111, 2048, 2049, 2050 to App subnet
resource "oci_core_network_security_group_security_rule" "fss_egress_tcp_111" {
	network_security_group_id = oci_core_network_security_group.fss.id
	direction                 = "EGRESS"
	protocol                  = "6" # TCP

	destination      = var.app_subnet_cidr
	destination_type = "CIDR_BLOCK"

	tcp_options {
		destination_port_range {
			min = 111
			max = 111
		}
	}

	description = "Allow TCP 111 to App subnet from FSS"
}

resource "oci_core_network_security_group_security_rule" "fss_egress_tcp_2048" {
	network_security_group_id = oci_core_network_security_group.fss.id
	direction                 = "EGRESS"
	protocol                  = "6" # TCP

	destination      = var.app_subnet_cidr
	destination_type = "CIDR_BLOCK"

	tcp_options {
		destination_port_range {
			min = 2048
			max = 2048
		}
	}

	description = "Allow TCP 2048 to App subnet from FSS"
}

resource "oci_core_network_security_group_security_rule" "fss_egress_tcp_2049" {
	network_security_group_id = oci_core_network_security_group.fss.id
	direction                 = "EGRESS"
	protocol                  = "6" # TCP

	destination      = var.app_subnet_cidr
	destination_type = "CIDR_BLOCK"

	tcp_options {
		destination_port_range {
			min = 2049
			max = 2049
		}
	}

	description = "Allow TCP 2049 to App subnet from FSS"
}

resource "oci_core_network_security_group_security_rule" "fss_egress_tcp_2050" {
	network_security_group_id = oci_core_network_security_group.fss.id
	direction                 = "EGRESS"
	protocol                  = "6" # TCP

	destination      = var.app_subnet_cidr
	destination_type = "CIDR_BLOCK"

	tcp_options {
		destination_port_range {
			min = 2050
			max = 2050
		}
	}

	description = "Allow TCP 2050 to App subnet from FSS"
}

# Egress UDP 111, 2048 to App subnet
resource "oci_core_network_security_group_security_rule" "fss_egress_udp_111" {
	network_security_group_id = oci_core_network_security_group.fss.id
	direction                 = "EGRESS"
	protocol                  = "17" # UDP

	destination      = var.app_subnet_cidr
	destination_type = "CIDR_BLOCK"

	udp_options {
		destination_port_range {
			min = 111
			max = 111
		}
	}

	description = "Allow UDP 111 to App subnet from FSS"
}

resource "oci_core_network_security_group_security_rule" "fss_egress_udp_2048" {
	network_security_group_id = oci_core_network_security_group.fss.id
	direction                 = "EGRESS"
	protocol                  = "17" # UDP

	destination      = var.app_subnet_cidr
	destination_type = "CIDR_BLOCK"

	udp_options {
		destination_port_range {
			min = 2048
			max = 2048
		}
	}

	description = "Allow UDP 2048 to App subnet from FSS"
}

# App NSG egress to FSS mount target (same subnet)
resource "oci_core_network_security_group_security_rule" "app_egress_fss_tcp_111" {
	network_security_group_id = oci_core_network_security_group.app.id
	direction                 = "EGRESS"
	protocol                  = "6" # TCP

	destination      = var.app_subnet_cidr
	destination_type = "CIDR_BLOCK"

	tcp_options {
		destination_port_range {
			min = 111
			max = 111
		}
	}

	description = "Allow App egress TCP 111 to FSS mount target"
}

resource "oci_core_network_security_group_security_rule" "app_egress_fss_tcp_2048" {
	network_security_group_id = oci_core_network_security_group.app.id
	direction                 = "EGRESS"
	protocol                  = "6" # TCP

	destination      = var.app_subnet_cidr
	destination_type = "CIDR_BLOCK"

	tcp_options {
		destination_port_range {
			min = 2048
			max = 2048
		}
	}

	description = "Allow App egress TCP 2048 to FSS mount target"
}

resource "oci_core_network_security_group_security_rule" "app_egress_fss_tcp_2049" {
	network_security_group_id = oci_core_network_security_group.app.id
	direction                 = "EGRESS"
	protocol                  = "6" # TCP

	destination      = var.app_subnet_cidr
	destination_type = "CIDR_BLOCK"

	tcp_options {
		destination_port_range {
			min = 2049
			max = 2049
		}
	}

	description = "Allow App egress TCP 2049 to FSS mount target"
}

resource "oci_core_network_security_group_security_rule" "app_egress_fss_tcp_2050" {
	network_security_group_id = oci_core_network_security_group.app.id
	direction                 = "EGRESS"
	protocol                  = "6" # TCP

	destination      = var.app_subnet_cidr
	destination_type = "CIDR_BLOCK"

	tcp_options {
		destination_port_range {
			min = 2050
			max = 2050
		}
	}

	description = "Allow App egress TCP 2050 to FSS mount target"
}

resource "oci_core_network_security_group_security_rule" "app_egress_fss_udp_111" {
	network_security_group_id = oci_core_network_security_group.app.id
	direction                 = "EGRESS"
	protocol                  = "17" # UDP

	destination      = var.app_subnet_cidr
	destination_type = "CIDR_BLOCK"

	udp_options {
		destination_port_range {
			min = 111
			max = 111
		}
	}

	description = "Allow App egress UDP 111 to FSS mount target"
}

resource "oci_core_network_security_group_security_rule" "app_egress_fss_udp_2048" {
	network_security_group_id = oci_core_network_security_group.app.id
	direction                 = "EGRESS"
	protocol                  = "17" # UDP

	destination      = var.app_subnet_cidr
	destination_type = "CIDR_BLOCK"

	udp_options {
		destination_port_range {
			min = 2048
			max = 2048
		}
	}

	description = "Allow App egress UDP 2048 to FSS mount target"
}

# -------------------------
# LB -> App NSG rules
# -------------------------

resource "oci_core_network_security_group_security_rule" "lb_ingress_http" {
	network_security_group_id = oci_core_network_security_group.lb.id
	direction                 = "INGRESS"
	protocol                  = "6" # TCP

	source      = "0.0.0.0/0"
	source_type = "CIDR_BLOCK"

	tcp_options {
		destination_port_range {
			min = 80
			max = 80
		}
	}

	description = "Allow HTTP from Internet to public LB"
}

resource "oci_core_network_security_group_security_rule" "lb_egress_to_app_80" {
	network_security_group_id = oci_core_network_security_group.lb.id
	direction                 = "EGRESS"
	protocol                  = "6" # TCP

	destination      = oci_core_network_security_group.app.id
	destination_type = "NETWORK_SECURITY_GROUP"

	tcp_options {
		destination_port_range {
			min = 80
			max = 80
		}
	}

	description = "Allow LB egress to App NSG on 80"
}

resource "oci_core_network_security_group_security_rule" "app_ingress_from_lb_80" {
	network_security_group_id = oci_core_network_security_group.app.id
	direction                 = "INGRESS"
	protocol                  = "6" # TCP

	source      = oci_core_network_security_group.lb.id
	source_type = "NETWORK_SECURITY_GROUP"

	tcp_options {
		destination_port_range {
			min = 80
			max = 80
		}
	}

	description = "Allow traffic from LB NSG to App NSG on 80"
}

# -------------------------
# App NSG egress for Internet access (via NAT)
# -------------------------

resource "oci_core_network_security_group_security_rule" "app_egress_http" {
	network_security_group_id = oci_core_network_security_group.app.id
	direction                 = "EGRESS"
	protocol                  = "6" # TCP

	destination      = "0.0.0.0/0"
	destination_type = "CIDR_BLOCK"

	tcp_options {
		destination_port_range {
			min = 80
			max = 80
		}
	}

	description = "Allow HTTP egress from App to Internet"
}

resource "oci_core_network_security_group_security_rule" "app_egress_https" {
	network_security_group_id = oci_core_network_security_group.app.id
	direction                 = "EGRESS"
	protocol                  = "6" # TCP

	destination      = "0.0.0.0/0"
	destination_type = "CIDR_BLOCK"

	tcp_options {
		destination_port_range {
			min = 443
			max = 443
		}
	}

	description = "Allow HTTPS egress from App to Internet"
}

resource "oci_core_network_security_group_security_rule" "app_egress_dns_udp" {
	network_security_group_id = oci_core_network_security_group.app.id
	direction                 = "EGRESS"
	protocol                  = "17" # UDP

	destination      = "0.0.0.0/0"
	destination_type = "CIDR_BLOCK"

	udp_options {
		destination_port_range {
			min = 53
			max = 53
		}
	}

	description = "Allow DNS UDP egress from App to Internet"
}

resource "oci_core_network_security_group_security_rule" "app_egress_dns_tcp" {
	network_security_group_id = oci_core_network_security_group.app.id
	direction                 = "EGRESS"
	protocol                  = "6" # TCP

	destination      = "0.0.0.0/0"
	destination_type = "CIDR_BLOCK"

	tcp_options {
		destination_port_range {
			min = 53
			max = 53
		}
	}

	description = "Allow DNS TCP egress from App to Internet"
}

# -------------------------
# DB NSG rules
# -------------------------

resource "oci_core_network_security_group_security_rule" "db_ingress_from_app_5432" {
	network_security_group_id = oci_core_network_security_group.db.id
	direction                 = "INGRESS"
	protocol                  = "6" # TCP

	source      = oci_core_network_security_group.app.id
	source_type = "NETWORK_SECURITY_GROUP"

	tcp_options {
		destination_port_range {
			min = 5432
			max = 5432
		}
	}

	description = "Allow PostgreSQL from App NSG to DB NSG (5432)"
}
