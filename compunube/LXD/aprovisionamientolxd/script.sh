#!/bin/bash
echo "sudo snap install lxd --channel=4.0/stable"
sudo snap install lxd --channel=4.0/stable
echo "newgrp lxd"
newgrp lxd
echo "lxd init --auto"
lxd init --auto
echo "lxc launch ubuntu:20.04 web"
lxc launch ubuntu:20.04 web
echo "lxc exec web -- apt-get install apache2"
lxc exec web -- apt-get install apache2 -y
echo "lxc file push /vagrant/index.html web/var/www/html/index.html"
lxc file push /vagrant/index.html web/var/www/html/index.html
echo "lxc exec web -- systemctl restart apache2"
lxc exec web -- systemctl restart apache2
echo "lxc config device add web myport80 proxy listen=tcp:192.168.100.6:5086 connect=tcp:127.0.0.1:80"
lxc config device add web myport80 proxy listen=tcp:192.168.100.6:5080 connect=tcp:127.0.0.1:80
