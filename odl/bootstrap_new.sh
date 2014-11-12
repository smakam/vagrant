!/usr/bin/env bash

# Install base tools
sudo apt-get update
sudo apt-get install -y maven
sudo apt-get install -y git
sudo apt-get install -y wget
sudo apt-get install -y openjdk-7-jre
sudo apt-get install -y openjdk-7-jdk

# Get ODL Hydrogen Virtualization edition
wget http://nexus.opendaylight.org/content/repositories/opendaylight.release/org/opendaylight/integration/distributions-virtualization/0.1.1/distributions-virtualization-0.1.1-osgipackage.zip
unzip distributions-virtualization-0.1.1-osgipackage.zip
# Get ODL Helium edition
wget http://nexus.opendaylight.org/content/groups/public/org/opendaylight/integration/distribution-karaf/0.2.0-Helium/distribution-karaf-0.2.0-Helium.zip
unzip distribution-karaf-0.2.0-Helium.zip
echo "export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64" >> ~/.bashrc
echo "export PATH=/usr/lib/jvm/java-1.7.0-openjdk-amd64/bin:$PATH" >> ~/.bashrc
source ~/.bashrc

# Install mininet
sudo apt-get install -y mininet/precise-backports
sudo service openvswitch-controller stop
sudo update-rc.d openvswitch-controller disable
sudo apt-get install -y linux-headers-`uname -r`
sudo dpkg-reconfigure openvswitch-datapath-dkms
sudo service openvswitch-switch restart

# Upgrade Openvswitch to 2.1.3
wget http://openvswitch.org/releases/openvswitch-2.1.3.tar.gz
gunzip openvswitch-2.1.3.tar.gz
tar -xvf openvswitch-2.1.3.tar
cd openvswitch-2.1.3
./configure --prefix=/usr --with-linux=/lib/modules/`uname -r`/build
make
sudo make install
sudo make modules_install
sudo rmmod openvswitch
sudo depmod -a
sudo /etc/init.d/openvswitch-controller stop
sudo update-rc.d openvswitch-controller disable
sudo /etc/init.d/openvswitch-switch start

# Install wireshark
sudo apt-get install -y wireshark