class baseconfig {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update';
  }

  package { ['apache2', 'tree', 'vsftpd']:
    ensure => present;
  }

  file { '/var/www/html/index.html':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source => 'puppet:///modules/baseconfig/index.html',
    path    => '/var/www/html/index.html';
  }
  service { "apache2":
    ensure => running,
    enable => true,
    require => Package['apache2'];
  }
  service {"vsftpd":
  ensure => running,
  enable => true,
  require => Package['vsftpd'];
  }
 file { '/etc/vsftpd.conf':
    ensure  => file,
    require => Package['vsftpd'],
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source => 'puppet:///modules/baseconfig/vsftpd.conf',
    path    => '/etc/vsftpd.conf';
  }
  
  user { 'yo':
  ensure => "present",
  shell => "/bin/bash",
  #password => pw_hash('yo', 'SHA-512', 'mysalt'),
  home => "/home/yo",
  managehome =>true,
   } 
}
