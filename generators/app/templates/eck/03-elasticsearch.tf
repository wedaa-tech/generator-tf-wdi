resource "kubectl_manifest" "elasticsearch" {
  yaml_body = <<YAML
      apiVersion: elasticsearch.k8s.elastic.co/v1
      kind: Elasticsearch
      metadata:
        name: quickstart
      spec:
        version: 8.7.0
        nodeSets:
        - name: default
          count: 1
          config:
            node.store.allow_mmap: false
          podTemplate:
            spec:
              affinity:
                nodeAffinity:
                  requiredDuringSchedulingIgnoredDuringExecution:
                    nodeSelectorTerms:
                    - matchExpressions:
                      - key: eks.amazonaws.com/nodegroup
                        operator: In
                        values:
                        - ${var.cluster_name}-eck-node-group
  YAML

  depends_on = [
    kubectl_manifest.operator
  ]
}

resource "kubectl_manifest" "elasticsearch_lb" {
  yaml_body = <<YAML
      apiVersion: v1
      kind: Service
      metadata:
        name: elasticsearch-nlb
        annotations:
          service.beta.kubernetes.io/aws-load-balancer-type: external 
          service.beta.kubernetes.io/aws-load-balancer-scheme: internet-facing
          service.beta.kubernetes.io/aws-load-balancer-nlb-target-type: instance
        namespace: default
      spec:
        type: LoadBalancer
        ports:
          - port: 9200
            targetPort: 9200
            name: http
        selector:
          common.k8s.elastic.co/type: elasticsearch
          elasticsearch.k8s.elastic.co/cluster-name: quickstart
  YAML

  depends_on = [
    kubectl_manifest.elasticsearch
  ]
}
