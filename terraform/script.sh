#!/bin/bash

apt-get update -y
apt-get install -y docker.io docker-compose-v2 git

systemctl start docker
systemctl enable docker

usermod -aG docker ubuntu
