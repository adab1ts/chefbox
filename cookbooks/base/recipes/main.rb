#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: base
# Recipe:: main
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


box = node[:box]

# Language support
package "language-pack-#{box['lang']}"
package "language-pack-gnome-#{box['lang']}"
package "aspell-#{box['lang']}"
package "myspell-#{box['lang']}"


# Gnome-Do: Quickly perform actions on your desktop
package "gnome-do"
package "gnome-do-plugins"


# Platform-based tasks
case platform
when "mint"   then include_recipe "base::main-mint"
when "ubuntu" then include_recipe "base::main-ubuntu"
end


# MS Office True Type Fonts
fonts = data_bag_item('resources', 'fonts')
msfonts = fonts['msttfonts']

fonts_file   = msfonts['file']
fonts_url    = msfonts['url']
fonts_sha256 = msfonts['sha256']

cache_path = Chef::Config[:file_cache_path]
fonts_path = "/usr/share/fonts/truetype/msttfonts"

remote_file "#{cache_path}/#{fonts_file}" do
  source fonts_url
  checksum fonts_sha256
  notifies :run, "bash[install_fonts]", :immediately
end

bash "install_fonts" do
  cwd cache_path
  code <<-EOH
    [[ ! -d "#{fonts_path}" ]] && mkdir -m 755 -p #{fonts_path}
    tar -C #{fonts_path} -xzf #{fonts_file} \
    && chown root.root #{fonts_path}/* \
    && chmod 644 #{fonts_path}/*
    EOH
  action :nothing
end

box['users'].each do |username, usr|
  execute "#{username}-load_fonts" do
    command "fc-cache -fv"
    user username
    group usr['group']
    action :nothing
    subscribes :run, resources("bash[install_fonts]"), :immediately
  end
end

