#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: utils
# Recipe:: backintime
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


utils = node[:apps][:utils]

# Simple backup system
backintime = utils['profiles']['backintime']

if app_available? backintime
  install_app "backintime" do
    force true
    profile backintime
  end

  backintime_pkg = app_package_name backintime
  package "nautilus-actions" do
    action :nothing
    subscribes :purge, resources("package[#{backintime_pkg}]"), :immediately
  end
end

