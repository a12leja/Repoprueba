#!/bin/bash
echo "--------------inicio-----haproxy------configurado----------"
echo "sudo snap install lxd --channel=4.0/stable"
sudo snap install lxd --channel=4.0/stable
echo "newgrp lxd"
newgrp lxd
echo "lxd init --auto"
lxd init --auto
echo "lxc launch ubuntu:20.04 web"
lxc launch ubuntu:20.04 balancerhaproxyy
echo "lxc exec balancerhaproxyy -- apt-get update -y"
lxc exec balancerhaproxyy -- apt-get update -y 
echo "lxc exec balancerhaproxyy -- apt-get upgrade -y"
lxc exec balancerhaproxyy -- apt-get upgrade -y
echo "lxc exec balancerhaproxyy -- apt install haproxy -y"
lxc exec balancerhaproxyy -- apt install haproxy -y
echo "lxc exec balancerhaproxyy -- systemctl enable haproxy"
lxc exec balancerhaproxyy -- systemctl enable haproxy
echo "lxc file push /vagrant/haproxy.cfg balancerhaproxyy/etc/haproxy/haproxy.cfg"
lxc file push /vagrant/haproxy.cfg balancerhaproxyy/etc/haproxy/haproxy.cfg
echo "lxc file push /vagrant/index1.html balancerhaproxyy/etc/haproxy/errors/503.http"
lxc file push /vagrant/indexh.http balancerhaproxyy/etc/haproxy/errors/503.http
echo "lxc exec balancerhaproxyy -- systemctl restart haproxy"
lxc exec balancerhaproxyy -- systemctl restart haproxy
echo " lxc config device add balancerhaproxyy http proxy listen=tcp:0.0.0.0:80 connect=tcp:127.0.0.1:80"
lxc config device add balancerhaproxyy http proxy listen=tcp:192.162.100.12:80 connect=tcp:127.0.0.1:80
echo "--------------fin-----haproxy------configurado----------"