# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty32"
  config.vm.network :forwarded_port, host: 8000, guest: 8000
  config.vm.network :forwarded_port, host: 8001, guest: 8001
  
  # Copied from Enketo's `Vagrantfile`
  config.vm.network :forwarded_port, host: 8006, guest: 8005
  config.vm.network :forwarded_port, host: 35729, guest: 35729

  # Suppress subsequent stdin/tty complaints (for `root` user only).
  config.vm.provision :shell, inline: "sed -i 's/^mesg n$/tty -s \\&\\& mesg n/g' /root/.profile"
  
  config.vm.provision :shell, path: 'scripts/00_vagrant_up.sh'

end
