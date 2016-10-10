#!/bin/bash

# cd ansible && ansible-playbook -i production provision.yml
cd ansible && \
  ansible-playbook user.yml -i inventories/webservers -vvvvv && \
  ansible-playbook webserver.yml -i inventories/webservers -vvvvv && \
  ansible-playbook dbserver.yml -i inventories/webservers -vvvvv && \
  ansible-playbook app.yml -i inventories/webservers -vvvvv