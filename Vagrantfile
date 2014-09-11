# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = ENV.keys.include?("VM_BOX") ? ENV["VM_BOX"] : "ubuntu/trusty32"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-i386-vagrant-disk1.box"

  port_number = ENV.keys.include?("KOBO_PORT_NUMBER") ? ENV["KOBO_PORT_NUMBER"] : 8000

  # iterate through 8000, 8001, 8005, and 35729
  [port_number, port_number+1, port_number+5, port_number+27729].each do |pn|
    config.vm.network :forwarded_port, host: pn, guest: pn
  end

  # Suppress subsequent stdin/tty complaints (for `root` user only).
  config.vm.provision :shell, inline: "sed -i 's/^mesg n$/tty -s \\&\\& mesg n/g' /root/.profile"
  
  config.vm.provision :shell, path: 'scripts/00_vagrant_up.sh'

end
