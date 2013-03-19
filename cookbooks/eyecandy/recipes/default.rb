#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: eyecandy
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
eyecandy = data_bag_item('apps', 'eyecandy')

# Uninstall apps not needed

apps = eyecandy['apps']
selected = box['apps']['eyecandy']
unselected = apps - selected

uninstall_apps "eyecandy" do
  apps unselected
  profiles eyecandy['profiles']
end

# Install selected apps

node.set[:apps] = { :eyecandy => eyecandy }

include_recipe "eyecandy::faenza-icons" if selected.include?("faenza-icons")
include_recipe "eyecandy::faience-icons" if selected.include?("faience-icons")
include_recipe "eyecandy::nitrux-icons" if selected.include?("nitrux-icons")
include_recipe "eyecandy::unsettings" if selected.include?("unsettings")
