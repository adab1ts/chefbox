#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Recipe:: nodejs
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
#   https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager

devel = node[:apps][:devel]

# Node.js event-based server-side javascript engine
install_app 'nodejs' do
  profile devel['profiles']['nodejs']
end

execute 'npm-python-config' do
  command 'npm config set python /usr/bin/python2 -g'
  action :nothing
  subscribes :run, resources('package[nodejs]'), :immediately
end
