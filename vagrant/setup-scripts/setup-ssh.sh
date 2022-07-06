#!/bin/bash

ANSIBLE_CONTROLLER=$1
ANSIBLE_HOST_FILE_ENTRIES=$2

echo $ANSIBLE_HOST_FILE_ENTRIES

echo ">>>> `hostname` >>>> installing ansible"
sudo apt update && sudo apt install -y ansible
echo ">>>> `hostname` >>>> generating ssh keys"
rm -f .ssh/id_rsa* && ssh-keygen -t rsa -b 4096 -q -f .ssh/id_rsa -N '' && chown vagrant:vagrant .ssh/id_rsa*

if [[ `hostname` == $ANSIBLE_CONTROLLER ]]; then
  cp .ssh/id_rsa.pub /vagrant/.vagrant/machines/$ANSIBLE_CONTROLLER/virtualbox/
  echo ">>>> `hostname` >>>> copied $ANSIBLE_CONTROLLER ssh public key to /vagrant/.vagrant/machines/$ANSIBLE_CONTROLLER/virtualbox/"

  echo "" > /etc/ansible/hosts
  export IFS=","
  for word in $ANSIBLE_HOST_FILE_ENTRIES; do
    echo $word >> /etc/ansible/hosts
  done

else
  cat /vagrant/.vagrant/machines/$ANSIBLE_CONTROLLER/virtualbox/id_rsa.pub >> .ssh/authorized_keys
  echo ">>>> `hostname` >>>> added ansible keys"
fi
