#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
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


## Requirements

# Dynamic Kernel Module Support Framework
package "dkms"


## Apt Source Addition

virtualization = node[:apps][:virtualization]
vbox = virtualization['profiles']['virtualbox']

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

# Oracle VM VirtualBox
box = node[:box]

package vbox['package'] do
  notifies :run, "execute[join_vboxusers_group]", :immediately
  notifies :install, "virtualization_vbox_extpack[#{vbox['package']}]", :immediately
end

execute "join_vboxusers_group" do
  command "adduser #{box['default_user']} vboxusers"
  action :nothing
end

virtualization_vbox_extpack vbox['package'] do
  action :nothing
end

