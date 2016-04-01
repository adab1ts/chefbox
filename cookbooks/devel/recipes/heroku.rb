#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Recipe:: heroku
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
#   https://toolbelt.heroku.com/debian

# notes:
#   - Remove .bashrc content set by heroku toolbelt

devel = node[:apps][:devel]

# Client library and CLI to deploy apps on Heroku
heroku = devel['profiles']['heroku']

if app_available? heroku
  # Installing heroku toolbelt ...
  install_app 'heroku' do
    force true
    profile heroku
  end

  # Setting heroku toolbelt environment up ...
  bootstrap 'heroku' do
    env priority: '10'
  end
end
