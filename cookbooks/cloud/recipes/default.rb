#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: cloud
# Recipe:: default
#
# Copyright 2013-2015 Carles Muiños
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

selected = node[:box][:apps][:cloud]

if selected
  cloud = data_bag_item('apps', 'cloud')
  apps  = cloud['apps']

  # Uninstall apps not needed
  unselected = apps - selected

  uninstall_apps 'cloud' do
    apps unselected
    profiles cloud['profiles']
  end

  # Install selected apps
  node.default[:apps] = { cloud: cloud }

  include_recipe 'cloud::copy' if selected.include?('copy')
  include_recipe 'cloud::drive' if selected.include?('drive')
  include_recipe 'cloud::dropbox' if selected.include?('dropbox')
  include_recipe 'cloud::owncloud' if selected.include?('owncloud')
end
