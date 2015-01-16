#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Recipe:: vagrant
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

# refs:
#   https://docs.vagrantup.com/v2/synced-folders/nfs.html
#   https://github.com/mitchellh/vagrant/issues/1941#issuecomment-68608908
#   http://askubuntu.com/questions/103910/nfs-is-blocked-by-ufw-even-though-ports-are-opened
#   https://github.com/genesis/wordpress#ssh---ssh-authentication-failed
#   https://github.com/smdahlen/vagrant-hostmanager

devel = node[:apps][:devel]

# Tool for building and distributing virtualized development environments
vagrant = devel['profiles']['vagrant']

if app_available? vagrant
  install_app 'vagrant' do
    force true
    profile vagrant
  end

  # NFS support
  %w(
    libgssglue1
    libnfsidmap2
    libtirpc1
    nfs-common
    nfs-kernel-server
    rpcbind
  ).each do |pkg|
    package pkg
  end

  cookbook_file '/etc/sudoers.d/10_vagrant_nfs' do
    source '/vagrant/vagrant_nfs'
    mode 00440
    backup false
  end

  cookbook_file 'nfs-kernel-server' do
    path '/etc/default/nfs-kernel-server'
    source '/vagrant/nfs-kernel-server'
    mode 0644
    backup false
  end

  cookbook_file 'ufw_nfs' do
    path '/etc/ufw/applications.d/nfs'
    source '/vagrant/ufw_nfs'
    mode 0644
    backup false
  end

  execute 'ufw_allow_nfs' do
    command 'ufw allow NFS'
    action :nothing
    subscribes :run, resources('cookbook_file[ufw_nfs]'), :immediately
  end

  # Vagrant insecure public key
  cache_path = Chef::Config[:file_cache_path]

  cookbook_file "#{cache_path}/vagrant.pub" do
    source '/vagrant/vagrant.pub'
    mode 00644
    backup false
  end

  box = node[:box]

  box[:devel][:users].each do |username|
    usr = box[:users][username]

    bash "#{username}-vagrant-setup" do
      user username
      group usr[:group]
      cwd usr[:home]
      environment 'HOME' => usr[:home]
      code <<-EOH
        # Loading user environment ...
        . ${HOME}/.bashrc

        cat #{cache_path}/vagrant.pub >> ${HOME}/.ssh/authorized_keys
        vagrant plugin install vagrant-hostmanager
        EOH
      action :run
    end

    template "/etc/sudoers.d/10_vagrant_hostmanager_#{username}" do
      source '/vagrant/vagrant_hostmanager.erb'
      mode 00440
      backup false
      variables(
        user: username
      )
    end
  end
end
