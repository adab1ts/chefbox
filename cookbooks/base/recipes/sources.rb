#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: base
# Recipe:: sources
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


sources_file = "sources.tar.gz"
cache_path   = Chef::Config[:file_cache_path]
tmp_dir      = "/tmp/chef/apt"
sources_path = "/etc/apt/sources.list.d"

cookbook_file "#{cache_path}/#{sources_file}" do
  source "/apt/#{sources_file}"
  backup false
  notifies :run, "bash[add_apt_sources]", :immediately
end

bash "add_apt_sources" do
  environment('CODENAME' => node[:lsb][:codename])
  code <<-EOH
    mkdir -p #{tmp_dir} \
    && cd #{tmp_dir} \
    && tar -xzf #{cache_path}/#{sources_file} \
    && for source in *; do [[ ! -f "#{sources_path}/${source}-#{node[:lsb][:codename]}.list" ]] && sh $source; done
    find /etc/apt -name \*.save -delete
    apt-get update
  EOH
  action :nothing
end

