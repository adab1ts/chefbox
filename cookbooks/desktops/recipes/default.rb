#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: desktops
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


## Deploy

selected = node[:box][:apps][:desktops]

if selected
  desktops = data_bag_item('apps', 'desktops')
  apps = desktops['apps']

  # Uninstall apps not needed
  unselected = apps - selected

  uninstall_apps "desktops" do
    apps unselected
    profiles desktops['profiles']
  end

  # Install selected apps
  node.default[:apps] = { :desktops => desktops }

  include_recipe "desktops::cinnamon" if selected.include?("cinnamon")
end

