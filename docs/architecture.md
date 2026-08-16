# AKS Platform Architecture

## Platform model

The repository separates Azure infrastructure provisioning from Kubernetes workload configuration. Terraform owns the Azure control-plane resources; Kubernetes manifests describe the sample workload running on the cluster.

## Identity

AKS enables an OIDC issuer and Microsoft Entra Workload Identity. This allows Kubernetes service accounts to federate to Azure managed identities without storing client secrets inside Kubernetes Secrets or CI/CD variables.

The cluster itself uses a system-assigned managed identity, and the kubelet identity receives `AcrPull` on the platform Azure Container Registry.

## Networking

The cluster uses Azure CNI with a dedicated subnet. Service addresses use a separate non-overlapping CIDR. The sample workload is exposed internally through a ClusterIP service and routed through an Ingress object rather than creating a public LoadBalancer service for every workload.

A production design could extend this with private AKS API access, Azure Firewall, NAT Gateway, private ACR/Key Vault endpoints, internal ingress, private DNS, network policies, and controlled egress.

## Secrets

The AKS Key Vault Secrets Store CSI provider is enabled with secret rotation. The intended pattern is for workloads to retrieve secrets from Azure Key Vault through workload identity rather than copying long-lived secrets into deployment YAML.

## Governance

The Azure Policy add-on is enabled so Kubernetes governance controls can complement admission controls and CI security scanning. GitHub Actions runs Trivy against both Terraform and Kubernetes configuration before changes are accepted.

## Observability

AKS sends monitoring data to a centralized Log Analytics workspace through the OMS agent integration. Production platforms would typically add managed Prometheus, Azure Managed Grafana, alert rules, SLOs, application telemetry, and centralized diagnostic settings.

## Scaling and resilience

The system node pool uses cluster autoscaling. The sample workload uses multiple replicas, readiness/liveness probes, resource requests and limits, and a HorizontalPodAutoscaler. These demonstrate the separation between infrastructure scaling and application-level scaling.

## Container security

The sample container runs as a non-root user with privilege escalation disabled, Linux capabilities dropped, RuntimeDefault seccomp, and a read-only root filesystem. Writable runtime paths are backed by ephemeral `emptyDir` volumes.

## Production extensions

A larger enterprise platform would commonly add:

- Private AKS cluster/API endpoint
- Separate system and user node pools
- Availability-zone-aware node pools
- Azure CNI Overlay or Cilium based on network requirements
- Private Link for ACR and Key Vault
- Managed Prometheus and Grafana
- GitOps with Flux or Argo CD
- cert-manager and production ingress architecture
- Pod Disruption Budgets
- Azure Policy / Gatekeeper constraints
- Backup and disaster recovery strategy
- Remote Terraform state and environment isolation
