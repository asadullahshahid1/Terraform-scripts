#!/bin/bash

# Update the package list
sudo apt-get update

# Install the software properties common package
sudo apt-get install -y software-properties-common

# Add the Ansible PPA
sudo add-apt-repository --yes --update ppa:ansible/ansible

# Install Ansible
sudo apt-get install -y ansible

# Verify the installation
ansible --version
