
#!/bin/bash

echo -ne '#                                                         (0%)\r'
echo -ne '#####                                                     (5%)\r'
# Install Pre-requisites ##
apt update
apt install apt-transport-https ca-certificates curl software-properties-common -y

## Docker Installation ##

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

curl -fsSL https://test.docker.com -o test-docker.sh
sh test-docker.sh

# Install Docker Compose ##
sudo curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo -ne '##########                                              (15%)\r'

# Install Commands ##

echo "The current working directory: $PWD"
echo "The previous current working directory: $OPLDPWD"
_cwd="$PWD"

## use pwd command ##
_mydir="$(pwd)"

## or ##
_mydir="`pwd`"

echo "My working dir: $_mydir"

echo "Installing Tetrawing version 1.0..."
echo "Please Wait..."
sleep 3
# https://docs.docker.com/compose/extends/
# Share Compose configurations between files and projects
# docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

# Postgres, Kong, Konga.
#scale kong with 10 replicas 
docker-compose -f $_mydir/docker-compose.yml up -d

echo -ne '################                                        (30%)\r'
#prometheus, nodeexporter, Grafana.
docker-compose -f $_mydir/docker-compose-prom.yml up -d

echo -ne '###################################                     (60%)\r'
#You need to increase max_map_count on your Docker host: config for elastic search
sudo sysctl -w vm.max_map_count=262144

#Wazuh ELK Stack
docker-compose -f $_mydir/docker-compose-wazuh.yml up -d

echo -ne '###############################################         (85 %)\r'
# #portainer
docker-compose -f $_mydir/docker-compose-portainer.yml up -d

echo -ne '####################################################### (95%)\r'
# #operational Dashboard.
docker-compose -f $_mydir/docker-compose-operation.yml up -d

echo -ne '########################################################(100%)\r'

echo -ne '\n'
echo "Configuring and Initializing Tetrawing version 1.0..."
echo "Please Wait...!"
sleep 10
echo "Tetrawing version 1.0 installed successfully"
echo "Tetrawing operational is up and running on 0.0.0.0:4000"


