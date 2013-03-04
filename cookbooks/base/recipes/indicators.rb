#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: base
# Recipe:: indicators
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


autostart_dir = "#{ENV['HOME']}/.config/autostart"

directory autostart_dir do
  owner node[:base][:uid]
  group node[:base][:gid]
  mode 0775
  recursive true
end

# Display notifications about newly plugged hardware
package "udev-notify"

cookbook_file "#{autostart_dir}/udev-notify.desktop" do
  source "/autostart/udev-notify.desktop"
  backup false
  owner node[:base][:uid]
  group node[:base][:gid]
  mode 0664
end

# A status bar application able to temporarily prevent the activation
# of both the screensaver and the "sleep" powersaving mode
package "caffeine"

cookbook_file "#{autostart_dir}/caffeine.desktop" do
  source "/autostart/caffeine.desktop"
  backup false
  owner node[:base][:uid]
  group node[:base][:gid]
  mode 0664
end

# Indicator for Ubuntu One synchronization service
package "indicator-ubuntuone" if node[:platform_version] == "12.04"

