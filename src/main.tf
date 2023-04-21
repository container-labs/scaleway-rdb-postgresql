module "database_postgresql" {
  source             = "container-labs/rdb-postgresql/scaleway"
  version            = "~> 0.1"
  name               = var.md_metadata.name_prefix
  tags               = var.md_metadata.default_tags
  private_network_id = var.network.data.infrastructure.id
  region             = var.network.specs.scaleway.region
  node_type          = var.node_type
  postgres_version   = var.postgres_version
  cluster_mode       = var.cluster_mode
  backups = {
    enabled        = var.backups.enabled
    retention_days = try(var.backups.retention_days, null)
    frequency_days = try(var.backups.frequency_days, null)
  }
}
