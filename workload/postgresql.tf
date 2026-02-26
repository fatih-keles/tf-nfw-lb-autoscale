data "oci_psql_default_configurations" "postgres_default" {
  display_name = var.psql_default_config_display_name
}

resource "oci_psql_db_system" "postgres" {
  compartment_id = local.compartment_ocid
  display_name   = var.psql_db_name
  db_version     = var.psql_db_version
  shape          = var.psql_shape
  instance_count = var.psql_instance_count

  timeouts {
    create = "20m"
    update = "20m"
    delete = "20m"
  }

  instance_ocpu_count         = var.psql_ocpus
  instance_memory_size_in_gbs = var.psql_memory_gbs
  config_id = try(
    data.oci_psql_default_configurations.postgres_default.default_configuration_collection[0].items[0].id,
    null
  )

  credentials {
    username = var.psql_admin_username

    password_details {
      password_type = "PLAIN_TEXT"
      password      = var.psql_admin_password
    }
  }

  network_details {
    subnet_id                  = local.db_private_subnet_id
    is_reader_endpoint_enabled = true
  }

  storage_details {
    is_regionally_durable = false
    availability_domain   = local.availability_domain
    system_type           = "OCI_OPTIMIZED_STORAGE"
    iops                  = 75000
  }

  management_policy {
    backup_policy {
      kind           = "DAILY"
      backup_start   = var.psql_backup_start
      retention_days = var.psql_backup_retention_days

      copy_policy {
        compartment_id   = local.compartment_ocid
        regions          = [var.psql_backup_copy_region]
        retention_period = var.psql_backup_retention_days
      }
    }
  }
}
