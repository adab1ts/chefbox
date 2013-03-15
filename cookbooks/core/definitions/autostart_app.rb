#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: core
# Definitions:: autostart_app
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


define :autostart_app do
  profile = params[:profile]

  box = node[:box]
  autostart_dir = "#{box['home']}/.config/autostart"
  desktop_file  = "#{profile['package']}.desktop"

  directory autostart_dir do
    owner box['default_user']
    group box['default_group']
    mode 00775
    recursive true
  end

  cookbook_file "#{autostart_dir}/#{desktop_file}" do
    source "/autostart/#{desktop_file}"
    cookbook params[:cookbook]
    backup false
    owner box['default_user']
    group box['default_group']
    mode 00664
  end
end
