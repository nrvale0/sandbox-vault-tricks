Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
  end
  config.vm.box = "ubuntu/xenial64"

  config.vm.network "forwarded_port", guest: 5050, host: 5050 # pgadmin4
  config.vm.network "forwarded_port", guest: 5432, host: 5432 # postgres
  config.vm.network "forwarded_port", guest: 8200, host: 8200 # vault
  
  config.vm.provision "docker" do |docker|
    docker.pull_images "chef/inspec:latest"
  end

  config.vm.provision "shell",
                      path: "host/provision.sh",
                      env: {
                        "PROVISION_VAULT_ENTERPRISE" => ENV['PROVISION_VAULT_ENTERPRISE']
                      }
                             
  config.vm.provision "shell", path: "host/validate.sh"
end
