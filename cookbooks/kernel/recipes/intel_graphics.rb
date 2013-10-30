#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: kernel
# Recipe:: intel_graphics
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

package "wget"


## Deploy

kernel = node[:apps][:kernel]

cache_path = Chef::Config[:file_cache_path]
key_file   = "RPM-GPG-KEY-ilg"
key_file_2 = "RPM-GPG-KEY-ilg-2"

bash "add_apt_keys" do
  cwd cache_path
  creates "#{cache_path}/#{key_file}"
  code <<-EOH
    wget --no-check-certificate https://download.01.org/gfx/#{key_file}
    apt-key add "#{cache_path}/#{key_file}"

    wget --no-check-certificate https://download.01.org/gfx/#{key_file_2}
    apt-key add "#{cache_path}/#{key_file_2}"
    EOH
end

# Intel graphics drivers update utility
install_app "intel_graphics" do
  profile kernel['profiles']['intel_graphics']
end

execute "intel-linux-graphics-installer" do
  action :nothing
  subscribes :run, resources("package[intel_graphics]"), :delayed
end

