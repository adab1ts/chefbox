#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Definitions:: functions
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

define :functions, shell: 'zsh' do
  user = params[:user]
  grp  = params[:group]
  functions_d = "#{params[:dotfiles_dir]}/#{params[:shell]}/functions.d"
  functions = case params[:shell]
              when 'zsh'  then "#{params[:name]}.zfn"
              when 'bash' then "#{params[:name]}.bfn"
              end

  cookbook_file "#{functions_d}/#{functions}" do
    source "/#{params[:name]}/#{functions}"
    owner user
    group grp
    mode 00664
    backup false
    cookbook params[:cookbook]
  end
end
