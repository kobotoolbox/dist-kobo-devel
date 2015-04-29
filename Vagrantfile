# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  sync_type = "rsync"
  if RUBY_PLATFORM.include? "mingw32"
    sync_type = ""
  end

  if ENV.keys.include? "VM_BOX"
    config.vm.box = ENV["VM_BOX"]
    requires_initial_installation = false
  else
    config.vm.box = "ubuntu/trusty32"
    config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-i386-vagrant-disk1.box"
    requires_initial_installation = true
  end

  # if we want to manually trigger the "00_vagrant_up" script without starting from ubuntu/trusty
  requires_initial_installation = true  if ENV.keys.include? "RUN_KOBO_INSTALL_SCRIPTS"

#  if Vagrant.has_plugin?("vagrant-cachier")
#    config.cache.scope = :box
#  end

  starting_port_number = (ENV['KOBO_PORT_NUMBER'] or "8000").to_i

  # 8000, 8001, 8005
  [0, 1, 5].each do |pn|
    hpn = starting_port_number + pn
    gpn = 8000 + pn
    config.vm.network :forwarded_port, host: hpn, guest: gpn
  end

  if ENV["DJANGO_LIVE_RELOAD"]
    config.vm.network :forwarded_port, host: 35729, guest: 35729
  end

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
  end

  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Note: Synced folders are unavailable while being synced and should be waited on.
  # config.vm.synced_folder "./logs", "/home/vagrant/logs", owner: "vagrant", group: "vagrant"
  config.vm.synced_folder "./backups", "/home/vagrant/backups", owner: "vagrant", group: "vagrant"

  config.vm.synced_folder "./scripts", "/home/vagrant/scripts", type: sync_type
  config.vm.synced_folder "./env", "/home/vagrant/env", type: sync_type


  if File.directory? "src"
    config.vm.synced_folder "./src", "/home/vagrant/src"
  end

  commands = []
  if requires_initial_installation
    commands << "sh /home/vagrant/scripts/00_vagrant_up.sh"
  else
    commands << "sh /home/vagrant/scripts/00_vagrant_reload.sh"
  end

  config.vm.provision :shell, inline: <<SCRIPT
    # Suppress subsequent stdin/tty complaints (for `root` user only).
    sed -i 's/^mesg n$/tty -s \\&\\& mesg n/g' /root/.profile

    # ensure a src directory exists and has the correct warnings
    mkdir -p /home/vagrant/src
    # make all directories in vagrant owned by vagrant
    sudo chown -R vagrant:vagrant /home/vagrant
    # continue getting permissions errors on these scripts...
    sudo chmod -R 777 /home/vagrant/scripts

    # ensure the environment variables are loaded in .profile and .bashrc
    src_file="/home/vagrant/scripts/01_environment_vars.sh"
    for f in "/home/vagrant/.profile" "/etc/bash.bashrc" "/root/.profile"; do
      if [ "$(sudo grep $src_file $f)" = "" ]; then
        echo "sourcing '$src_file' in '$f'"
        echo "[ -f $src_file ] && { . $src_file; }" | sudo tee -a $f > /dev/null
      fi
    done

    # in case of dns issue, uncomment this next line
    # echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null

    #{commands.join('; ')}
SCRIPT
end
