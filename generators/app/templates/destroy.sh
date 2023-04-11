#!/bin/bash
set -e
echo "Running destroy..."

cd helm

echo "In helm folder"

echo "terraform destroy...(helm)"
terraform destroy -auto-approve

# sleep 60

# echo "terraform destroy... (ROOT)"
# terraform destroy -auto-approve

# cd ../keycloak-config

# echo "In keycloak-config folder"

# echo "terraform destroy...(keycloak-config)"

# terraform destroy -auto-approve

# cd ../keycloak

# echo "In keycloak folder"

# echo "terraform destroy...(keycloak)"

# terraform destroy -auto-approve

# sleep 60

# cd ../postgres

# echo "In postgres folder"

# echo "terraform destroy...(postgres)"

# terraform destroy -auto-approve

# sleep 60

# cd ../react

# echo "In react folder"

# echo "terraform destroy...(react)"

# terraform destroy -auto-approve

# sleep 60

# cd ../spring

# echo "In spring folder"

# echo "terraform destroy...(spring)"

# terraform destroy -auto-approve

sleep 60

cd ../namespace

echo "In namespaces folder"

echo "terraform destroy...(namespaces)"
terraform destroy -auto-approve

sleep 60

cd ../eks

echo "In eks folder"

echo "terraform destroy...(eks)"
terraform destroy -auto-approve

# echo "terraform destroy... (ROOT)"

# cd ../
# terraform destroy -auto-approve
