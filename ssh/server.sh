#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" | sudo  tee /var/log/config.log
   exit 1
fi

# create user
useradd tipsforitpros

# add permissions to run commands without password
adduser tipsforitpros sudo
echo "tipsforitpros  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/tipsforitpros

# set users shell to bash
usermod --shell /bin/bash tipsforitpros

# configure openssh server
sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# get ssh authorized_keys
mkdir /home/tipsforitpros
mkdir /home/tipsforitpros/.ssh
wget -O - https://raw.githubusercontent.com/HealisticEngineer/Ubuntu/master/ssh/authorized_keys.key | tee -a /home/tipsforitpros/.ssh/authorized_keys

# set owner permissions to files
chown tipsforitpros:tipsforitpros /home/tipsforitpros/.ssh
chown tipsforitpros  /home/tipsforitpros/.ssh/authorized_keys

# restart ssh server
systemctl restart sshd
