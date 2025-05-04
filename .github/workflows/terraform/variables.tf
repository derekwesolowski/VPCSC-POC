variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "organization_domain" {
  description = "The organization domain (e.g., example.com)"
  type        = string
}

variable "perimeter_name" {
  description = "Name for the service perimeter"
  type        = string
  default     = "vpc_sc_perimeter"
}

variable "create_access_level" {
  description = "Whether to create an access level"
  type        = bool
  default     = false
}

variable "allowed_ip_subnetworks" {
  description = "List of IP subnetworks allowed in the access level"
  type        = list(string)
  default     = []
}
