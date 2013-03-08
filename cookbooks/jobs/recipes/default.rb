#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: jobs
# Recipe:: default
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


## Requirements

# Displays directory tree, in color
package "tree"

# Graphical tool to diff and merge files
package "meld"


## Configuration

jobs = node[:jobs]
box  = node[:box]
box_profile = Chef::EncryptedDataBagItem.load("boxes", box[:id])

directory jobs[:log_path]

template jobs[:logrotate_conf] do
  source "/logrotate/jobs.erb"
  mode 0644
  backup false
  variables(
    :jobs => jobs[:job_list],
    :jobs_log_path => jobs[:log_path]
  )
end

admin_dir = "#{ENV['HOME']}/#{box_profile['admin_folder']}"
jobs_dir  = "#{admin_dir}/jobs"
logs_dir  = "#{jobs_dir}/logs"

directory admin_dir do
  owner box[:default_user]
  group box[:default_group]
  mode 0755
end

directory jobs_dir do
  owner box[:default_user]
  group box[:default_group]
  mode 0755
end

directory logs_dir do
  owner box[:default_user]
  group box[:default_group]
  mode 0755
end

template "#{jobs_dir}/setup" do
  source "/jobs/setup.erb"
  owner box[:default_user]
  group box[:default_group]
  mode 0644
  backup false
  variables(
    :jobs_user => box[:default_user],
    :jobs_path => jobs_dir,
    :jobs_log_path => jobs[:log_path]
  )
end


## Jobs

node.set[:box]  = { :lang => box_profile['lang'] }
node.set[:jobs] = { :path => jobs_dir }

include_recipe "jobs::backup"

