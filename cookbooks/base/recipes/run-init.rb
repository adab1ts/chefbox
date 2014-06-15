#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: base
# Recipe:: run-init
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


## Handlers

# Install the `chef-handler-mail` RubyGem during the compile phase
chef_gem "chef-handler-mail"

# chef_handler complains it cannot find 'chef/handler/mail.rb' file
require 'chef/handler/mail'

chef_handler "MailHandler" do
  source "chef/handler/mail"
  arguments :to_address => node[:chef_report][:recipient]
  action :enable
end


## APT Sources

sources_path = case node[:lsb][:id]
               when /linuxmint/i then "/etc/apt/sources.list.d/official-package-repositories.list"
               else "/etc/apt/sources.list"
               end

cookbook_file "sources.list" do
  path sources_path
  source "/apt/sources.list"
  mode 0644
  backup false
  notifies :run, "execute[run_init-system_update]", :immediately
  not_if { node.attribute?(:first_run_completed) }
end

execute "run_init-system_update" do
  command "apt-get update"
  action :nothing
end

