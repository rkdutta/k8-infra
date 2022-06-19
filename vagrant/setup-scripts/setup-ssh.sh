#!/bin/bash

ANSIBLE_CONTROLLER=$1

echo ">>>> `hostname` >>>> installing ansible"
sudo apt update && sudo apt install -y ansible
echo ">>>> `hostname` >>>> generating ssh keys"
rm -f .ssh/id_rsa* && ssh-keygen -t rsa -b 4096 -q -f .ssh/id_rsa -N ''

if [[ `hostname` == $ANSIBLE_CONTROLLER ]]; then
  cp .ssh/id_rsa.pub /vagrant/.vagrant/machines/$ANSIBLE_CONTROLLER/virtualbox/
  echo ">>>> `hostname` >>>> copied $ANSIBLE_CONTROLLER ssh public key to /vagrant/.vagrant/machines/$ANSIBLE_CONTROLLER/virtualbox/"
else
  cat /vagrant/.vagrant/machines/$ANSIBLE_CONTROLLER/virtualbox/id_rsa.pub >> .ssh/authorized_keys
  echo ">>>> `hostname` >>>> added ansible keys"
fi
