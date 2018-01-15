#!/bin/bash

Ping(){
ping -c1 -w7 8.8.8.8 &>/dev/null
if [ "$?" != "0" ]; then
   echo "Ping failed"
else [ "$?" == "0" ]            
   echo "Ping successful"
fi
}

Vagrant(){
var=`vagrant --version`
if [ "$?" != "0" ]; then
   echo " 'vagrant' is currently not installed "
   echo -n "Enter 'Yes' if you wont to install vagrant :  "
   read x
   if [ $x == "Yes" ];then
   wget https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_x86_64.deb	
   sudo dpkg -i vagrant_2.0.1_x86_64.deb
   fi 
else [ "$?" == "0" ]            
   echo "$var"| tail -n1
fi
}

Libvirt(){
lib=`virsh --version`
if [ "$?" != "0" ]; then
   echo " 'virsh' is currently not installed "
   echo -n "Enter 'Yes' if you wont to install libvert-bin : "
   read x
   if [ $x == "Yes" ];then
   sudo apt install qemu-kvm libvirt-bin
   sudo apt-get -f install
   sudo adduser $USER libvirtd
   fi 
else [ "$?" == "0" ]            
   echo "Libvirt version: $lib"| tail -n1
fi
}

VagrantLibvirt(){
VL=`sudo vagrant plugin list`
echo "If you want to install vagrant-libvirt plagin enter 'Yes' "
if [ "$?" != "0" ]; then
   echo " 'vagrant-libvirt' is currently not installed "
   echo -n "Enter Yes if you wont to install vagrant-libvirt : "
   read x
   if [ $x == "Yes" ];then
   wget http://production.cf.rubygems.org/rubygems/rubygems-update-2.0.3.gem
   gem install rubygems-update-2.0.3.gem
   sudo update_rubygems
   sudo apt-get build-dep vagrant ruby-libvirt
   sudo apt-get install -y qemu libvirt-bin ebtables dnsmasq
   sudo apt-get install -y libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev
   sudo vagrant plugin install vagrant-libvirt 
   fi 
else [ "$?" == "0" ]
   echo "vagrant plugin list :"            
   echo "$VL"
fi
}


Bridge(){
echo "bridge device on local machine : "
brctl show ##| awk 'FNR == 2 {print $1}'
}


Ping
echo " "
Vagrant
echo " "
Libvirt
echo " "
VagrantLibvirt
echo " "
Bridge




