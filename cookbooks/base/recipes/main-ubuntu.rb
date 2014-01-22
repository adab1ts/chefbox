#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: base
# Recipe:: main-ubuntu
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
if virtual_box?
  %w[
    virtualbox-guest-dkms
    virtualbox-guest-utils
    virtualbox-guest-x11
  ].each do |pkg|
    package pkg
  end
end


# Ubuntu example content
package "example-content" do
  action :purge
end

box = node[:box]

box['users'].each do |username, usr|
  execute "#{username}-remove_example_content_file" do
    command "rm #{usr['home']}/examples.desktop"
    only_if { ::File.exists? "#{usr['home']}/examples.desktop" }
  end
end


# Nautilus plugins
package "nautilus-filename-repairer"
package "nautilus-open-terminal"


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

