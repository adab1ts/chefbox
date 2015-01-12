#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Recipe:: zsh
#
# Copyright 2013-2015 Carles Muiños
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

devel = node[:apps][:devel]

# shell with lots of features
zsh = devel['profiles']['zsh']

if app_available? zsh
  install_app 'zsh' do
    force true
    profile zsh
  end

  dotfiles_folder = node[:box][:dotfiles][:folder]

  dev_folders = [
    "#{dotfiles_folder}/zsh",
    "#{dotfiles_folder}/zsh/aliases.d",
    "#{dotfiles_folder}/zsh/completion.d",
    "#{dotfiles_folder}/zsh/env.d",
    "#{dotfiles_folder}/zsh/functions.d",
    "#{dotfiles_folder}/zsh/prompt.d"
  ]

  dev_files = [
    "#{dotfiles_folder}/zsh/aliases",
    "#{dotfiles_folder}/zsh/config",
    "#{dotfiles_folder}/zsh/env",
    "#{dotfiles_folder}/zsh/functions",
    "#{dotfiles_folder}/zsh/aliases.d/README.zal",
    "#{dotfiles_folder}/zsh/env.d/README.zenv",
    "#{dotfiles_folder}/zsh/functions.d/README.zfn",
    "#{dotfiles_folder}/zsh/prompt.d/prompt_zuzust_setup"
  ]

  dev_templates = [
    { file: "#{dotfiles_folder}/zshrc", vars: { dotfiles_dir: dotfiles_folder } }
  ]

  dev_links = [
    { from: '.zshrc', to: "#{dotfiles_folder}/zshrc" }
  ]

  bootstrap 'zsh' do
    folders dev_folders
    files dev_files
    templates dev_templates
    links dev_links
  end
end
