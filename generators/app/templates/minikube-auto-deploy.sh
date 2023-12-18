#!/bin/bash

# Define the functions to call

#applicationDeployment
function applicationDeployment {
    echo ""

    cd .. 
    cd kubernetes

    # replace the placeholder with minikube_ip 
    minikube_ip=$(kubectl get node -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')
    if [ `uname -s` == "Darwin" ]
        then
        sed -i "" "s/minikube_ip_placeholder/$minikube_ip/g" K8S-README.md
        sed -i "" "s/minikube_ip_placeholder/$minikube_ip/g" kubectl-apply.sh
        <%_ if (auth == "true") { _%> 
        cd keycloak-k8s
        sed -i "" "s/minikube_ip_placeholder/$minikube_ip/g" keycloak-configmap.yml
        cd ..
        <%_ } _%>  
    else
        sed -i "s/minikube_ip_placeholder/$minikube_ip/g" K8S-README.md
        sed -i "s/minikube_ip_placeholder/$minikube_ip/g" kubectl-apply.sh
        <%_ if (auth == "true") { _%>   
        cd keycloak-k8s
        sed -i "s/minikube_ip_placeholder/$minikube_ip/g" keycloak-configmap.yml
        cd ..
        <%_ } _%>  
    fi
    ./kubectl-apply.sh -f
    cd ..
    cd terraform
}

#MINIKUBE
function minikube {
    echo -e "You have opted for Minikube cluster"
    # Add code here to execute the action for minikube
    echo "Initiating the minikube action...."
    echo ""
      echo -e "Prerequisites:"
    echo " 1. Make sure that you have installed kubectl and is configured"
    echo " 2. Make sure that you have installed minikube and make sure it is up and running"
    echo ""
    echo -n "Continue with the Infrastructure deployment,(yes/no):"
    read user_continue_action
    if [ "$user_continue_action" == "yes" ]; then
    echo "Deploying the Infrastructure in our Minikube cluster....."
        # List of directories to process
        directories=(
        "./eck"
        "./istio"
        "./istio-monitoring"
        "./docker-build&publish"
        )

        # Loop through each directory and execute command
        for dir in "${directories[@]}"
        do
            if [ -d "$dir" ]; then
                echo "Processing directory: $dir"
                cd "$dir" || exit

                # Add a condition for "docker-build&publish" directory
                if [ "$dir" = "./docker-build&publish" ]; then
                    while true; do
                        echo ""
                        echo -e "Prerequisites:"
                        echo " 1. If any client application [react, angular], update the '.env.production'."
                        echo " 2. Obtain Minikube Ip address."
                        echo " 3. Replace all the occurrences of localhost with minikube ip address in the '.env.production' for clinet application."
                        echo ""
                        echo -n "Confirm if you meet all the above requirements (yes/no):"
                        read user_continue_action_for_building_image

                        if [ "$user_continue_action_for_building_image" = "yes" ]; then
                            break
                        fi
                    done
                fi

                # Execute your command here
                echo "Initiating terraform in $dir"
                terraform init
                echo "Auto applying terraform in $dir"
                terraform apply -auto-approve
                cd ..
            else
                echo "Directory $dir does not exist"
            fi
        done
      echo ""
      echo -e "Minikube Infrastructure was deployed successfully!"
      echo ""
    else 
        echo ""
        echo -e "Looks like you have already deployed the WDI, Thank you!\U0001F431"
        echo ""
    fi

    echo -n "Do you want to contiune with the application Deployment,(yes/no):"
    read  appDepolyment; 

    if [ "$appDepolyment" == "yes" ]; then
      applicationDeployment
    else 
      echo "Thank you, user!"
    fi

}

############################ SCRIPT STARTS ##########################

# Check if figlet is installed
if [ "$(uname -m)" = "x86_64" ]; then
    if ! which figlet > /dev/null; then
        # Install figlet using apt-get
        sudo apt-get -y install figlet
    fi
elif [ "$(uname -m)" = "arm64" ]; then
    if ! which figlet > /dev/null; then
        # Install figlet using Homebrew
        brew install figlet
    fi
else
    echo "Unsupported architecture: $(uname -m)"
    exit 1
fi

# Use figlet to print "AutoDeploy"
figlet -f slant "AutoDeploy"
echo ""
minikube
