# -*- mode: ruby -*-
# vi: set ft=ruby :

script_path = File.expand_path(File.dirname(__FILE__))
lib_path = script_path + '/lib'
conf_path = script_path + '/config.yml'
sample_path = script_path + '/config.yml.sample'

$LOAD_PATH.unshift(lib_path)
require "config_loader"

Vagrant.configure(2) do |config|
  cfn = Config.load(conf_path, sample_path)

  config.vm.box = cfn['box']

  if Vagrant.has_plugin?("vagrant-cachier") and cfn['cache-packages'] = 'y'
    config.cache.scope = :box
    config.cache.synced_folder_opts = {
      type: :rsync
    }
  end

  config.vm.provider "virtualbox" do |v|
    v.linked_clone = true
  end

  config.vm.synced_folder ".", "/vagrant", disabled: true

  pub_net = cfn['networking']['public']
  prv_net = cfn['networking']['private']

  config.vm.network 'private_network',
    type: 'dhcp',
    nic_type: prv_net['nic_type']

  config.vm.network "public_network", 
    use_dhcp_assigned_default_route: true,
    nic_type: pub_net['nic_type'],
    bridge: pub_net['bridge']

  n_managers = cfn['swarm']['managers']['count']
  n_workers = cfn['swarm']['workers']['count']

  (1..n_managers).each do |i|
    config.vm.define "manager#{i}" do |manager|
      manager.vm.hostname = "%s#{i}" % cfn['swarm']['managers']['host_prefix']
      manager.vm.provider "virtualbox" do |vb|
        vb.memory = cfn['swarm']['managers']['memory'] 
        vb.cpus = cfn['swarm']['managers']['cpus']
      end
    end
  end

  (1..n_workers).each do |i|
    config.vm.define "worker#{i}" do |worker|
      worker.vm.hostname = "%s#{i}" % cfn['swarm']['workers']['host_prefix']
      worker.vm.provider "virtualbox" do |vb|
        vb.memory = cfn['swarm']['workers']['memory']
        vb.cpus = cfn['swarm']['workers']['cpus']
      end


      if i == n_workers
        worker.vm.provision :ansible do |ansible|
          ansible.become = true
	      ansible.groups = {
	        "managers" => ["%s[1:#{n_managers}]" % cfn['swarm']['managers']['host_prefix']],
	        "workers" => ["%s[1:#{n_workers}]" % cfn['swarm']['workers']['host_prefix']]
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
