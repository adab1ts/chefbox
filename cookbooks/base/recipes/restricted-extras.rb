#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: base
# Recipe:: restricted-extras
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
  notifies :run, "execute[load_fonts]", :immediately
  action :nothing
end

execute "load_fonts" do
  command "fc-cache -fv"
  user node[:box]['default_user']
  action :nothing
end

