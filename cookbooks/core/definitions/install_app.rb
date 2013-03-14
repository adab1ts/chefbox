#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: core
# Definitions:: install_app
#
# Copyright 2013, Carles Muiños
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


define :install_app do
  profile = params[:profile]

  ## Source Management
  origin = profile['source']['type']
  source = profile['source']['data']

  case origin
  when 'ppa'
    # PPA addition
    core_ppa source['repo_name'] do
      uri source['uri']
      distribution node[:lsb][:codename]
      action :add
    end
  when 'repo'
    # apt source addition
    apt_repository "#{source['repo_name']}-#{node[:lsb][:codename]}" do
      uri source['uri']
      distribution node[:lsb][:codename]
      components source['components']
      key source['key']
      action :add
    end
  end

  ## Installation
  package params[:name] do
    package_name profile['package']
  end

  # Suggested packages
  profile['suggested'].each do |pkg|
    package pkg
  end
end

