#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: security
# Recipe:: default
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

include_recipe "base"


## Deploy

box = node[:box]
security = data_bag_item('apps', 'security')

# Uninstall apps not needed

apps = security['apps']
selected = box['apps']['security']
unselected = apps - selected

uninstall_apps "security" do
  apps unselected
  profiles security['profiles']
end

# Install selected apps

node.set[:apps] = { :security => security }

include_recipe "security::antivirus" if selected.include?("antivirus")
include_recipe "security::firewall" if selected.include?("firewall")
include_recipe "security::nautilus" if selected.include?("nautilus")
include_recipe "security::tracking" if selected.include?("tracking")

