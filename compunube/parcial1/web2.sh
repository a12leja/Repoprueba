#!/bin/bash
echo "--------------inicio-----server1------configurado----------"
sudo snap install lxd --channel=4.0/stable
echo "Ingresa al grupo"
newgrp lxd
echo "Inicializa"
lxd init --auto
echo "Carga ubuntu"
lxc init ubuntu:20.04 web2 --target server2
sleep 5
echo "lxc start web2"
lxc start web2
sleep 40
echo "lxc exec web2 -- apt-get update -y"
lxc exec web2 -- apt-get update -y 
sleep 5
echo "lxc exec web2 -- apt-get upgrade -y"
lxc exec web2 -- apt-get upgrade -y
sleep 5
echo "lxc exec web2 -- apt install apache2 -y"
lxc exec web2 -- apt-get install apache2 -y
sleep 5
echo "lxc exec web2 -- systemctl enable apache2"
lxc exec web2 -- systemctl enable apache2
sleep 5
echo "lxc file push /vagrant/index2.html web2/var/www/html/index.html"
lxc file push /vagrant/index2.html web2/var/www/html/index.html
sleep 5
echo "lxc exec web2 -- systemctl restart apache2"
lxc exec web2 -- systemctl restart apache2
sleep 5
echo " lxc config device add web2 myport80 proxy listen=tcp:192.162.100.10:80 connect=tcp:127.0.0.1:80"
lxc config device add web2 myport80 proxy listen=tcp:192.162.100.11:80 connect=tcp:127.0.0.1:80
echo "--------------fin-----server1------configurado----------"

echo "--------------inicio-----backupserver1------configurado----------"
echo "lxc init ubuntu:20.04 backweb2 --target server1"
lxc init ubuntu:20.04 backweb2 --target server2
sleep 5
echo "lxc start backweb2"
lxc start backweb2
sleep 30
echo "lxc exec backweb2 -- apt-get update -y"
lxc exec backweb2 -- apt-get update -y 
sleep 5
echo "lxc exec backweb2 -- apt-get upgrade -y"
lxc exec backweb2 -- apt-get upgrade -y
sleep 5
echo "lxc exec backweb2 -- apt install apache2 -y"
lxc exec backweb2 -- apt-get install apache2 -y
sleep 5
echo "lxc exec backweb2 -- systemctl enable apache2"
lxc exec backweb2 -- systemctl enable apache2
sleep 5
echo "lxc file push /vagrant/indexback1.html backweb2/var/www/html/index.html"
lxc file push /vagrant/indexback2.html backweb2/var/www/html/index.html
sleep 5
echo "lxc exec backweb2 -- systemctl restart apache2"
lxc exec backweb2 -- systemctl restart apache2
sleep 5
echo " lxc config device add backweb2 myport5086 proxy listen=tcp:192.162.100.10:5086 connect=tcp:127.0.0.1:80"
lxc config device add backweb2 myport5086 proxy listen=tcp:192.162.100.11:5086 connect=tcp:127.0.0.1:80
echo "--------------fin-----backupserver1------configurado----------"