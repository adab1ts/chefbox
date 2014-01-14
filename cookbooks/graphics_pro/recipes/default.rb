#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: graphics_pro
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
selected = box['apps']['graphics_pro']

if selected
  graphics_pro = data_bag_item('apps', 'graphics_pro')
  apps = graphics_pro['apps']

  # Uninstall apps not needed
  unselected = apps - selected

  uninstall_apps "graphics_pro" do
    apps unselected
    profiles graphics_pro['profiles']
  end

  # Install selected apps
  node.set[:apps] = { :graphics_pro => graphics_pro }

  include_recipe "graphics_pro::darktable" if selected.include?("darktable")
  include_recipe "graphics_pro::draftsight" if selected.include?("draftsight")
  include_recipe "graphics_pro::freecad" if selected.include?("freecad")
  include_recipe "graphics_pro::gimp" if selected.include?("gimp")
  include_recipe "graphics_pro::inkscape" if selected.include?("inkscape")
  include_recipe "graphics_pro::mypaint" if selected.include?("mypaint")
  include_recipe "graphics_pro::qcad" if selected.include?("qcad")
  include_recipe "graphics_pro::rawtherapee" if selected.include?("rawtherapee")
  include_recipe "graphics_pro::scribus" if selected.include?("scribus")
end

