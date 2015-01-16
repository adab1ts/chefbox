#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Recipe:: chefdk
#
# Copyright 2013-2015 Carles Muiños
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
#   https://www.chef.io/blog/2014/04/15/chef-development-kit/
#   https://downloads.chef.io/chef-dk/
#   https://docs.chef.io/devkit/
#   https://docs.chef.io/devkit/chef_overview.html
#   https://docs.chef.io/devkit/install_dk.html
#   https://docs.chef.io/devkit/getting_started.html
#   http://tcotav.github.io/chefdk_getting_started.html
#
#   https://github.com/opscode/chef-dk#using-chefdk-as-your-primary-development-environment
#   https://dwradcliffe.com/2014/09/19/chefdk-with-rbenv.html

devel = node[:apps][:devel]

# Chef Development Kit
chefdk = devel['profiles']['chefdk']

if app_available? chefdk
  install_app 'chefdk' do
    force true
    profile chefdk
  end

  box = node[:box]

  box[:devel][:users].each do |username|
    usr = box[:users][username]

    bash "#{username}-chefdk_setup" do
      user username
      group usr[:group]
      cwd usr[:home]
      environment 'HOME' => usr[:home]
      code <<-EOH
        # Loading user environment ...
        . ${HOME}/.bashrc

        if [[ -d "${HOME}/.rbenv/versions" ]]; then
          ln -s /opt/chefdk/embedded ${HOME}/.rbenv/versions/chefdk
        else
          echo 'eval "$(chef shell-init zsh)"' >> "${HOME}/#{box[:dotfiles][:folder]}/zsh/env.d/20_chefdk.zenv"
        fi
        EOH
      action :nothing
      subscribes :run, resources('package[chefdk]'), :immediately
    end
  end
end
