#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: dotfiles
# Recipe:: default
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


## Requirements

# Displays directory tree, in color
package "tree"

# Graphical tool to diff and merge files
package "meld"

# Search for files within Debian packages (command-line interface)
package "apt-file"

execute "update_apt_file_cache" do
  command "apt-file update"
  action :nothing
  subscribes :run, resources("package[apt-file]"), :immediately
end

support "apt-file" do
  section "base"
end

# Lists available package versions with distribution
package "apt-show-versions"


## Deploy

box = node[:box]
dotfiles = box[:dotfiles]

dotfiles[:users].each do |username|
  usr = box[:users][username]

  dotfiles_dir = "#{usr[:home]}/#{dotfiles[:folder]}"
  bash_dotfiles_dir = "#{dotfiles_dir}/bash"

  directory_tree dotfiles_dir do
    exclude usr[:home]
    owner username
    group usr[:group]
    mode 00755
  end

  remote_directory bash_dotfiles_dir do
    owner username
    group usr[:group]
    mode 0755
    files_owner username
    files_group usr[:group]
    files_mode 0644
    files_backup false
  end

  template "#{bash_dotfiles_dir}/env" do
    source "/bash/env.erb"
    owner username
    group usr[:group]
    mode 0644
    backup false
    variables(
      :admin_folder => box[:folders][:admin],
      :dotfiles_folder => dotfiles[:folder]
    )
  end

  template "#{dotfiles_dir}/bashrc" do
    source "/bash/bashrc.erb"
    owner username
    group usr[:group]
    mode 0644
    backup false
    variables(
      :dotfiles_folder => dotfiles[:folder]
    )
  end

  execute "backup_bashrc_file" do
    cwd usr[:home]
    command "mv .bashrc .bashrc.orig"
    user username
    creates "#{usr[:home]}/.bashrc.orig"
    only_if { ::File.exists?(".bashrc") }
  end

  link "#{usr[:home]}/.bashrc" do
    to "#{dotfiles_dir}/bashrc"
    owner username
    group usr[:group]
  end
end

