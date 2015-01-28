#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: cloud
# Recipe:: copy
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

cloud = node[:apps][:cloud]

# Copy sync client
copy = cloud['profiles']['copy']

if app_available? copy
  install_app 'copy' do
    force true
    profile copy
  end

  uninstaller 'copy' do
    template "/copy/uninstall_copy-#{box[:lang]}.sh.erb"
    variables(
      app: 'copy',
      website: copy['website']
    )
  end
end
