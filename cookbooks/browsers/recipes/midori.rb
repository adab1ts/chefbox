#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: browsers
# Recipe:: midori
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


browsers = node[:apps][:browsers]

# Fast, lightweight graphical web browser
midori = browsers['profiles']['midori']

if app_available? midori
  install_app "midori" do
    force true
    profile midori
  end

  box = node[:box]
  dotfiles = box[:dotfiles]

  dotfiles[:users].each do |username|
    usr = box[:users][username]

    dotfiles_dir = "#{usr[:home]}/#{dotfiles[:folder]}"
    bash_env_dir = "#{dotfiles_dir}/bash/env.d"

    cookbook_file "#{username}-midori_env_file" do
      path "#{bash_env_dir}/midori.benv"
      source "/env.d/midori.benv"
      owner username
      group usr[:group]
      mode 0644
      backup false
    end
  end
end

