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
arch = platform_arch

package "ia32-libs-multiarch" do
  action :install
  only_if { arch == "x86_64" }
end


# Y PPA Manager: PPA management
codename = platform_codename

core_ppa "webupd8team-y-ppa-manager" do
  uri "ppa:webupd8team/y-ppa-manager"
  distribution codename
  action :add
end

package "y-ppa-manager"


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


# Office productivity suite
package "libreoffice-style-galaxy"

support "libreoffice" do
  section "base"
end


# Commonly used restricted packages for Linux Mint
if platform_version < 15
  repo_name = "videolan-#{platform_codename}"

  apt_repository repo_name do
    uri "http://download.videolan.org/pub/debian/stable/ /"
    distribution ""
    key "http://download.videolan.org/pub/debian/videolan-apt.asc"
    action :add
    not_if { ::File.exists? "#{node['apt']['sources_path']}/#{repo_name}.list" }
  end
end

