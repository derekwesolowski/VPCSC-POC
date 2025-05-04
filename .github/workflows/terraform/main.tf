terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
  # Comment out this section
  # backend "gcs" {
    # # Configured dynamically in the GitHub workflow
  # }
}

provider "google" {
  project = var.project_id
}

provider "google-beta" {
  project = var.project_id
}

# Get the organization ID
data "google_organization" "org" {
  domain = var.organization_domain
}

# Access context manager policy
resource "google_access_context_manager_access_policy" "vpc_sc_policy" {
  parent = "organizations/${data.google_organization.org.org_id}"
  title  = "VPC SC Policy"
}

# Service perimeter
resource "google_access_context_manager_service_perimeter" "vpc_sc_perimeter" {
  parent = "accessPolicies/${google_access_context_manager_access_policy.vpc_sc_policy.name}"
  name   = "accessPolicies/${google_access_context_manager_access_policy.vpc_sc_policy.name}/servicePerimeters/${var.perimeter_name}"
  title  = "VPC SC Perimeter"
  
  status {
    resources = ["projects/${var.project_id}"]
    restricted_services = [
      "storage.googleapis.com",
      "bigquery.googleapis.com", 
      # Add other services as needed
    ]
    
    vpc_accessible_services {
      enable_restriction = true
      allowed_services   = ["storage.googleapis.com", "bigquery.googleapis.com"]
    }
  }
}

# Optional: Access level for IP-based restrictions
resource "google_access_context_manager_access_level" "vpc_sc_access_level" {
  count  = var.create_access_level ? 1 : 0
  parent = "accessPolicies/${google_access_context_manager_access_policy.vpc_sc_policy.name}"
  name   = "accessPolicies/${google_access_context_manager_access_policy.vpc_sc_policy.name}/accessLevels/secure_access_level"
  title  = "Secure Access Level"
  
  basic {
    conditions {
      ip_subnetworks = var.allowed_ip_subnetworks
    }
  }
}
