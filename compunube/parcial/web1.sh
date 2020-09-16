#!/bin/bash
echo "--------------inicio-----server1------configurado----------"
echo "sudo snap install lxd --channel=4.0/stable"
sudo snap install lxd --channel=4.0/stable
echo "newgrp lxd"
newgrp lxd
echo "lxd init --auto"
lxd init --auto
echo "lxc launch ubuntu:20.04 web"
lxc launch ubuntu:20.04 web1
echo "lxc exec web1 -- apt-get update -y"
lxc exec web1 -- apt-get update -y 
echo "lxc exec web1 -- apt-get upgrade -y"
lxc exec web1 -- apt-get upgrade -y
echo "lxc exec web1 -- apt install apache2 -y"
lxc exec web1 -- apt install apache2 -y
echo "lxc exec web1 -- systemctl enable apache2"
lxc exec web1 -- systemctl enable apache2
echo "lxc file push /vagrant/index1.html web1/var/www/html/index.html"
lxc file push /vagrant/index1.html web1/var/www/html/index.html
echo "lxc exec web1 -- systemctl restart apache2"
lxc exec web1 -- systemctl restart apache2
echo " lxc config device add web1 myport80 proxy listen=tcp:192.162.100.10:80 connect=tcp:127.0.0.1:80"
lxc config device add web1 myport80 proxy listen=tcp:192.162.100.11:80 connect=tcp:127.0.0.1:80
lxc launch ubuntu:20.04 backweb1
echo "lxc exec backweb1 -- apt-get update -y"
lxc exec backweb1 -- apt-get update -y 
echo "lxc exec backweb2 -- apt-get upgrade -y"
lxc exec backweb1 -- apt-get upgrade -y
echo "lxc exec backweb1 -- apt install apache2 -y"
lxc exec backweb1 -- apt install apache2 -y
echo "lxc exec backweb1 -- systemctl enable apache2"
lxc exec backweb1 -- systemctl enable apache2
echo "lxc file push /vagrant/indexback1.html backweb2/var/www/html/index.html"
lxc file push /vagrant/indexback1.html backweb1/var/www/html/index.html
echo "lxc exec backweb1 -- systemctl restart apache2"
lxc exec backweb1 -- systemctl restart apache2
echo " lxc config device add backweb1 myport5086 proxy listen=tcp:192.162.100.10:5086 connect=tcp:127.0.0.1:80"
lxc config device add backweb1 myport5086 proxy listen=tcp:192.162.100.11:5086 connect=tcp:127.0.0.1:80
echo "--------------fin-----backupserver1------configurado----------"