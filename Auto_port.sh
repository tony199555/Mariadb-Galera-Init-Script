#!/bin/bash

#Auto open ports on ubuntu 16.04 With UFW

sudo ufw allow ssh

sudo ufw allow 4444

sudo ufw allow 4567

sudo ufw allow 4568

sudo ufw allow mysql

sudo ufw enable

sudo apt-get install -y iptables-persistent
