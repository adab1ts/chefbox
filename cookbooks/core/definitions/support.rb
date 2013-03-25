#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: core
# Definitions:: support
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


define :support do
  box = node[:box]
  support = data_bag_item('resources', 'support')
  section = support[params[:section]]
  
  prefix   = section['idx']
  resource = section['files'][params[:name]][box['lang']]

  box['users'].each do |username, usr|
    support_folder = "#{usr['home']}/#{box['folders']['support']}/#{prefix}-#{params[:section]}"
    support_file   = "#{support_folder}/#{resource['file']}"

    directory_tree support_folder do
      exclude usr['home']
      owner username
      group usr['group']
      mode 00755
    end

    remote_file support_file do
      source resource['url']
      checksum resource['sha256']
      owner username
      group usr['group']
      mode 00644
      backup false
    end
  end
end

