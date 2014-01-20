#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: core
# Definitions:: install_app
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


define :install_app do
  profile = params[:profile]

  # Replaced packages purge
  replaced = profile['replaced'] || []
  replaced.each do |pkg|
    package pkg do
      action :purge
    end
  end

  # Dependencies installation
  dependencies = profile['dependencies'] || []
  dependencies.each do |pkg|
    package pkg
  end

  lsb_codename = Coderebels::Chefbox::Box.lsb_codename
  arch = Coderebels::Chefbox::Box.arch

  origin = profile['source']['type']
  source = profile['source']['data']

  if origin == 'bin'
    # Download of package
    source = source[lsb_codename] || source['all']
    source = source[arch] || source['all']

    cache_path = Chef::Config[:file_cache_path]
    bin_file   = "#{cache_path}/#{source['file_name']}"

    remote_file bin_file do
      source source['uri']
      checksum source['sha256']
    end

    # Installation
    box = node[:box]

    box['users'].each do |username, usr|
      apps_dir = "#{usr['home']}/#{box['folders']['apps']}"

      directory_tree apps_dir do
        exclude usr['home']
        owner username
        group usr['group']
        mode 00755
      end

      unzip_cmd = case profile['source']['ztype']
                  when "tgz" then "tar -C #{apps_dir} -xzf #{bin_file}"
                  when "tbz" then "tar -C #{apps_dir} -xjf #{bin_file}"
                  end

      app_dir  = "#{apps_dir}/#{source['zfolder']}"
      app_home = "#{apps_dir}/#{params[:name]}"

      bash "#{username}_#{params[:name]}_install" do
        cwd cache_path
        code <<-EOH
          #{unzip_cmd}
          [[ ! -d "#{app_home}" ]] && mv #{app_dir} #{app_home}
          chown -R #{username}.#{usr['group']} #{app_home}
          EOH
        not_if { ::File.exists?(app_home) }
      end
    end
  elsif origin == 'deb'
    # Download of deb package
    source = source[lsb_codename] || source['all']
    source = source[arch] || source['all']

    deb_file = "#{Chef::Config[:file_cache_path]}/#{source['file_name']}"

    remote_file deb_file do
      source source['uri']
      checksum source['sha256']
    end

    # Installation
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
        distribution lsb_codename
        action :add
      end
    when 'repo'
      # apt source addition
      repo_name = "#{source['repo_name']}-#{lsb_codename}"
      dist = source['distribution'] || lsb_codename

      apt_repository repo_name do
        uri source['uri']
        distribution dist
        components source['components']
        key source['key']
        keyserver source['keyserver']
        action :add
        not_if { ::File.exists? "#{node['apt']['sources_path']}/#{repo_name}.list" }
      end
    end

    # Installation
    package params[:name] do
      package_name profile['package']
      version profile['version']
    end
  end

  # Suggested packages installation
  suggested = profile['suggested'] || []
  suggested.each do |pkg|
    package pkg
  end
end

