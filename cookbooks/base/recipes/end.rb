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


## First steps documentation

support "ubuntu" do
  section "global"
end

support "usc" do
  section "base"
end

