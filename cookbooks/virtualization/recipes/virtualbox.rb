#
# Cookbook Name:: virtualization
# Recipe:: virtualbox
#
# Copyright 2013, Carles Muiños
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


box = node[:box]

virtualization = data_bag_item('apps', 'virtualization')
vbox = virtualization['virtualbox']


## Requirements

# Dynamic Kernel Module Support Framework
package "dkms"


## Apt Source Addition

script = vbox['source']
cache_path = node[:deploy][:resources_path]
sources_path = "/etc/apt/sources.list.d"

cookbook_file "#{cache_path}/#{script}" do
  source "/apt/#{script}"
  backup false
  notifies :run, "bash[add_apt_virtualbox]", :immediately
end

bash "add_apt_virtualbox" do
  environment('CODENAME' => node[:lsb][:codename])
  cwd cache_path
  code <<-EOH
    [[ ! -f "#{sources_path}/#{script}-#{node[:lsb][:codename]}.list" ]] && sh #{script}
    find /etc/apt -name \*.save -delete
    apt-get update
  EOH
  action :nothing
end


## Deploy

vbox_package = vbox['package']
vbox_support_folder = "#{box['home']}/#{box['support_folder']}/VirtualBox"

apps_resources = data_bag_item('resources', 'apps')
support_resources = data_bag_item('resources', 'support')

vbox_extpack = apps_resources['virtualbox']
vbox_guide = support_resources['virtualbox']

# Oracle VM VirtualBox
package vbox_package do
  notifies :run, "execute[join_vboxusers_group]", :delayed
end

execute "join_vboxusers_group" do
  command "adduser #{box['default_user']} vboxusers"
  action :nothing
end

directory vbox_support_folder do
  owner box['default_user']
  group box['default_group']
  mode 0755
end

remote_file "#{vbox_support_folder}/#{vbox_extpack['file']}" do
  source vbox_extpack['url']
  checksum vbox_extpack['sha256']
  owner box['default_user']
  group box['default_group']
  mode 0644
end

remote_file "#{vbox_support_folder}/#{vbox_guide['file']}" do
  source vbox_guide['url']
  checksum vbox_guide['sha256']
  owner box['default_user']
  group box['default_group']
  mode 0644
end

