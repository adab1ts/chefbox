#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: base
# Recipe:: main-mint
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


# Support for ia32-libs dependency
if platform_arch == "x86_64"
  %w[
    ia32-libs-multiarch
    i386
    lib32gcc1
    libc6-i386
  ].each do |pkg|
    package pkg
  end
end


# Virtualization support
unless virtual_box?
  %w[
    virtualbox-guest-dkms
    virtualbox-guest-utils
    virtualbox-guest-x11
  ].each do |pkg|
    package pkg do
      action :purge
    end
  end
end


# Commonly used restricted packages for Linux Mint
if platform_version < 15
  repo_name = "videolan-#{platform_codename}"

  apt_repository repo_name do
    uri "http://download.videolan.org/pub/debian/stable/ /"
    distribution ""
    key "http://download.videolan.org/pub/debian/videolan-apt.asc"
    action :add
    not_if { ::File.exists? "#{node[:apt][:sources_path]}/#{repo_name}.list" }
  end
end

