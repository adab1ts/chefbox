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


# Language support
package "language-pack-ca"
package "language-pack-gnome-ca"
package "aspell-ca"
package "myspell-ca"

package "language-pack-es"
package "language-pack-gnome-es"
package "aspell-es"
package "myspell-es"


os_release = platform_version

# Support for ia32-libs dependency
if platform_arch == "x86_64" and os_release == 12.04
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
if virtual_box? and os_release == 14.04
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

box[:users].each do |username, usr|
  execute "#{username}-remove_example_content_file" do
    command "rm #{usr[:home]}/examples.desktop"
    only_if { ::File.exists? "#{usr[:home]}/examples.desktop" }
  end
end


case platform_desktop
when "unity"
  # Nautilus plugins
  package "nautilus-filename-repairer"
  package "nautilus-open-terminal"

  # Commonly used restricted packages for Ubuntu
  package "ubuntu-restricted-extras" do
    notifies :run, "execute[install_additional_extras]", :immediately
  end
when "xfce"
  # Commonly used restricted packages for Ubuntu
  package "libavcodec-extra"
  package "xubuntu-restricted-extras"
  package "libdvdread4" do
    notifies :run, "execute[install_additional_extras]", :immediately
  end
end

# Simple foundation for reading DVDs
execute "install_additional_extras" do
  cwd "/usr/share/doc/libdvdread4"
  command "sh install-css.sh"
  action :nothing
end


# Codec issues
# see http://www.webupd8.org/2014/03/get-firefox-and-phonon-gstreamer-to.html
codename = platform_codename

if codename == "trusty"
  repo_name = "mc3man-trusty-media"
  repo_uri  = "ppa:mc3man/trusty-media"

  core_ppa repo_name do
    uri repo_uri
    distribution codename
    action :add
  end

  package "gstreamer0.10-ffmpeg"
end

