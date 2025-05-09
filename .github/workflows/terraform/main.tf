# Access Level with IP-based access control
resource "google_access_context_manager_access_level" "basic_access" {
  parent = "accessPolicies/233140867390"
  name   = "accessPolicies/233140867390/accessLevels/basic_access"
  title  = "Basic IP-Based Access"
  basic {
    conditions {
      ip_subnetworks = [
        "203.0.113.0/32",
        "35.31.169.6/32"  # VM's IP address
      ]
    }
  }
}

# Service Perimeter for client1
resource "google_access_context_manager_service_perimeter" "client1_perimeter" {
  parent = "accessPolicies/233140867390"
  name   = "accessPolicies/233140867390/servicePerimeters/client1_perimeter"
  title  = "Client 1 Basic Perimeter"
  
  status {
    resources = ["projects/62088919980"]
    restricted_services = [
      "storage.googleapis.com",
      "bigquery.googleapis.com",
      "cloudfunctions.googleapis.com",
      "cloudkms.googleapis.com",
      "compute.googleapis.com"
    ]
    access_levels = [google_access_context_manager_access_level.basic_access.name]
  }
}

# Service Perimeter for client2
resource "google_access_context_manager_service_perimeter" "client2_perimeter" {
  parent = "accessPolicies/233140867390"
  name   = "accessPolicies/233140867390/servicePerimeters/client2_perimeter"
  title  = "Client 2 Basic Perimeter"
  
  status {
    resources = ["projects/366664359091"]
    restricted_services = [
      "storage.googleapis.com",
      "bigquery.googleapis.com",
      "cloudfunctions.googleapis.com",
      "cloudkms.googleapis.com",
      "compute.googleapis.com"
    ]
    access_levels = [google_access_context_manager_access_level.basic_access.name]
  }
}

# Audit logging configuration for VPC SC violations
resource "google_project_iam_audit_config" "vpc_sc_audit_client1" {
  project = "client1-hipaa-20250509033526"
  service = "allServices"
  
  audit_log_config {
    log_type = "DATA_READ"
  }
  audit_log_config {
    log_type = "DATA_WRITE"
  }
  audit_log_config {
    log_type = "ADMIN_READ"
  }
}

resource "google_project_iam_audit_config" "vpc_sc_audit_client2" {
  project = "client2-hipaa-20250509033526"
  service = "allServices"
  
  audit_log_config {
    log_type = "DATA_READ"
  }
  audit_log_config {
    log_type = "DATA_WRITE"
  }
  audit_log_config {
    log_type = "ADMIN_READ"
  }
}
