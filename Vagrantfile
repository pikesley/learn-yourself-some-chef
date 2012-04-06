# -*- mode: ruby -*-

Vagrant::Config.run do |config|

################################################################################

  config.vm.define :chefserver do |chefserver_config|
    chefserver_config.vm.host_name = "chefserver"
    chefserver_config.vm.box = "lucid64"
    config.vm.box_url = "http://files.vagrantup.com/lucid64.box"
    chefserver_config.vm.network :hostonly, "33.33.33.100"
  end

################################################################################

###   config.vm.define :protoscore do |protoscore_config|
###     protoscore_config.vm.host_name = "protoscore"
###     protoscore_config.vm.box = "lucid64"
###     protoscore_config.vm.network :hostonly, "33.33.33.50"
### 
###     protoscore_config.vm.provision :chef_client do |chef|
###       chef.node_name = "protoscore-vagrant"
###       chef.chef_server_url = "http://chef.amee.com:4000"
###       chef.provisioning_path = "/etc/chef"
###       chef.validation_client_name = "chef-validator"
###       chef.validation_key_path = ".chef/validation.pem"
### #      chef.run_list = chef.run_list = [
### #                                        "role[amee-protoscore]"
### #                                      ]
### # can put a role here, too
###       chef.environment = "vagrant-dev"
###     end
###   end
end
