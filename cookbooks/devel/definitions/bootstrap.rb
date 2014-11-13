#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Definitions:: bootstrap
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


define :bootstrap, :shell => "zsh", :folders => [], :files => [], :templates => [], :links => [] do
  required = params[:requires] || "package[#{params[:name]}]"

  box = node[:box]
  devel = box[:devel]

  devel[:users].each do |username|
    usr = box[:users][username]

    if params[:before]
      bash "bootstrap_#{params[:name]}_for_#{username}" do
        code params[:before]
        user username
        group usr[:group]
        action :nothing
        subscribes :run, resources(required), :immediately
      end
    end

    params[:folders].each do |folder|
      dir = "#{usr[:home]}/#{folder}"

      directory_tree dir do
        exclude usr[:home]
        owner username
        group usr[:group]
        mode 00755
      end
    end

    params[:files].each do |f_|
      f = "#{usr[:home]}/#{f_}"

      devfile params[:name] do
        file f
        user username
        group usr[:group]
      end
    end

    params[:templates].each do |h|
      file = "#{usr[:home]}/#{h[:file]}"
      vars = h[:vars].merge(:devel_dir => "#{usr[:home]}/#{devel[:folder]}")

      devfile params[:name] do
        template file
        variables vars
        user username
        group usr[:group]
      end
    end

    params[:links].each do |h|
      link "#{usr[:home]}/#{h[:from]}" do
        to "#{usr[:home]}/#{h[:to]}"
        owner username
        group usr[:group]
      end
    end

    if params[:env]
      opts = params[:env]

      env params[:name] do
        dotfiles_dir "#{usr[:home]}/#{box[:dotfiles][:folder]}"
        shell "zsh"
        priority opts[:priority]
        vars opts[:vars]
        user username
        group usr[:group]
      end
    end

    if params[:aliases]
      aliases params[:name] do
        dotfiles_dir "#{usr[:home]}/#{box[:dotfiles][:folder]}"
        shell "zsh"
        user username
        group usr[:group]
      end
    end

    if params[:functions]
      functions params[:name] do
        dotfiles_dir "#{usr[:home]}/#{box[:dotfiles][:folder]}"
        shell "zsh"
        user username
        group usr[:group]
      end
    end
  end
end

