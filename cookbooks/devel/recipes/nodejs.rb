#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Recipe:: nodejs
#
# Copyright 2013-2016 Carles Muiños
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
#   https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager
#   https://github.com/creationix/nvm

devel = node[:apps][:devel]

# Node.js event-based server-side javascript engine
nodejs = devel['profiles']['nodejs']

if app_available? nodejs
  # Installing nvm, to change Node versions ...
  install_app 'nodejs' do
    force true
    profile nodejs
  end

  # Setting nvm environment up ...
  bootstrap 'nodejs' do
    env priority: '10'
    functions true
  end

  box = node[:box]

  box[:devel][:users].each do |username|
    usr = box[:users][username]

    bash "#{username}-nvm_install" do
      user username
      group usr[:group]
      cwd usr[:home]
      environment 'HOME' => usr[:home]
      code <<-EOH
        # Loading user environment ...
        . ${HOME}/.bashrc

        # Activating nvm ...
        cd ${HOME}/.nvm && git checkout `git describe --abbrev=0 --tags`
        . ${HOME}/.nvm/nvm.sh

        # Installing latest Node.js ...
        nvm install node

        # Setting latest Node.js version as global default Node.js ...
        nvm alias default node
        EOH
      action :run
    end
  end
end
