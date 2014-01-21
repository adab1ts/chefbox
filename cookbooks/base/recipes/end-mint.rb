#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: base
# Recipe:: end-mint
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


## First time system upgrade

held_pkgs = %w[
  linux-generic
  linux-headers-generic
  linux-image-generic
  base-files
  desktop-file-utils
  grub-common
]

new_pkgs = %w[
  mint-meta-cinnamon
  mint-mdm-themes
]

purge_pkgs = %w[
  nautilus
  nautilus-gksu
  nautilus-open-terminal
  nautilus-sendto-empathy
  nautilus-wallpaper
  gnome-session-fallback
]

h_pkgs = held_pkgs.join(" ")
n_pkgs = new_pkgs.join(" ")
p_pkgs = purge_pkgs.join(" ")

bash "first_system_upgrade" do
  code <<-EOH
    apt-mark hold #{h_pkgs}
    apt-get -y dist-upgrade
    apt-get -y install #{n_pkgs}
    apt-get -y purge #{p_pkgs}
    apt-get -y autoremove
    apt-get clean
    apt-mark unhold #{h_pkgs}
    EOH
  action :nothing
  subscribes :run, resources("ruby_block[first_run_completed]"), :immediately
end


## APT Sources

cookbook_file "/etc/apt/sources.list" do
  source "/apt/sources.list.final"
  mode 0644
  backup false
  notifies :run, "execute[base-last_system_update]", :immediately
end

execute "base-last_system_update" do
  command "apt-get update"
  action :nothing
end

