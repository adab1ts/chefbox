#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: sysadmin
# Recipe:: epoptesclient
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


sysadmin = node[:apps][:sysadmin]

# Computer lab management tool
epoptesclient = sysadmin['profiles']['epoptesclient']

if app_available? epoptesclient
  install_app "epoptesclient" do
    force true
    profile epoptesclient
  end

  cookbook_file "/etc/default/epoptes-client" do
    source "/epoptes/epoptes-client"
    mode 0644
    backup false
  end
end

