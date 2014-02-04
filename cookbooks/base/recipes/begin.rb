#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: base
# Recipe:: begin
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

package "openssl"
package "libshadow-ruby1.8"


## Users management

box = node[:box]

box[:users].select { |_, usr| not usr[:default] }.each do |username, usr|
  group usr[:group] do
    gid usr[:gid]
  end

  passwd = shadow usr[:password]

  user username do
    comment username
    uid usr[:uid]
    gid usr[:group]
    home usr[:home]
    shell usr[:shell]
    password passwd
    supports(
      :manage_home => true
    )
  end

  if usr[:sudo]
    group "sudo" do
      members username
      append true
      action :modify
    end

    sudo "10_#{username}" do
      template "sudoer.erb"
      variables(
        :sudoer => username
      )
    end
  end
end

