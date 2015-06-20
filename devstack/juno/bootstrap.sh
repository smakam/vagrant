!/usr/bin/env bash

# Install base tools
sudo apt-get update
sudo apt-get install -y git
sudo apt-get install -y wget
sudo apt-get install -y python-pip
sudo apt-get install -y python-dev

# Download juno stable devstack
git clone -b stable/juno https://github.com/openstack-dev/devstack.git
cd devstack
wget https://github.com/smakam/openstack/raw/master/juno/local.conf.control
mv local.conf.control local.conf
# Replace Host IP
sed -i '/HOST_IP/ c HOST_IP=192.168.59.105' local.conf

# Do the stacking
./stack.sh
