# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
    config.cache.synced_folder_opts = {
      type: :rsync
    }
  end

  config.vm.provider "virtualbox" do |v|
    v.linked_clone = true
  end

  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.network "private_network",
    type: "dhcp",
    nic_type: "virtio"

  config.vm.network "public_network", 
    use_dhcp_assigned_default_route: true,
    type: "dhcp",
    nic_type: "virtio",
    bridge: "wlan0"

  n_managers = 3
  n_workers = 3

  for i in 1..n_managers
    config.vm.define "manager#{i}" do |manager|
      manager.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = "2"
      end
    end
  end

  (1..n_workers).each do |i|
    config.vm.define "worker#{i}" do |worker|
      worker.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        vb.cpus = 1
      end


      if i == 3
        worker.vm.provision :ansible do |ansible|
          ansible.become = true
	      ansible.groups = {
	        "managers" => ["manager[1:#{n_managers}]"],
	        "workers" => ["worker[1:#{n_workers}]"]
	      }
          ansible.limit = "all"
	      ansible.galaxy_role_file = "ansible-roles.yml"
	      ansible.playbook = "playbook.yml"
        end
      end
    end
  end

  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

end
