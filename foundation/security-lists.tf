resource "oci_core_security_list" "lb" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "${local.name_prefix}-sl-lb"

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 80
      max = 80
    }
  }

  egress_security_rules {
    protocol    = "6"
    destination = var.app_subnet_cidr

    tcp_options {
      min = 80
      max = 80
    }
  }

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}

resource "oci_core_security_list" "firewall" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "${local.name_prefix}-sl-firewall"

  ingress_security_rules {
    protocol = "all"
    source   = var.lb_public_subnet_cidr
  }

  ingress_security_rules {
    protocol = "all"
    source   = var.app_subnet_cidr
  }

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}

resource "oci_core_security_list" "app" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "${local.name_prefix}-sl-app"

  ingress_security_rules {
    protocol = "6"
    source   = var.lb_public_subnet_cidr

    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.app_subnet_cidr

    tcp_options {
      min = 111
      max = 111
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.app_subnet_cidr

    tcp_options {
      min = 2048
      max = 2048
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.app_subnet_cidr

    tcp_options {
      min = 2049
      max = 2049
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.app_subnet_cidr

    tcp_options {
      min = 2050
      max = 2050
    }
  }

  ingress_security_rules {
    protocol = "17"
    source   = var.app_subnet_cidr

    udp_options {
      min = 111
      max = 111
    }
  }

  ingress_security_rules {
    protocol = "17"
    source   = var.app_subnet_cidr

    udp_options {
      min = 2048
      max = 2048
    }
  }

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"

    tcp_options {
      min = 80
      max = 80
    }
  }

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"

    tcp_options {
      min = 443
      max = 443
    }
  }

  egress_security_rules {
    protocol    = "17"
    destination = "0.0.0.0/0"

    udp_options {
      min = 53
      max = 53
    }
  }

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"

    tcp_options {
      min = 53
      max = 53
    }
  }

  egress_security_rules {
    protocol    = "6"
    destination = var.db_subnet_cidr

    tcp_options {
      min = 5432
      max = 5432
    }
  }

  egress_security_rules {
    protocol    = "6"
    destination = var.app_subnet_cidr

    tcp_options {
      min = 111
      max = 111
    }
  }

  egress_security_rules {
    protocol    = "6"
    destination = var.app_subnet_cidr

    tcp_options {
      min = 2048
      max = 2048
    }
  }

  egress_security_rules {
    protocol    = "6"
    destination = var.app_subnet_cidr

    tcp_options {
      min = 2049
      max = 2049
    }
  }

  egress_security_rules {
    protocol    = "6"
    destination = var.app_subnet_cidr

    tcp_options {
      min = 2050
      max = 2050
    }
  }

  egress_security_rules {
    protocol    = "17"
    destination = var.app_subnet_cidr

    udp_options {
      min = 111
      max = 111
    }
  }

  egress_security_rules {
    protocol    = "17"
    destination = var.app_subnet_cidr

    udp_options {
      min = 2048
      max = 2048
    }
  }

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}

resource "oci_core_security_list" "db" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "${local.name_prefix}-sl-db"

  ingress_security_rules {
    protocol = "6"
    source   = var.app_subnet_cidr

    tcp_options {
      min = 5432
      max = 5432
    }
  }

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}
