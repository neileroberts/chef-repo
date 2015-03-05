# See https://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "neil"
client_key               "#{current_dir}/neil.pem"
validation_client_name   "mgc-validator"
validation_key           "#{current_dir}/mgc-validator.pem"
chef_server_url          "https://gbh-neil-lx2.gbh.mentorg.com/organizations/mgc"
syntax_check_cache_path  "#{ENV['HOME']}/.chef/syntaxcache"
cookbook_path            ["#{current_dir}/../cookbooks"]
