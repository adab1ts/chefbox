#
# Cookbook Name:: virtualization
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


unless node.attribute?(:box)
  node.set[:box] = Chef::EncryptedDataBagItem.load('boxes', node[:profile])
  node.save
end


box = node[:box]

virtualization = data_bag_item('apps', 'virtualization')
apps = virtualization['apps']

selected = box['apps']['virtualization'] || []
unselected = apps - selected


# Uninstall apps not needed

unselected.each do |app|
  pkg = virtualization["#{app}"]['package']

  package pkg do
    action :purge
  end
end


# Install selected apps

include_recipe "virtualization::virtualbox" if selected.include?("virtualbox")

