#!/bin/sh

sudo apt update
sudo apt install --yes software-properties-common python-setuptools
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt update
sudo apt install --yes ansible sshpass
