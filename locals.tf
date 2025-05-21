locals {
  # Resource naming
  name_prefix = "${var.project}-${var.env}"
  
  # Full resource naming with service
  full_name = replace(
    "${var.provider_name}-${var.region}-${var.business_unit}-${var.tier}-${var.project}-${var.env}",
    "rtype",
    var.service_name
  )
  
  # Common tags for all resources
  common_tags = {
    Name           = local.full_name
    Environment    = var.env
    Project        = var.project
    BusinessUnit   = var.business_unit
    Team           = var.team
    Owner          = var.owner
    ManagedBy      = "terraform"
  }
} 