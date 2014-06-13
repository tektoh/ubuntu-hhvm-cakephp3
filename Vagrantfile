# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu_hhvm_cakephp3"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.network :private_network, ip: "192.168.33.30"
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end
  config.vm.synced_folder ".", "/share", \
    create: true, owner: 'vagrant', group: 'vagrant', \
    mount_options: ['dmode=777,fmode=666']

  config.omnibus.chef_version = :latest
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "./cookbooks"
    chef.run_list = [
      "zip",
      "git",
      "nginx",
      "hhvm",
      "composer-hhvm",
      "mysql::server"
    ]
    chef.json = {
      "nginx" => {
        "default_site_enabled" => false
      },
      "mysql" => {
        "server_root_password" => "secret"
      }
    }
  end
  config.vm.provision :shell, path: "./vagrant/provision.sh"
end
