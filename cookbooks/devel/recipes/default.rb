#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Recipe:: default
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


## Deploy

selected = node[:box][:apps][:devel]

if selected
  devel = data_bag_item('apps', 'devel')
  apps  = devel['apps']

  # Uninstall apps not needed
  unselected = apps - selected

  uninstall_apps "devel" do
    apps unselected
    profiles devel['profiles']
  end

  # Install selected apps
  node.default[:apps] = { :devel => devel }

  # Prepare development environment
  include_recipe "devel::zsh"

  devel_folder = node[:box][:devel][:folder]
  bin_folder   = node[:box][:devel][:bin_folder]

  bootstrap "devel" do
    folders [devel_folder, bin_folder]
    env :priority => "00", :vars => { :bin_folder => bin_folder }
  end

  if platform == "debian"
    bash "libc6-upgrade" do
      code <<-EOH
        echo 'deb http://ftp.us.debian.org/debian/ testing main contrib non-free' > "#{node[:apt][:sources_path]}/libc6-sid.list"
        apt-get update
        apt-get -y install -t testing libc6
        echo '#deb http://ftp.us.debian.org/debian/ testing main contrib non-free' > "#{node[:apt][:sources_path]}/libc6-sid.list"
        EOH
      action :run
      not_if { ::File.exists? "#{node[:apt][:sources_path]}/libc6-sid.list" }
    end
  end

  # Utils
  include_recipe "devel::shelr" if selected.include?("shelr")

  # VCS solutions
  include_recipe "devel::git" if selected.include?("git")

  # Programming languages
  include_recipe "devel::nodejs" if selected.include?("nodejs")
  include_recipe "devel::processing" if selected.include?("processing")
  include_recipe "devel::ruby" if selected.include?("ruby")

  # Development toolkit
  include_recipe "devel::ansible" if selected.include?("ansible")
  include_recipe "devel::bower" if selected.include?("bower")
  include_recipe "devel::grunt" if selected.include?("grunt")
  include_recipe "devel::gulp" if selected.include?("gulp")
  include_recipe "devel::wsk" if selected.include?("wsk")
  include_recipe "devel::yeoman" if selected.include?("yeoman")

  # Code editors
  include_recipe "devel::atom" if selected.include?("atom")
  include_recipe "devel::brackets" if selected.include?("brackets")

  # Virtualization solutions
  include_recipe "devel::virtualbox" if selected.include?("virtualbox")

  # Development stacks
  include_recipe "devel::vagrant" if selected.include?("vagrant")
  include_recipe "devel::wp-devel" if selected.include?("wp-devel")

  # Cloud solutions
  include_recipe "devel::juju" if selected.include?("juju")
end

