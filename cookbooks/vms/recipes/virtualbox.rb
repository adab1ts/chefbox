#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: vms
# Recipe:: virtualbox
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


## Requirements

# Dynamic Kernel Module Support Framework
package "dkms"


## Installation
vms = node[:apps][:vms]

# Oracle VM VirtualBox
vbox = vms['profiles']['virtualbox']

if app_available? vbox
  install_app "virtualbox" do
    force true
    profile vbox
  end

  box = node[:box]
  vbox_users = box[:users].select { |_, usr| not usr[:guest] }.map { |username, _| username }

  vbox_users.each do |username|
    group "vboxusers" do
      members username
      append true
      action :nothing
      subscribes :modify, resources("package[virtualbox]"), :immediately
    end
  end

  # TODO: needs review (sha256_url not found)
  # vms_vbox_extpack "virtualbox" do
  #   package vbox['package']
  #   action :nothing
  #   subscribes :install, resources("package[virtualbox]"), :immediately
  # end

  # VirtualBox autostart service
  cookbook_file "vbox-defaults" do
    path "/etc/default/virtualbox"
    source "/virtualbox/virtualbox"
    mode 0644
    backup false
  end

  directory "/etc/vbox" do
    group "vboxusers"
    mode 01775
  end

  template "vbox-autostart-cfg" do
    path "/etc/vbox/autostart.cfg"
    source "/virtualbox/autostart.cfg.erb"
    mode 0644
    backup false
    variables(
      :users => vbox_users
    )
  end

  bash "vbox-autostart-service" do
    code <<-EOH
      update-rc.d -f vboxautostart-service remove
      update-rc.d vboxautostart-service start 25 2 3 4 5 . stop 75 0 1 6 .
      EOH
    action :nothing
    subscribes :run, resources("template[vbox-autostart-cfg]"), :immediately
  end
end

