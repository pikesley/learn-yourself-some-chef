current_dir = File.dirname(__FILE__)

log_level                :info
log_location             STDOUT

node_name                'vagrant'
client_key               'vagrant.pem'

validation_client_name   'chef-validator'
validation_key           "#{current_dir}/validation.pem"

chef_server_url          'http://33.33.33.100:4000'
cache_type               'BasicFile'
cache_options( :path => '.chef/checksums' )

cookbook_copyright      'Learn Yourself Some Chef'
cookbook_email          'chef@cruft.co'
cookbook_license        'apachev2'

cookbook_path           [
                          "#{current_dir}/../chef-repo/cookbooks/",
                        ]

encrypted_data_bag_secret "#{current_dir}/data_bag_key"
