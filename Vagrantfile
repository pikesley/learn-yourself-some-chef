# -*- mode: ruby -*-

Vagrant::Config.run do |config|

################################################################################

  config.vm.define :chefserver do |chefserver_config|
    chefserver_config.vm.host_name = "chefserver"
    chefserver_config.vm.box = "lucid64"
    config.vm.box_url = "http://files.vagrantup.com/lucid64.box"
    chefserver_config.vm.network :hostonly, "33.33.33.100"
    chefserver_config.vm.customize ["modifyvm", :id, "--memory", 1024]
  end

################################################################################

  config.vm.define :doctorwu do |doctorwu_config|
    doctorwu_config.vm.host_name = "doctorwu"
    doctorwu_config.vm.box = "lucid64"
    doctorwu_config.vm.network :hostonly, "33.33.33.101"

    doctorwu_config.vm.provision :chef_client do |chef|
      chef.node_name = "doctorwu"
      chef.chef_server_url = "http://33.33.33.100:4000"
      chef.provisioning_path = "/etc/chef"
      chef.validation_client_name = "chef-validator"
      chef.validation_key_path = ".chef/validation.pem"
      chef.environment = "studio"
    end
  end

################################################################################

end
