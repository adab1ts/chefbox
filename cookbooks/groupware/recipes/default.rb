#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: groupware
# Recipe:: default
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


## Requirements

include_recipe "base"


## Deploy

box = node[:box]
selected = box['apps']['groupware']

if selected
  groupware = data_bag_item('apps', 'groupware')
  apps = groupware['apps']

  # Uninstall apps not needed
  unselected = apps - selected

  uninstall_apps "groupware" do
    apps unselected
    profiles groupware['profiles']
  end

  # Install selected apps
  node.set[:apps] = { :groupware => groupware }

  include_recipe "groupware::hangouts" if selected.include?("hangouts")
  include_recipe "groupware::mumble" if selected.include?("mumble")
  include_recipe "groupware::skype" if selected.include?("skype")
  include_recipe "groupware::xchat" if selected.include?("xchat")
end

