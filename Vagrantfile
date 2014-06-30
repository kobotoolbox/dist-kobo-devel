# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "trusty"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-i386-vagrant-disk1.box"
  config.vm.network :forwarded_port, host: 8000, guest: 8000
  config.vm.network :forwarded_port, host: 8001, guest: 8001

  config.vm.provision :shell, :path => "scripts/00_vagrant_up.sh"
  config.vm.post_up_message = "KoBoToolbox VM has been launched on port 8000 and 8001"

end
