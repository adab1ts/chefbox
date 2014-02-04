#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: security
# Recipe:: firewall
#
# Copyright 2013,2014 Carles Muiños
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


security = node[:apps][:security]

# Program for managing a Netfilter firewall
install_app "firewall" do
  profile security['profiles']['firewall']
end

cookbook_file "ufw_openssh-server" do
  path "/etc/ufw/applications.d/chef-openssh-server"
  source "/ufw/chef-openssh-server"
  mode 0644
  backup false
end

# Shut the backdoor!
# execute "ufw_allow_ssh" do
#   command "ufw allow ChefSSH"
#   action :nothing
#   subscribes :run, resources("cookbook_file[ufw_openssh-server]"), :immediately
# end

execute "ufw_enable" do
  command "ufw enable"
  action :nothing
  # subscribes :run, resources("execute[ufw_allow_ssh]"), :immediately
  subscribes :run, resources("cookbook_file[ufw_openssh-server]"), :immediately
end

support "firewall" do
  section "security"
end

