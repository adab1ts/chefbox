#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Recipe:: grunt
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


# The JavaScript task runner
execute "grunt-installation" do
  command "npm install -g grunt-cli"
  not_if { ::File.exists? "/usr/bin/grunt" }
end

# Additional packages
execute "grunt-init-installation" do
  command "npm install -g grunt-init"
  action :nothing
  subscribes :run, resources("execute[grunt-installation]"), :immediately
end

box = node[:box]

box[:devel][:users].each do |username|
  usr = box[:users][username]

  templates_dir = "#{usr[:home]}/.grunt-init"

  directory_tree templates_dir do
    exclude usr[:home]
    owner username
    group usr[:group]
    mode 00755
  end

  # Installing grunt-init-gruntfile to create a basic Gruntfile ...
  git "#{username}-grunt-init-gruntfile" do
    repository "https://github.com/gruntjs/grunt-init-gruntfile.git"
    revision "master"
    destination "#{templates_dir}/gruntfile"
    user username
    group usr[:group]
    action :sync
  end
end

