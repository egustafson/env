#!/bin/sh

sudo apt-get update
sudo apt-get dist-upgrade -y
sudo apt-get install -y git tcsh emacs24-nox emacs-goodies-el xterm

sudo adduser gustafer
sudo adduser gustafer admin
sudo mkdir ~gustafer/.ssh
sudo cp ~/.ssh/authorized_keys ~gustafer/.ssh/
sudo chown -R gustafer ~gustafer/.ssh

echo "done"
