#!/bin/bash

# Install Docker Engine on the VM

# Update package list
sudo apt-get update

# Install necessary packages
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Set up the Docker stable repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Update the package list again to include Docker packages
sudo apt-get update

# Install Docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Verify Docker installation
sudo docker version

# Add current user to the Docker group
sudo usermod -a -G docker $USER

# Step 4 - Configure Docker logging

# Create Docker daemon configuration file
sudo bash -c 'cat > /etc/docker/daemon.json <<EOF
{
  "log-driver": "syslog"
}
EOF'

# Restart Docker to apply the new logging settings
sudo systemctl restart docker

# Verify the logging configuration
docker info | grep Logging

# Step 5 - Test Docker installation

# Run a test Docker container
docker run hello-world

# Run another test container and give it a name
docker run --name hi hello-world

# Search for the busybox image in Docker Hub
docker search busybox

# Pull the busybox image
docker pull busybox

# Run a busybox container and open an interactive shell
docker run --name busy -it busybox /bin/sh
exit

# List all containers, including stopped ones
docker ps -a

# Remove the hello-world container
docker rm hi

# List all Docker images
docker images

# Remove the hello-world image
docker rmi hello-world

# Step 6 - Create and manage an Apache container

# Run an Apache container and map port 8080 on your VM to port 80 in the container
docker run --name apache2 -p 8080:80 httpd:2.4

# List running containers
docker ps

# List all containers
docker ps -a

# Start the Apache container if it is stopped
docker start apache2

# Show logs of the Apache container
docker logs apache2

# Display real-time statistics of the Apache container
docker stats apache2

# Update index.html file in the Apache container
docker exec -it apache2 bash -c 'echo "apache2 container" > /usr/local/apache2/htdocs/index.html'

# Commit the changes to a new Docker image
docker commit -m 'Updated index.html' apache2

# Stop the Apache container
docker stop apache2

# Start the Apache container again
docker start apache2
