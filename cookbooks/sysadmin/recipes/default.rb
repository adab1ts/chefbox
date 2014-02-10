#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: sysadmin
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

selected = node[:box][:apps][:sysadmin]

if selected
  sysadmin = data_bag_item('apps', 'sysadmin')
  apps = sysadmin['apps']

  # Uninstall apps not needed
  unselected = apps - selected

  uninstall_apps "sysadmin" do
    apps unselected
    profiles sysadmin['profiles']
  end

  # Install selected apps
  node.default[:apps] = { :sysadmin => sysadmin }

  include_recipe "sysadmin::aptik" if selected.include?("aptik")
  include_recipe "sysadmin::epoptes" if selected.include?("epoptes")
  include_recipe "sysadmin::epoptesclient" if selected.include?("epoptesclient")
  include_recipe "sysadmin::freefilesync" if selected.include?("freefilesync")
  include_recipe "sysadmin::htop" if selected.include?("htop")
  include_recipe "sysadmin::yppamgr" if selected.include?("yppamgr")
end

