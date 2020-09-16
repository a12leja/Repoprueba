#!/bin/bash
echo "--------------inicio-----haproxy------configurado----------"
sudo snap install lxd --channel=4.0/stable
echo "Ingresa al grupo"
newgrp lxd
echo "Inicializa"
lxd init --auto
echo "Carga ubuntu"
lxc init ubuntu:20.04 balancerhaproxyy --target haproxy
sleep 5
echo "lxc start web1"
lxc start balancerhaproxyy
sleep 40
#echo "limitar memoria contenedor balancerhaproxyy"
#lxc config set balancerhaproxyy limits.memory 64MB
sleep 5
echo "lxc exec balancerhaproxyy -- apt-get update -y"
lxc exec balancerhaproxyy -- apt-get update -y 
sleep 5
echo "lxc exec balancerhaproxyy -- apt-get upgrade -y"
lxc exec balancerhaproxyy -- apt-get upgrade -y
sleep 5
echo "lxc exec balancerhaproxyy -- apt install haproxy -y"
lxc exec balancerhaproxyy -- apt-get install haproxy -y
sleep 5
echo "lxc exec balancerhaproxyy -- systemctl enable haproxy"
lxc exec balancerhaproxyy -- systemctl enable haproxy
sleep 5
echo "lxc file push /vagrant/haproxy.cfg balancerhaproxyy/etc/haproxy/haproxy.cfg"
lxc file push /vagrant/haproxy.cfg balancerhaproxyy/etc/haproxy/haproxy.cfg
sleep 5
echo "lxc file push /vagrant/index1.html balancerhaproxyy/etc/haproxy/errors/503.http"
lxc file push /vagrant/indexh.http balancerhaproxyy/etc/haproxy/errors/503.http
sleep 5
echo "lxc exec balancerhaproxyy -- systemctl restart haproxy"
lxc exec balancerhaproxyy -- systemctl restart haproxy
sleep 5
echo " lxc config device add balancerhaproxyy http proxy listen=tcp:0.0.0.0:80 connect=tcp:127.0.0.1:80"
lxc config device add balancerhaproxyy http proxy listen=tcp:192.162.100.12:80 connect=tcp:127.0.0.1:80
echo "--------------fin-----haproxy------configurado----------"