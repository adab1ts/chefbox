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

  origin = profile['source']['type']
  source = profile['source']['data']

  if origin == 'deb'
    # Download of deb package
    deb_file = "#{Chef::Config[:file_cache_path]}/#{source['file_name']}"

    remote_file deb_file do
      source source['uri']
      checksum source['sha256']
    end

    # Installation
    profile['dependencies'].each do |pkg|
      package pkg
    end

    package params[:name] do
      package_name profile['package']
      source deb_file
      provider Chef::Provider::Package::Dpkg
    end
  else
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

    # Installation
    package params[:name] do
      package_name profile['package']
    end
  end

  # Suggested packages
  profile['suggested'].each do |pkg|
    package pkg
  end
end

