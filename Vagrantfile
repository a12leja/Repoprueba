Vagrant.configure("2") do |config|
 config.vm.define :clienteUbuntu do |clienteUbuntu|
 clienteUbuntu.vm.box = "bento/ubuntu-20.04"
 clienteUbuntu.vm.network :private_network, ip: "192.168.100.2"
 clienteUbuntu.vm.hostname = "clienteUbuntu"
 end
 config.vm.define :servidorUbuntu do |servidorUbuntu|
 servidorUbuntu.vm.box = "bento/ubuntu-20.04"
 servidorUbuntu.vm.network :private_network, ip: "192.168.100.3"
 servidorUbuntu.vm.hostname = "servidorUbuntu"
 end
end
