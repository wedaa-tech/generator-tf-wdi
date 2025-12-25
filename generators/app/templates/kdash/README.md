<%_ if (cloudProvider == "aws") { _%>
# Kubernetes Dashboard in AWS 
<%_ } _%>
<%_ if (cloudProvider == "azure") { _%>
# Kubernetes Dashboard in azure
<%_ } _%>

Kubernetes Dashboard is a web-based user interface that allows users to manage, monitor, and troubleshoot Kubernetes clusters. It provides an overview of the cluster's resources, such as nodes, pods, services, and deployments, and allows users to perform common tasks, such as scaling up or down a deployment, updating a service, or deleting a pod.

The dashboard is an open-source project and can be installed on any Kubernetes cluster.

To access the dashboard, users need to authenticate and authorize themselves using a Kubernetes service account or a user token. Once authenticated, users can navigate through the dashboard to view and manage the cluster's resources.

The Kubernetes Dashboard provides an intuitive and user-friendly interface for Kubernetes administrators and developers to manage and monitor their clusters, making it a valuable tool for anyone working with Kubernetes.

## Getting Started

### How to access the Kubernetes Dashboard?

> Step 1: Port Forward (Recommended for Development)
```bash
# Port forward the Kong proxy service
kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8443:443
```
---

> Step 2: Using the Admin Token
```bash
kubectl get secret kdash-admin-token -n kubernetes-dashboard -o jsonpath="{.data.token}" | base64 -d
```

> Step 3: Access the dashboard

1. Open your browser and navigate to: **https://localhost:8443**

2. Use the above generated access token on to the login page to access the Kubernetes WEB UI.
