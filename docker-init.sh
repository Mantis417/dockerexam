#!/bin/bash

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
 sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update


# Installing Docker:
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Create directory for compose.yml
sudo mkdir -p myapp
cd /myapp

# Create docker-compose.yml dynamically
sudo tee /myapp/docker-compose.yml > /dev/null <<EOL
version: '3'
services:
  # TodoApp service
  todoapp:
    image: mantis417/dockerexamapp
    restart: always
    ports:
      - "8080:8080"
    environment:
      - MongoDbSettings__ConnectionString=mongodb://db:27017
      - TODO_SERVICE_IMPLEMENTATION=MongoDb
      - ASPNETCORE_ENVIRONMENT=Development

  # MongoDB service
  db:
    image: mongo
    restart: always
    volumes:
      - mongodb-data:/data/db

  # Mongo Express service
  mongo-express:
    image: mongo-express
    restart: always
    ports:
      - "8081:8081"
    environment:
      - ME_CONFIG_MONGODB_SERVER=db

volumes:
  mongodb-data:
EOL

cd /myapp
sudo docker compose up -d