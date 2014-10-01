# -*- mode: ruby -*-
# vi: set ft=ruby :

inline_script = <<SCRIPT
sed -i 's/^mesg n$/tty -s \\&\\& mesg n/g' /root/.profile
cp -Rf /vagrant /home/vagrant/dist-kobo-devel
sh /home/vagrant/dist-kobo-devel/scripts/00_vagrant_up.sh
SCRIPT

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  if ENV.keys.include? "VM_BOX"
    config.vm.box = ENV["VM_BOX"]
  else
    config.vm.box = "ubuntu/trusty32"
    config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-i386-vagrant-disk1.box"
  end

  starting_port_number = (ENV['KOBO_PORT_NUMBER'] or "8000").to_i

  # 8000, 8001, 8005
  [0, 1, 5].each do |pn|
    hpn = starting_port_number + pn
    gpn = 8000 + pn
    config.vm.network :forwarded_port, host: hpn, guest: gpn
  end

  if ENV["LIVE_RELOAD"]
    config.vm.network :forwarded_port, host: 35729, guest: 35729
  end

  # Suppress subsequent stdin/tty complaints (for `root` user only).
  config.vm.provision :shell, inline: inline_script
end
