#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: core
# Definitions:: launcher
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


define :launcher, :variables => {} do
  box = node[:box]

  box['users'].each do |username, usr|
    launchers_dir = "#{usr['home']}/.local/share/applications"
    launcher = "#{launchers_dir}/#{params[:name]}.desktop"

    directory_tree launchers_dir do
      exclude usr['home']
      owner username
      group usr['group']
      mode 00755
    end

    if params[:template]
      template launcher do
        source params[:template]
        owner username
        group usr['group']
        mode 00664
        backup false
        variables params[:variables]
      end
    else
      cookbook_file launcher do
        source params[:file]
        owner username
        group usr['group']
        mode 00664
        backup false
        cookbook params[:cookbook]
      end
    end
  end
end

