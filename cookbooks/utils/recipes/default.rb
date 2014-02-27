#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: utils
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

selected = node[:box][:apps][:utils]

if selected
  utils = data_bag_item('apps', 'utils')
  apps  = utils['apps']

  # Uninstall apps not needed
  unselected = apps - selected

  uninstall_apps "utils" do
    apps unselected
    profiles utils['profiles']
  end

  # Install selected apps
  node.default[:apps] = { :utils => utils }

  include_recipe "utils::backintime" if selected.include?("backintime")
  include_recipe "utils::fogger" if selected.include?("fogger")
  include_recipe "utils::furius" if selected.include?("furius")
  include_recipe "utils::hardinfo" if selected.include?("hardinfo")
  include_recipe "utils::p7zip" if selected.include?("p7zip")
  include_recipe "utils::shutter" if selected.include?("shutter")
end

