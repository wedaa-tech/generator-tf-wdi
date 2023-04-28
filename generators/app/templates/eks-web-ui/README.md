# Deploy Kubernetes Dashboard in EKS

Kubernetes Dashboard is a web-based user interface that allows users to manage, monitor, and troubleshoot Kubernetes clusters. It provides an overview of the cluster's resources, such as nodes, pods, services, and deployments, and allows users to perform common tasks, such as scaling up or down a deployment, updating a service, or deleting a pod.

The dashboard is an open-source project and can be installed on any Kubernetes cluster. It is included as a default add-on in some Kubernetes distributions, such as Google Kubernetes Engine (GKE) and Azure Kubernetes Service (AKS), but may need to be installed separately in other environments(AWS). 

To access the dashboard, users need to authenticate and authorize themselves using a Kubernetes service account or a user token. Once authenticated, users can navigate through the dashboard to view and manage the cluster's resources.

The Kubernetes Dashboard provides an intuitive and user-friendly interface for Kubernetes administrators and developers to manage and monitor their clusters, making it a valuable tool for anyone working with Kubernetes.

## Getting Started

### How to access the Kubernetes Dashboard?

>RUN below cmd
```
kubectl proxy
```
---

> Access the Kubernetes Dashboard using below link 
```
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login
```

> RUN the below cmd to get the access to login to dashboard 
```
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')
```

Use the above generated access token on to the login page to access the Kubernetes WEB UI.

Ref:
https://repost.aws/knowledge-center/eks-cluster-kubernetes-dashboard


Ref:
https://github.com/kubernetes/dashboard/releases

for compatible version of 
dashboard and dashboard metric service
