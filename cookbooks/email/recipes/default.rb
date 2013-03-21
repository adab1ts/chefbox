#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: email
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
email = data_bag_item('apps', 'email')

# Uninstall apps not needed

apps = email['apps']
selected = box['apps']['email']
unselected = apps - selected

uninstall_apps "email" do
  apps unselected
  profiles email['profiles']
end

# Install selected apps

node.set[:apps] = { :email => email }

include_recipe "email::geary" if selected.include?("geary")
include_recipe "email::thunderbird" if selected.include?("thunderbird")

