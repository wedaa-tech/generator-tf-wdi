#!/bin/bash
set -e

NONE='\033[00m'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
PURPLE='\033[01;35m'
CYAN='\033[01;36m'
WHITE='\033[01;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'

unset http_proxy
unset https_proxy

echo -e "${GREEN} Running installation... ${NONE}"

sleep 10

echo "${GREEN} Running terraform init... (ROOT) ${NONE}"

terraform init

echo "terraform apply... (ROOT)"
terraform apply -auto-approve

sleep 30

cd eks

echo "In eks folder"

echo "Running terraform init...(eks)"

terraform init

echo "terraform apply...(eks)"
terraform apply -auto-approve

sleep 30

cd ../namespace

echo "In namespaces folder"

echo "Running terraform init...(namespaces)"

terraform init

echo "terraform apply...(namespaces)"
terraform apply -auto-approve

sleep 180

cd ../helm

echo "In helm folder"

echo "Running terraform init...(helm)"

terraform init

echo "terraform apply...(helm)"
terraform apply -auto-approve


# cd ../keycloak

# echo "In keycloak folder"

# echo "Running terraform init...(keycloak)"

# terraform init

# echo "terraform apply...(keycloak)"
# terraform apply -auto-approve

# echo "Configur keycloak with its public domain Example: kc.example.com"

# sleep 180

# cd ../keycloak-config

# echo "In keycloak-config folder"

# echo "Running terraform init...(keycloak-config)"

# terraform init

# echo "terraform apply...(keycloak-config)"

# terraform apply -auto-approve

# sleep 30

# cd ../postgres

# echo "In postgres folder"

# echo "Running terraform init...(postgres)"

# terraform init

# echo "terraform apply...(postgres)"

# terraform apply -auto-approve

# sleep 30

# cd ../react

# echo "In react folder"

# echo "Running terraform init...(react)"

# terraform init

# echo "terraform apply...(react)"

# terraform apply -auto-approve

# sleep 30

# cd ../spring

# echo "In spring folder"

# echo "Running terraform init...(spring)"

# terraform init

# echo "terraform apply...(spring)"

# terraform apply -auto-approve