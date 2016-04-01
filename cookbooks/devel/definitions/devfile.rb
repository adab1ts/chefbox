#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Definitions:: dotfile
#
# Copyright 2013-2016 Carles Muiños
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

define :devfile, variables: {} do
  user = params[:user]
  grp  = params[:group]

  if params[:template]
    filename = ::File.basename params[:template]

    template params[:template] do
      source "/#{params[:name]}/#{filename}.erb"
      owner user
      group grp
      mode 00664
      backup false
      variables params[:variables]
    end
  else
    filename = ::File.basename params[:file]

    cookbook_file params[:file] do
      source "/#{params[:name]}/#{filename}"
      owner user
      group grp
      mode 00664
      backup false
      cookbook params[:cookbook]
    end
  end
end
