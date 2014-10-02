# -*- mode: ruby -*-
# vi: set ft=ruby :

inline_script = <<SCRIPT
sed -i 's/^mesg n$/tty -s \\&\\& mesg n/g' /root/.profile
mkdir -p /home/vagrant/src
chown vagrant:vagrant /home/vagrant/src

PROFILE_FILE="/home/vagrant/.profile"
ENVS_FILE="/home/vagrant/scripts/01_environment_vars.sh"
if [ $(cat $PROFILE_FILE | grep $ENVS_FILE | wc -l) = "0" ]; then
  echo ". $ENVS_FILE" >> $PROFILE_FILE
fi

sh /home/vagrant/scripts/00_vagrant_up.sh
SCRIPT

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  if ENV.keys.include? "VM_BOX"
    config.vm.box = ENV["VM_BOX"]
  else
    config.vm.box = "ubuntu/trusty32"
    config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-i386-vagrant-disk1.box"
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
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

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
  end

  # Suppress subsequent stdin/tty complaints (for `root` user only).
  config.vm.provision :shell, inline: inline_script

  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.synced_folder "./scripts", "/home/vagrant/scripts", type: "rsync"
  config.vm.synced_folder "./env", "/home/vagrant/env", type: "rsync"

  config.vm.synced_folder "./logs", "/home/vagrant/logs"
  config.vm.synced_folder "./backups", "/home/vagrant/backups"

  if File.directory? "src"
    config.vm.synced_folder "./src", "/home/vagrant/src", type: "rsync"
  end

  config.vm.provision :shell, inline: inline_script

end
