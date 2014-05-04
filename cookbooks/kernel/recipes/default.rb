#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: kernel
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

kernel = data_bag_item('apps', 'kernel')

# Install drivers

drivers = node[:box][:apps][:drivers] || []

drivers.each do |driver|
  install_app driver do
    profile kernel['profiles'][driver]
  end
end

# Install apps

node.default[:apps] = { :kernel => kernel }

include_recipe "kernel::dkms"
include_recipe "kernel::preload" if memory > 1.GB
include_recipe "kernel::intel_graphics" if vendor(:graphics) == "intel"

selected = node[:box][:apps][:kernel] || []

include_recipe "kernel::tlp" if selected.include?("tlp")

