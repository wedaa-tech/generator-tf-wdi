resource "null_resource" "build_image" {

 provisioner "local-exec" {
    
    command = <<-EOT
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
            npm run java:docker
            
            # Change back to the original directory
            cd ..
        done

    EOT

    interpreter = ["bash", "-c"]
  }
}
