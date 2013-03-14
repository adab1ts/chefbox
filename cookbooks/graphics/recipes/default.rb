#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: graphics
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
graphics = data_bag_item('apps', 'graphics')

# Uninstall apps not needed

apps = graphics['apps']
selected = box['apps']['graphics']
unselected = apps - selected

uninstall_apps "graphics" do
  apps unselected
  profiles graphics['profiles']
end

# Install selected apps

node.set[:apps] = { :graphics => graphics }

include_recipe "graphics::gimp" if selected.include?("gimp")
include_recipe "graphics::inkscape" if selected.include?("inkscape")
include_recipe "graphics::scribus" if selected.include?("scribus")
include_recipe "graphics::mypaint" if selected.include?("mypaint")

