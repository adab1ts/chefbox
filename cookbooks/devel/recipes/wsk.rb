#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Recipe:: wsk
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


devel = node[:apps][:devel]

# Boilerplate & tooling for multi-device development
wsk = devel['profiles']['wsk']

if app_available? wsk
  install_app "wsk" do
    force true
    profile wsk
  end

  box = node[:box]
  devel = box[:devel]
  wsk_home = "#{devel[:folder]}/wsk"

  devel[:users].each do |username|
    usr = box[:users][username]

    bash "#{username}-wsk_install" do
      user username
      group usr[:group]
      cwd usr[:home]
      environment 'HOME' => usr[:home]
      code <<-EOH
        # Loading user environment ...
        . ${HOME}/.bashrc

        export PATH="${HOME}/.rbenv/bin:${PATH}"
        eval "$(rbenv init -)"

        # Installing Sass ...
        gem install sass --no-document

        # Installing Web Starter Kit local dependencies ...
        cd #{wsk_home}
        npm install
        EOH
      action :nothing
      subscribes :run, resources("git[#{username}-wsk_git_install]"), :immediately
    end
  end
end

