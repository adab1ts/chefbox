#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Recipe:: webdesigner
#
# Copyright 2013-2016 Carles Muiños
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

# Google Web Designer
install_app 'webdesigner' do
  profile devel['profiles']['webdesigner']
end

webdesigner_source = "#{node[:apt][:sources_path]}/google-webdesigner.list"

file webdesigner_source do
  action :delete
  only_if { ::File.exist? webdesigner_source }
end
