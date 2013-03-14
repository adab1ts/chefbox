#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: core
# Provider:: ppa
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


def whyrun_supported?
  true
end

def load_current_resource
  @current_resource = Chef::Resource::CorePpa.new(new_resource.name)
end

action :add do
  new_resource.updated_by_last_action false
  @aar = nil

  recipe_eval do
    execute "remove_sources_backup" do
      command "find /etc/apt -name \*.save -delete"
      action :nothing
    end

    execute "synchronize_package_index" do
      command "apt-get update"
      ignore_failure true
      action :nothing
    end

    @aar = execute "add-apt-repository #{new_resource.uri}" do
      command "add-apt-repository -y #{new_resource.uri}"
      creates "/etc/apt/sources.list.d/#{new_resource.name}-#{new_resource.run_context.node[:lsb][:codename]}.list"
      notifies :run, "execute[remove_sources_backup]", :immediately if new_resource.clean_saved
      notifies :run, "execute[synchronize_package_index]", :immediately if new_resource.cache_rebuild
    end
  end

  raise RuntimeError, "The ppa could not be added, cannot continue." if @aar.nil?
  new_resource.updated_by_last_action @aar.updated?
end

action :remove do
  ppa_name = "#{new_resource.name}-#{new_resource.run_context.node[:lsb][:codename]}"

  if ::File.exists?("/etc/apt/sources.list.d/#{ppa_name}.list")
    Chef::Log.info "Removing #{ppa_name} repository from /etc/apt/sources.list.d/"

    file "/etc/apt/sources.list.d/#{ppa_name}.list" do
      action :delete
    end
  end
end

