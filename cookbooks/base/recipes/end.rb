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

bash "first_system_upgrade" do
  code <<-EOH
    apt-get -y upgrade
    apt-get clean
    EOH
  action :nothing
  subscribes :run, resources("ruby_block[first_run_completed]"), :immediately
end


## Next steps documentation

box = node[:box]

box['users'].each do |username, usr|
  support_folder = "#{usr['home']}/#{box['folders']['support']}"

  directory_tree support_folder do
    exclude usr['home']
    owner username
    group usr['group']
    mode 00755
  end

  remote_directory support_folder do
    source "support"
    owner username
    group usr['group']
    mode 00755
    files_owner username
    files_group usr['group']
    files_mode 00644
    files_backup false
  end
end

