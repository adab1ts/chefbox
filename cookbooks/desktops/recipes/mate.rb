#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: desktops
# Recipe:: mate
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


desktops = node[:apps][:desktops]

# mate desktop
mate = desktops['profiles']['mate']

if app_available? mate 
  _, repo_data = app_source mate

  repo = repo_data['meta']
  codename = platform_codename

  repo_name = "#{repo['repo_name']}-#{codename}"
  dist = repo['distribution'] || codename

  apt_repository repo_name do
    uri repo['uri']
    distribution dist
    components repo['components']
    key repo['key']
    keyserver repo['keyserver']
    action :add
    not_if { ::File.exists? "#{node[:apt][:sources_path]}/#{repo_name}.list" }
  end

  package "mate-archive-keyring" do
    options "--allow-unauthenticated"
    notifies :run, "execute[mate-system_update]", :immediately
  end

  execute "mate-system_update" do
    command "apt-get update"
    action :nothing
  end

  package "mate-core"
  package "mate-desktop-environment"
end

