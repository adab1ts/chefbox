#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: video_pro_pro
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


## Deploy

selected = node[:box][:apps][:video_pro]

if selected
  video_pro = data_bag_item('apps', 'video_pro')
  apps  = video_pro['apps']

  # Uninstall apps not needed
  unselected = apps - selected

  uninstall_apps "video_pro" do
    apps unselected
    profiles video_pro['profiles']
  end

  # Install selected apps
  node.default[:apps] = { :video_pro => video_pro }

  include_recipe "video_pro::avidemux" if selected.include?("avidemux")
  include_recipe "video_pro::cinelerra" if selected.include?("cinelerra")
  # include_recipe "video_pro::shotcut" if selected.include?("shotcut")
end

