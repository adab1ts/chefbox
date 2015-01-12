#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Recipe:: wp-devel
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
#   https://github.com/genesis/wordpress

# Genesis WordPress
execute 'generator-genesis-wordpress-install' do
  command 'npm install -g generator-genesis-wordpress'
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

# Additional packages
bash 'grunt-packages' do
  code <<-EOH
    npm install -g grunt-wordpress-deploy
    npm install -g grunt-sftp-deploy
    npm install -g grunt-ftp-deploy
    EOH
  action :run
end

bash 'gulp-packages' do
  code <<-EOH
    npm install -g gulp-sftp
    npm install -g gulp-ftp
    EOH
  action :run
end

bootstrap 'wp-devel' do
  aliases true
end
