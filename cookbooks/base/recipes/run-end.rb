#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: base
# Recipe:: run-end
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


## Clean up

bash "run_end-clean_up" do
  code <<-EOH
    apt-get -y purge mutt
    apt-get -y autoremove
    EOH
  action :run
  not_if { node.attribute?(:first_run_completed) }
end


## APT Sources

if platform == "linuxmint"
  cookbook_file "sources.list.final" do
    path "/etc/apt/sources.list"
    source "/apt/sources.list.final"
    mode 0644
    backup false
    notifies :run, "execute[run_end-system_update]", :immediately
  end

  execute "run_end-system_update" do
    command "apt-get update"
    action :nothing
  end
end


## Final tasks

ruby_block "first_run_completed" do
  block do
    node.set[:first_run_completed] = true
  end
  not_if { node.attribute?(:first_run_completed) }
end

execute "system-reboot" do
  command "shutdown -r +1 &"
  action :nothing
  subscribes :run, resources("ruby_block[first_run_completed]"), :delayed
end

