variable "org_id" {
  default     = "176230173478"
  description = "Organization ID"
  type        = string
}

variable "client_projects" {
  default     = ["client1-hipaa-20250509033526", "client2-hipaa-20250509033526"]
  description = "HIPAA client project IDs"
  type        = list(string)
}

variable "ip_subnetworks" {
  default     = ["203.0.113.0/32"]
  description = "Allowed IP ranges"
  type        = list(string)
}

variable "os_constraints" {
  default = [
    { osType = "DESKTOP_WINDOWS", osVersion = "" },
    { osType = "DESKTOP_MAC",     osVersion = "" },
  ]
  description = "Allowed device OS types"
  type = list(object({
    osType    = string
    osVersion = string
  }))
}

variable "restricted_services" {
  description = "Google Cloud services to restrict with VPC SC"
  type        = list(string)
  default = [
    "bigquery.googleapis.com",
    "storage.googleapis.com",
    "cloudfunctions.googleapis.com",
    "cloudkms.googleapis.com"
  ]
}
