current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "chefadmin"
client_key               "#{current_dir}/chefadmin.pem"
validation_client_name   "chef-validator"
validation_key           "#{current_dir}/chef-validator.pem"
chef_server_url          "https://chefserver-@@ENV@@.@@DOMAIN@@"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
cookbook_copyright       "Carles Muiños"
cookbook_email           "carles.ml.dev@gmail.com"
cookbook_license         "apachev2"
