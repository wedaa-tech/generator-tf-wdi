#!/bin/bash
set -e
# Get the IP addresses of the instances
instances=("13.232.219.16" "13.127.181.98" "13.126.82.175")
private_instances=("172.31.26.16" "172.31.27.100" "172.31.20.27")

# update the apt package index and install Docker packages on all instances
for instance in "${private_instances[@]}"; do
  ssh -i file ubuntu@$instance -yes "
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt install docker.io -y "
done

# Initialising Swarm on the first instance
ssh -i file ubuntu@${private_instances[0]} "
sudo docker swarm init --advertise-addr ${instances[0]} "

worker_token=$(ssh -i file ubuntu@${private_instances[0]} "sudo docker swarm join-token worker -q")

# Joining the rest of the instances as worker nodes
for i in $(seq 1 $(( ${#private_instances[@]} - 1 )) ); do
  ssh -i file ubuntu@${private_instances[i]} "
  sudo docker swarm join --token $worker_token ${instances[0]}:2377 "
done

# Listing the nodes in cluster
ssh -i file ubuntu@${private_instances[0]} "
sudo docker node ls "

# Create a stack file
echo "
version: '3.0'
services:
  consul:
    image: consul:latest
    ports:
      - "8500:8500"
    networks:
      - network2
  domainservice:
    image: varun2223/micro_domainservice
    ports:
      - "9090:9090"
    depends_on:
      - consul
    networks:
      - network2
  checkremainder:
    image: varun2223/micro_checkremainder
    ports:
      - "8082:8082"
    depends_on:
      - domainservice
      - consul
    networks:
      - network2
networks:
  network2:
    driver: overlay" > stack.yml

# Deploy the stack on the swarm
ssh -i file ubuntu@${private_instances[0]} "
sudo docker stack deploy --compose-file stack.yml mystack

sleep 15

# List the services running on the cluster
sudo docker service ls "