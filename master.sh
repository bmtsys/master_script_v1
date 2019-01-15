
#!/bin/bash


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

# Install Commands ##

echo "The current working directory: $PWD"
echo "The previous current working directory: $OPLDPWD"
_cwd="$PWD"

## use pwd command ##
_mydir="$(pwd)"

## or ##
_mydir="`pwd`"

echo "My working dir: $_mydir"

# https://docs.docker.com/compose/extends/
# Share Compose configurations between files and projects
# docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

# Postgres, Kong, Konga.
docker-compose -f $_mydir/docker-compose.yml up -d

#prometheus, nodeexporter, Grafana.
docker-compose -f $_mydir/docker-compose-prom.yml up -d

#You need to increase max_map_count on your Docker host: config for elastic search
sudo sysctl -w vm.max_map_count=262144

#Wazuh ELK Stack
docker-compose -f $_mydir/docker-compose-wazuh.yml up -d

#portainer
docker-compose -f $_mydir/docker-compose-portainer.yml up -d

#operational Dashboard.
docker-compose -f $_mydir/docker-compose-operation.yml up -d



# Once the installations are completed, Start the automation script here.
