#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: core
# Definitions:: uninstaller
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


define :uninstaller, :variables => {} do
  box = node[:box]

  box['users'].reject { |_, usr| usr['guest'] }.each do |username, usr|
    apps_dir    = "#{usr['home']}/#{box['folders']['apps']}"
    uninstaller = "#{apps_dir}/uninstall_#{params[:name]}.sh"

    template uninstaller do
      source params[:template]
      owner username
      group usr['group']
      mode 00755
      backup false
      variables params[:variables]
    end
  end
end

