#
# Cookbook Name:: dotfiles
# Recipe:: default
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


unless node.attribute?(:box)
  node.set[:box] = Chef::EncryptedDataBagItem.load('boxes', node[:profile])
  node.save
end


## Requirements

# Displays directory tree, in color
package "tree"

# Graphical tool to diff and merge files
package "meld"

# Search for files within Debian packages (command-line interface)
package "apt-file" do
  notifies :run, "execute[update_apt_file_cache]", :delayed
end

execute "update_apt_file_cache" do
  command "apt-file update"
  user box['default_user']
  action :nothing
end

# Lists available package versions with distribution
package "apt-show-versions"


## Deploy

box = node[:box]

dotfiles_dir = "#{box['home']}/#{box['dotfiles_folder']}"
bash_dotfiles_dir = "#{dotfiles_dir}/bash"

directory dotfiles_dir do
  owner box['default_user']
  group box['default_group']
  mode 0755
end

remote_directory bash_dotfiles_dir do
  owner box['default_user']
  group box['default_group']
  mode 0755
  files_owner box['default_user']
  files_group box['default_group']
  files_mode 0644
  files_backup false
end

template "#{bash_dotfiles_dir}/env" do
  source "/bash/env.erb"
  owner box['default_user']
  group box['default_group']
  mode 0644
  backup false
  variables(
    :admin_folder => box['admin_folder']
  )
end

template "#{dotfiles_dir}/bashrc" do
  source "/bash/bashrc.erb"
  owner box['default_user']
  group box['default_group']
  mode 0644
  backup false
  variables(
    :admin_folder => box['admin_folder']
  )
end

execute "backup_bashrc_file" do
  cwd box['home']
  command "mv .bashrc .bashrc.orig"
  user box['default_user']
  creates "#{box['home']}/.bashrc.orig"
end

link "#{box['home']}/.bashrc" do
  to "#{dotfiles_dir}/bashrc"
  owner box['default_user']
  group box['default_group']
end

