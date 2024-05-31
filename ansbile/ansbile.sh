#!/bin/bash

echo Installing Jenkins 
ansible-playbook install_jenkins.yaml 
echo Installing Nexus
ansible-playbook install_nexus.yaml
echo Installing SonarQube
ansible-playbook install_sonarqube.yaml
