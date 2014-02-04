#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: office
# Recipe:: msttfonts
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


# MS Office True Type Fonts
msfonts = node[:office][:msttfonts]
cache_path = Chef::Config[:file_cache_path]

remote_file "#{cache_path}/#{msfonts[:file]}" do
  source msfonts[:url]
  checksum msfonts[:sha256]
  notifies :run, "bash[install_fonts]", :immediately
end

bash "install_fonts" do
  cwd cache_path
  code <<-EOH
    [[ ! -d "#{msfonts[:path]}" ]] && mkdir -m 755 -p #{msfonts[:path]}
    tar -C #{msfonts[:path]} -xzf #{msfonts[:file]} \
    && chown root.root #{msfonts[:path]}/* \
    && chmod 644 #{msfonts[:path]}/*
    EOH
  action :nothing
end

box = node[:box]

box[:users].each do |username, usr|
  execute "#{username}-load_fonts" do
    command "fc-cache -fv"
    user username
    group usr[:group]
    action :nothing
    subscribes :run, resources("bash[install_fonts]"), :immediately
  end
end

