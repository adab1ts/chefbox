#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: vms
# Recipe:: virtualbox
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

# Dynamic Kernel Module Support Framework
package "dkms"


## Installation

box = node[:box]
virtualization = node[:apps][:virtualization]
vbox = virtualization['profiles']['virtualbox']

# Oracle VM VirtualBox
install_app "virtualbox" do
  profile vbox
end

box['users'].reject { |_, usr| usr['guest'] }.each do |username, usr|
  group "vboxusers" do
    members username
    append true
    action :nothing
    subscribes :modify, resources("package[virtualbox]"), :immediately
  end
end

vms_vbox_extpack "virtualbox" do
  package vbox['package']
  action :nothing
  subscribes :install, resources("package[virtualbox]"), :immediately
end

