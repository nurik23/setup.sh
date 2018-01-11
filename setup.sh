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
   echo -n "Enter Yes if you wont to install vagrant :  "
   read x
   if [ $x == "Yes" ];then
   sudo apt install vagrant -y
   fi 
else [ "$?" == "0" ]            
   echo "$var"| tail -n1
fi

}

Libvirt(){
lib=`virsh --version`
if [ "$?" != "0" ]; then
   echo " 'virsh' is currently not installed "
   echo -n "Enter Yes if you wont to install libvert-bin : "
   read x
   if [ $x == "Yes" ];then
   sudo apt install -y libvirt-bin
   fi 
else [ "$?" == "0" ]            
   echo "virsh version: $lib"| tail -n1
fi
}

VagrantLibvirt(){
VL=`vagrant-libvirt`
if [ "$?" != "0" ]; then
   echo " 'vagrant-libvirt' is currently not installed "
   echo -n "Enter Yes if you wont to install vagrant-libvirt : "
   read x
   if [ $x == "Yes" ];then
   sudo apt-get build-dep vagrant ruby-libvirt
   sudo apt-get install -y qemu libvirt-bin ebtables dnsmasq
   sudo apt-get install -y libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev
   sudo vagrant plugin install vagrant-libvirt 
   fi 
else [ "$?" == "0" ]            
   echo "$VL"| tail -n1
fi
}


Bridge(){
echo "bridge device on local machine : "
brctl show | awk 'FNR == 2 {print $1}'

echo "a bridge is :"
ifconfig | awk 'FNR == 2 {print $1}' 
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




