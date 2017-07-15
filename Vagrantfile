Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "dockerhost", autostart: true, primary: true do |dockerhost|
    dockerhost.vm.box = "ubuntu/xenial64"
    dockerhost.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
    end

    dockerhost.vm.network "forwarded_port", guest: 2375, host: 2375 # dockerd
    dockerhost.vm.network "forwarded_port", guest: 8500, host: 8500 # consul/consul-ui
    dockerhost.vm.network "forwarded_port", guest: 8200, host: 8200 # vault/vault-ui
    dockerhost.vm.network "forwarded_port", guest: 5432, host: 5432 # postgres
    dockerhost.vm.network "forwarded_port", guest: 5050, host: 5050 # pgadmin4
    dockerhost.vm.network "forwarded_port", guest: 9000, host: 9000 # portainer

    dockerhost.vm.provision "docker" do |docker|
      docker.pull_images "chef/inspec"
    end

    puts "*".times 80
    puts "*".times 80
    puts "Running validation tests for the 'dockerhost' VM..."
    puts "*".times 80
    puts "*".times 80

    dockerhost.vm.provision "shell", path: "vms/dockerhost/provision.sh"
    dockerhost.vm.provision "shell", path: "vms/dockerhost/validate.sh"
    
    dockerhost.vm.provision "shell", path: "docker/compose/vault-enterprise/provision.sh"
    dockerhost.vm.provision "shell", path: "docker/compose/vault-enterprise/validate.sh"


    # do the validation again simply to put ht evalidation output at the end of stdout/stderr
    dockerhost.vm.provision "shell", path: "vms/dockerhost/validate.sh"
    dockerhost.vm.provision "shell", path: "docker/compose/vault-enterprise/validate.sh"
  end

  config.vm.define "ad", autostart: false do |ad|
    ad.vm.box = "ubuntu/xenial64"
    ad.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
    end
  end
end
