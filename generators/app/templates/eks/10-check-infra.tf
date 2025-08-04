output "cluster_endpoint" {
  value = data.aws_eks_cluster.cluster.endpoint
}

resource "null_resource" "check-infra" {
  provisioner "local-exec" {
    command = <<-EOT
      cluster_name="${var.cluster_name}"
      region="${var.region}"
      cluster_endpoint="${data.aws_eks_cluster.cluster.endpoint}/version"

      # Get token from AWS CLI
      token=$(aws eks get-token --cluster-name "$cluster_name" --region "$region" --query 'status.token' --output text)

      # Call cluster endpoint using the token
      http_status=$(curl -k -s -o /dev/null -w "%%{http_code}" -H "Authorization: Bearer $token" "$cluster_endpoint")

      echo "HTTP status code from cluster endpoint: $http_status"

      if [ "$http_status" -eq 200 ]; then
          echo -e "\\033[32;1m 🎉🎉🎉 Cluster is up and running... 🎉🎉🎉\\033[0m"
      else
          echo -e "\\033[31;1mThere is some error with the cluster 😿\\033[0m"
      fi
    EOT

    interpreter = ["bash", "-c"]
  }
}
