#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# add permissions to run commands without password
adduser tipsforitpros sudo
echo "tipsforitpros  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/tipsforitpros

# Install ssh server
apt-get install openssh-server -y

# configure openssh server
sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# configure services
systemctl enable ssh
systemctl restart sshd

# get ssh authorized_keys
mkdir /home/tipsforitpros/.ssh
wget -O - https://raw.githubusercontent.com/HealisticEngineer/Ubuntu/master/ssh/authorized_keys.key | tee -a /home/tipsforitpros/.ssh/authorized_keys

# set owner permissions to files
chown tipsforitpros:tipsforitpros /home/tipsforitpros/.ssh
chown tipsforitpros  /home/tipsforitpros/.ssh/authorized_keys
