#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Recipe:: virtualbox
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

## Requirements

# Dynamic Kernel Module Support Framework
package 'dkms'

## Installation
devel = node[:apps][:devel]

# Oracle VM VirtualBox 4.2.*
# refs:
#   https://github.com/genesis/wordpress
vbox = devel['profiles']['virtualbox']

if app_available? vbox
  install_app 'virtualbox' do
    force true
    profile vbox
  end

  node[:box][:devel][:users].each do |username|
    group 'vboxusers' do
      members username
      append true
      action :nothing
      subscribes :modify, resources('package[virtualbox]'), :immediately
    end
  end
end
