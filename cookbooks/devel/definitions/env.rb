#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Definitions:: env
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


define :env, :shell => "zsh", :priority => "10", :vars => nil do
  env = case params[:shell]
          when "zsh"  then "#{params[:name]}.zenv"
          when "bash" then "#{params[:name]}.benv"
          end

  env_d = "#{params[:dotfiles_dir]}/#{params[:shell]}/env.d"
  env_path = "#{env_d}/#{params[:priority]}_#{env}"
  env_source = "/#{params[:name]}/#{env}"

  if params[:vars]
    template env_path do
      source "#{env_source}.erb"
      owner params[:user]
      group params[:group]
      mode 00664
      backup false
      variables params[:vars]
    end
  else
    cookbook_file env_path do
      source env_source
      owner params[:user]
      group params[:group]
      mode 00664
      backup false
      cookbook params[:cookbook]
    end
  end
end

