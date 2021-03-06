#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: kernel
# Recipe:: tlp
#
# Copyright 2013-2016 Carles Muiños
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

kernel = node[:apps][:kernel]

# Save battery power on laptops
tlp = kernel['profiles']['tlp']

if app_available? tlp
  install_app 'tlp' do
    force true
    profile tlp
  end

  execute 'start_tlp' do
    command 'tlp start'
    action :nothing
    subscribes :run, resources('package[tlp]'), :immediately
  end
end
