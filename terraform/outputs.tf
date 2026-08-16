output "resource_group_name" {
  description = "AKS platform resource group."
  value       = azurerm_resource_group.this.name
}

output "cluster_name" {
  description = "AKS cluster name."
  value       = azurerm_kubernetes_cluster.this.name
}

output "oidc_issuer_url" {
  description = "AKS OIDC issuer used for workload identity federation."
  value       = azurerm_kubernetes_cluster.this.oidc_issuer_url
}

output "container_registry_login_server" {
  description = "ACR login server."
  value       = azurerm_container_registry.this.login_server
}

output "key_vault_uri" {
  description = "Azure Key Vault URI."
  value       = azurerm_key_vault.this.vault_uri
}
