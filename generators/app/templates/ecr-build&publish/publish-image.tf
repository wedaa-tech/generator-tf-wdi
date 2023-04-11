data "aws_caller_identity" "current" {}

resource "null_resource" "push_image_to_ecr" {

 provisioner "local-exec" {
    
    command = <<-EOT
        # Use aws cli to login to ecr 
        # aws-cli should be available and configured before ahead
        aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com

        # shifting to root directory
        cd ../../

        # Iterate over each directory
        for dir in */ ; do 
            # Check if the directory name matches a certain pattern
            if [[ "$dir" == "kubernetes/" || "$dir" == "terraform/" ]]; then
                echo "SKIPPING THIS DIR:-" $dir
                # If it matches, skip to the next directory
                continue
            fi
            # Change into the directory
            cd "$dir"
            
            echo "CURRENT DIR:-" $(pwd)

            # Execute the command

            current_dir=$(pwd)
            current_dir_name=$(basename $current_dir)

            # provide region and account-id
            docker tag $current_dir_name:latest ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/$current_dir_name:latest
            docker push ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/$current_dir_name:latest

            # Change back to the original directory
            cd ..
        done

    EOT

    interpreter = ["bash", "-c"]
  }
  depends_on = [
    null_resource.build_image
  ]
}
