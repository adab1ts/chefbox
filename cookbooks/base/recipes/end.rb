#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: base
# Recipe:: end
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


ruby_block "first_run_completed" do
  block do
    node.set[:first_run_completed] = true
    node.save
  end
  not_if { node.attribute?(:first_run_completed) }
end


## First time system upgrade

case platform
when "ubuntu"
  bash "first_system_upgrade" do
    code <<-EOH
      apt-get -y upgrade
      apt-get -y autoremove
      apt-get clean
      EOH
    action :nothing
    subscribes :run, resources("ruby_block[first_run_completed]"), :immediately
  end
when "mint"
  held_pkgs = %w[
    linux-generic
    linux-headers-generic
    linux-image-generic
    base-files
    desktop-file-utils
    grub-common
  ]

  purge_pkgs = %w[
    nautilus
    nautilus-gksu
    nautilus-open-terminal
    nautilus-sendto-empathy
    nautilus-wallpaper
  ]

  # NOTE: Uncomment
  # purge_pkgs += %w[
  #   virtualbox-guest-dkms
  #   virtualbox-guest-utils
  #   virtualbox-guest-x11
  # ]

  h_pkgs = held_pkgs.join(" ")
  p_pkgs = purge_pkgs.join(" ")

  bash "first_system_upgrade" do
    code <<-EOH
      apt-mark hold #{h_pkgs}
      apt-get -y dist-upgrade
      apt-get -y purge #{p_pkgs}
      apt-get -y autoremove
      apt-get clean
      apt-mark unhold #{h_pkgs}
      EOH
    action :nothing
    subscribes :run, resources("ruby_block[first_run_completed]"), :immediately
  end
end


## First steps documentation

support platform do
  section "global"
end

support "sc" do
  section "base"
end

