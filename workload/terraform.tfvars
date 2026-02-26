# region = "<will be set from env variable in .env file>"

# project_name       = "<will be set from env variable in .env file>"
app_instance_count = 2
app_shape          = "VM.Standard.E5.Flex"
app_ocpus          = 4
app_memory_gbs     = 48
# fss_mount_path     = "<will be set from env variable in .env file>"
# bucket     = "<will be set from env variable in .env file>"
# namespace  = "<will be set from env variable in .env file>"


# ssh_public_key = "<will be set from env variable in .env file>"

# user_name = "<will be set from env variable in .env file>"
# user_passwd_hash = "<will be set from env variable in .env file>"

waf_allowed_country_code = "AE"

psql_db_name        = "demo-psql-db"
psql_db_version     = "15"
psql_instance_count = 2
psql_ocpus          = 2
psql_memory_gbs     = 32
# psql_admin_username = "<will be set from env variable in .env file>"
# psql_admin_password = "<will be set from env variable in .env file>"
psql_backup_copy_region = "me-jeddah-1"