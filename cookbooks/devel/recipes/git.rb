#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Recipe:: git
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


devel = node[:apps][:devel]

# Fast, scalable, distributed revision control system
install_app "git" do
  profile devel['profiles']['git']
end

box = node[:box]
dotfiles_folder = box['dotfiles']['folder']

dev_files = [
  "#{dotfiles_folder}/gitconfig",
  "#{dotfiles_folder}/zsh/prompt.d/prompt_zuzust_setup"
]

dev_links = [
  { :from => '.gitconfig', :to => "#{dotfiles_folder}/gitconfig" }
]

bootstrap "git" do
  files dev_files
  links dev_links
  aliases true
  functions true
end

