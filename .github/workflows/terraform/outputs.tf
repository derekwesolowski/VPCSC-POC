output "access_policy_name" {
  description = "The name of the created access policy"
  value       = google_access_context_manager_access_policy.vpc_sc_policy.name
}

output "service_perimeter_name" {
  description = "The name of the created service perimeter"
  value       = google_access_context_manager_service_perimeter.vpc_sc_perimeter.name
}
