#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: base
# Recipe:: main
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


box = node[:box]

# Ubuntu example content
package "example-content" do
  action :purge
end

box['users'].each do |username, usr|
  execute "#{username}-remove_example_content_file" do
    command "rm #{usr['home']}/examples.desktop"
    only_if { ::File.exists? "#{usr['home']}/examples.desktop" }
  end
end

# Dynamic Kernel Module Support Framework
package "dkms"

# Adaptive readahead daemon
package "preload" if memory > 2.GB

# NX client for QT
package "qtnx"

# 7z and 7za file archivers with high compression ratio
package "p7zip-full"

# Nautilus plugins
package "nautilus-filename-repairer"
package "nautilus-gtkhash"
package "nautilus-open-terminal"

# Office productivity suite
package "lo-menubar" if node[:platform_version] == "12.04"
package "libreoffice-style-galaxy"

# Commonly used restricted packages for Ubuntu
package "ubuntu-restricted-extras" do
  notifies :run, "execute[install_additional_extras]", :immediately
end

execute "install_additional_extras" do
  cwd "/usr/share/doc/libdvdread4"
  command "sh install-css.sh"
  action :nothing
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
    action :nothing
    subscribes :run, resources("bash[install_fonts]"), :immediately
  end
end

