output "access_level_name" {
  description = "Name of the access level"
  value       = google_access_context_manager_access_level.basic_access.name
}

output "client1_perimeter_name" {
  description = "Name of Client 1 perimeter"
  value       = google_access_context_manager_service_perimeter.client1_perimeter.name
}

output "client2_perimeter_name" {
  description = "Name of Client 2 perimeter"
  value       = google_access_context_manager_service_perimeter.client2_perimeter.name
}
