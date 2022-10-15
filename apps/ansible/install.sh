#!/bin/bash
brew install ansible
sudo ln -sf /usr/local/etc/ansible /etc/ansible
sudo cp -a ~/opensignal/opensignal-ansible/ansible /usr/local/etc  # from opensignal-ansible repo
