locals {
  data_authentication = {
    username = module.database_postgresql.username
    password = module.database_postgresql.password
    hostname = module.database_postgresql.hostname
    port     = module.database_postgresql.port
  }

  data_infrastructure = {
    id = module.database_postgresql.id
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

resource "massdriver_artifact" "authentication" {
  field                = "authentication"
  provider_resource_id = module.database_postgresql.id
  name                 = "Scaleway PostgreSQL Instance"
  artifact             = jsonencode(local.artifact)
}
