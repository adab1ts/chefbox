#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: utils
# Recipe:: furius
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


utils = node[:apps][:utils]

# ISO, IMG, BIN, MDF and NRG image management utility
install_app "furius" do
  profile utils['profiles']['furius']
end

box = node[:box]

box['users'].each do |username, usr|
  furius_dir = "#{usr['home']}/.furiusisomount"

  directory_tree furius_dir do
    exclude usr['home']
    owner username
    group usr['group']
    mode 00755
  end

  template "#{furius_dir}/settings.cfg" do
    source "/furius/settings.cfg.erb"
    owner username
    group usr['group']
    mode 0644
    backup false
    variables(
      :mount_point => "#{usr['home']}/#{box['folders']['desktop']}"
    )
  end
end

support "furius" do
  section "utils"
end

