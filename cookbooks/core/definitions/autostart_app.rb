#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: core
# Definitions:: autostart_app
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


define :autostart_app do
  profile = params[:profile]

  package_name = Coderebels::Chefbox::App.package_name profile
  box = node[:box]

  box[:users].each do |username, usr|
    autostart_dir = "#{usr[:home]}/.config/autostart"
    desktop_file  = params[:desktop_file] || "#{package_name}.desktop"

    directory_tree autostart_dir do
      exclude usr[:home]
      owner username
      group usr[:group]
      mode 00755
    end

    cookbook_file "#{autostart_dir}/#{desktop_file}" do
      source "/autostart/#{desktop_file}"
      cookbook params[:cookbook]
      backup false
      owner username
      group usr[:group]
      mode 00664
    end
  end
end

