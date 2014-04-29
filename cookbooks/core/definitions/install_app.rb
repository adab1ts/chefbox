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
  os      = Coderebels::Chefbox::Box.lsb_id
  release = Coderebels::Chefbox::Box.lsb_release
  
  # Check availability
  available = params[:force] || Coderebels::Chefbox::App.available?(profile, os, release)
  
  if available
    source_id, source_data = Coderebels::Chefbox::App.source profile, os, release

    # Purge replaced packages
    replaced = source_data['replaced'] || []
    replaced.each do |pkg|
      package pkg do
        action :purge
      end
    end

    # Install dependencies
    dependencies = source_data['dependencies'] || []
    dependencies.each do |pkg|
      package pkg
    end

    codename = Coderebels::Chefbox::Box.lsb_codename
    arch = Coderebels::Chefbox::Box.arch

    if source_id =~ /bin/
      bin_data = source_data

      # Download of package
      meta = bin_data['meta']
      bin  = meta[arch] || meta['*']

      cache_path = Chef::Config[:file_cache_path]
      bin_file   = "#{cache_path}/#{bin['file_name']}"

      remote_file bin_file do
        source bin['uri']
        checksum bin['sha256']
      end

      # Installation
      box = node[:box]

      box[:users].each do |username, usr|
        apps_dir = "#{usr[:home]}/#{box[:folders][:apps]}"

        directory_tree apps_dir do
          exclude usr[:home]
          owner username
          group usr[:group]
          mode 00755
        end

        unzip_cmd = case bin_data['ztype']
                    when "tgz" then "tar -C #{apps_dir} -xzf #{bin_file}"
                    when "tbz" then "tar -C #{apps_dir} -xjf #{bin_file}"
                    end

        app_dir  = "#{apps_dir}/#{bin['zfolder']}"
        app_home = "#{apps_dir}/#{params[:name]}"

        bash "#{username}_#{params[:name]}_install" do
          cwd cache_path
          code <<-EOH
            #{unzip_cmd}
            [[ ! -d "#{app_home}" ]] && mv #{app_dir} #{app_home}
            chown -R #{username}.#{usr[:group]} #{app_home}
            EOH
          not_if { ::File.exists?(app_home) }
        end
      end
    elsif source_id =~ /deb/
      deb_data = source_data

      # Download of deb package
      meta = deb_data['meta']
      deb  = meta[arch] || meta['*']

      deb_file = "#{Chef::Config[:file_cache_path]}/#{deb['file_name']}"

      remote_file deb_file do
        source deb['uri']
        checksum deb['sha256']
      end

      # Installation
      package params[:name] do
        package_name deb_data['package']
        source deb_file
        provider Chef::Provider::Package::Dpkg
      end
    else
      case source_id
      when /ppa/
        # PPA addition
        ppa = source_data['meta']

        core_ppa ppa['repo_name'] do
          uri ppa['uri']
          distribution codename
          action :add
        end
      when 'repo'
        repo_data = source_data

        # apt source addition
        repo = repo_data['meta']

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
      end

      # Installation
      pkg_name = params[:package] || source_data['package']
      package params[:name] do
        package_name pkg_name
        version source_data['version']
      end
    end

    # Install suggested packages
    suggested = source_data['suggested'] || []
    suggested.each do |pkg|
      package pkg
    end
  end
end

