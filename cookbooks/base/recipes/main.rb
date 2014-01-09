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

# Virtualization support
vbox_pkgs = %w[
  virtualbox-guest-dkms
  virtualbox-guest-utils
  virtualbox-guest-x11
]

case platform
when "ubuntu"
  # Virtualization support
  if virtual_box?
    vbox_pkgs.each do |pkg|
      package pkg
    end
  end

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

  # NX client for QT
  package "qtnx"

  # Nautilus plugins
  package "nautilus-filename-repairer"
  package "nautilus-open-terminal"

  # Office productivity suite
  package "lo-menubar" if platform_version == 12.04
  package "libreoffice-style-galaxy"

  support "libreoffice" do
    section "base"
  end

  # Commonly used restricted packages for Ubuntu
  package "ubuntu-restricted-extras" do
    notifies :run, "execute[install_additional_extras]", :immediately
  end

  # Simple foundation for reading DVDs
  execute "install_additional_extras" do
    cwd "/usr/share/doc/libdvdread4"
    command "sh install-css.sh"
    action :nothing
  end
when "mint"
  # Virtualization support
  unless virtual_box?
    vbox_pkgs.each do |pkg|
      package pkg do
        action :purge
      end
    end
  end

  # Office productivity suite
  package "libreoffice-style-galaxy"

  support "libreoffice" do
    section "base"
  end

  if platform_version < 15
    # Commonly used restricted packages for Linux Mint
    repo_name = "videolan-#{platform_codename}"

    apt_repository repo_name do
      uri "http://download.videolan.org/pub/debian/stable/ /"
      distribution ""
      key "http://download.videolan.org/pub/debian/videolan-apt.asc"
      action :add
      not_if { ::File.exists? "#{node['apt']['sources_path']}/#{repo_name}.list" }
    end
  end
end

# Gnome-Do: Quickly perform actions on your desktop
package "gnome-do"
package "gnome-do-plugins"

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

