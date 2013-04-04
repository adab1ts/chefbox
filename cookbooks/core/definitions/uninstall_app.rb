#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: core
# Definitions:: uninstall_app
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


define :uninstall_app do
  profile = params[:profile]

  # Suggested packages
  profile['suggested'].each do |pkg|
    package pkg do
      action :purge
    end
  end

  source = profile['source']
  origin = source['type']
  sources_dir = "/etc/apt/sources.list.d"

  package params[:name] do
    package_name profile['package']
    action :purge
    not_if do
      origin == "src" or
      (
        %w(repo ppa).include?(origin) and
        not ::File.exists?("#{sources_dir}/#{source['data']['repo_name']}-#{node[:lsb][:codename]}.list")
      )
    end
  end
end

