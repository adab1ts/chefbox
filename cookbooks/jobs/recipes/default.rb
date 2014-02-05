#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: jobs
# Recipe:: default
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

# Displays directory tree, in color
package "tree"

# Graphical tool to diff and merge files
package "meld"


## Configuration

box  = node[:box]
jobs = box[:jobs]

jobs_log_path = jobs[:log_path]
jobs_logrotate_conf = jobs[:logrotate_conf]

template jobs_logrotate_conf do
  source "/logrotate/jobs.erb"
  mode 00644
  backup false
  variables(
    :jobs_profiles => jobs[:profiles],
    :jobs_log_path => jobs_log_path
  )
end

jobs[:users].each do |username|
  directory_tree "#{jobs_log_path}/#{username}"

  usr = box[:users][username]
  jobs_dir = "#{usr[:home]}/#{jobs[:folder]}"

  directory_tree "#{jobs_dir}/logs" do
    exclude usr[:home]
    owner username
    group usr[:group]
    mode 00755
  end

  template "#{jobs_dir}/setup" do
    source "/jobs/setup.erb"
    owner username
    group usr[:group]
    mode 00644
    backup false
    variables(
      :jobs_user => username,
      :jobs_path => jobs_dir,
      :jobs_log_path => "#{jobs_log_path}/#{username}"
    )
  end
end

## Jobs

include_recipe "jobs::backup"

