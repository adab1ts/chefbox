#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: mobile
# Recipe:: mobile3g-full
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


mobile = node[:apps][:mobile]

# Shell script for establishing a 3G connection with any combination of modem or operator
mobile3g = mobile['profiles']['mobile3g-full']

cache_path = Chef::Config[:file_cache_path]
mobile3g_pkg = mobile3g['source']['data']
mobile3g_dir = "/opt/mobile3g"

remote_file "#{cache_path}/#{mobile3g_pkg['file']}" do
  source mobile3g_pkg['url']
  checksum mobile3g_pkg['sha256']
  backup false
  notifies :run, "bash[install_mobile3g]", :immediately
end

bash "install_mobile3g" do
  cwd cache_path
  code <<-EOH
    [[ ! -d '#{mobile3g_dir}' ]] && mkdir -p '#{mobile3g_dir}'
    tar -C '#{mobile3g_dir}' -xzf '#{mobile3g_pkg['file']}' \
    && chmod 755 '#{mobile3g_dir}/sakis3g'
    EOH
  action :nothing
  notifies :create, "link[mobile3g]", :immediately
end

link "mobile3g" do
  target_file "/usr/local/bin/mobile3g"
  to "#{mobile3g_dir}/sakis3g"
  action :nothing
end

launcher "mobile3g" do
  file "/mobile3g/mobile3g.desktop"
end

support "mobile3g" do
  section "mobile"
end

box = node[:box]

box['users'].select { |_, usr| usr['default'] }.each do |username, usr|
  support_folder = "#{usr['home']}/#{box['folders']['support']}/mobile"

  remote_directory "#{support_folder}/mobile3g" do
    source "mobile3g/setup"
    owner username
    group usr['group']
    mode 00755
    files_owner username
    files_group usr['group']
    files_mode 00644
    files_backup false
  end

  file "#{support_folder}/mobile3g/mobile3g-setup.sh" do
    owner username
    group usr['group']
    mode 00755
    backup false
  end
end

