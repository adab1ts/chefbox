#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: fileshare
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

selected = node[:box][:apps][:fileshare]

if selected
  fileshare = data_bag_item('apps', 'fileshare')
  apps = fileshare['apps']

  # Uninstall apps not needed
  unselected = apps - selected

  uninstall_apps "fileshare" do
    apps unselected
    profiles fileshare['profiles']
  end

  # Install selected apps
  node.default[:apps] = { :fileshare => fileshare }

  include_recipe "fileshare::jdownloader" if selected.include?("jdownloader")
  include_recipe "fileshare::transmission" if selected.include?("transmission")
  include_recipe "fileshare::uget" if selected.include?("uget")
end

