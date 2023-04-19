locals {
  data_authentication = {
    hostname = scaleway_rdb_instance.main.private_network[0].ip
    username = "root"
    password = random_password.root_user_password.result
    port     = scaleway_rdb_instance.main.private_network[0].port
  }

  data_infrastructure = {
    id = scaleway_rdb_instance.main.id
  }

  data_security = {
    iam = {
      "read" = {
        permission_set = "RelationalDatabasesReadOnly"
      }
    }
  }

  artifact = {
    data = {
      authentication = local.data_authentication
      infrastructure = local.data_infrastructure
      security       = local.data_security
    }
    specs = {
      rdbms = {
        engine  = "postgres"
        version = "14"
      }
    }
  }
}

output "pass" {
  value     = random_password.root_user_password.result
  sensitive = true
}

resource "massdriver_artifact" "authentication" {
  field                = "authentication"
  provider_resource_id = scaleway_rdb_instance.main.id
  name                 = "a contextual name for the artifact"
  artifact             = jsonencode(local.artifact)
}
