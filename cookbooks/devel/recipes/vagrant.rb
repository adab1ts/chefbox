#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Recipe:: vagrant
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


# refs:
#   https://github.com/smdahlen/vagrant-hostmanager

devel = node[:apps][:devel]

# Tool for building and distributing virtualized development environments
vagrant = devel['profiles']['vagrant']

if app_available? vagrant
  install_app "vagrant" do
    force true
    profile vagrant
  end

  box = node[:box]

  box[:devel][:users].each do |username|
    usr = box[:users][username]

    bash "#{username}-vagrant-hostmanager" do
      user username
      group usr[:group]
      cwd usr[:home]
      environment 'HOME' => usr[:home]
      code <<-EOH
        # Loading user environment ...
        . ${HOME}/.bashrc

        vagrant plugin install vagrant-hostmanager
        EOH
      action :run
    end

    template "/etc/sudoers.d/10_#{username}_vagrant_hostmanager" do
      source "/vagrant/vagrant_hostmanager.erb"
      mode 00440
      backup false
      variables(
        :user => username
      )
    end
  end
end

