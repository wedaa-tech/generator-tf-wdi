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

            # Execute the command, based on machine type
            MACHINE_TYPE=`uname -m`

            # Execute the command
            if [ $MACHINE_TYPE == 'x86_64' ]; then
                npm run java:docker
            elif [ $MACHINE_TYPE == 'arm64' ]; then
                npm run java:docker:arm64
            else
                echo "Unsupported machine architecture: $MACHINE_TYPE"
            fi

            # Change back to the original directory
            cd ..
        done

    EOT

    interpreter = ["bash", "-c"]
  }
}
