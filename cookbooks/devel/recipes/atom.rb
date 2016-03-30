#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Recipe:: atom
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
#   http://www.webupd8.org/2014/05/install-atom-text-editor-in-ubuntu-via-ppa.html
#   https://github.com/atom/atom
#   https://github.com/atom/atom/issues/2020
#   https://github.com/atom/atom/blob/master/docs/build-instructions/linux.md
#   https://discuss.atom.io/t/compilation-on-debian-wheezy-stable-glibc-2-13/8978/4

devel = node[:apps][:devel]

# Atom text editor from GitHub
atom = devel['profiles']['atom']

if app_available? atom
  install_app 'atom' do
    force true
    profile atom
  end

  box = node[:box]

  box[:devel][:users].each do |username|
    usr = box[:users][username]

    bash "#{username}-atom_packages_install" do
      user username
      group usr[:group]
      cwd usr[:home]
      environment 'HOME' => usr[:home]
      code <<-EOH
        # Loading user environment ...
        . ${HOME}/.bashrc

        # Installing atom packages ...
        # Themes
        apm install seti-ui
        apm install seti-syntax

        # Common
        apm install autocomplete-plus
        apm install autocomplete-snippets
        apm install autocomplete-paths

        apm install color-picker
        apm install minimap
        EOH
      action :run
    end
  end
end
