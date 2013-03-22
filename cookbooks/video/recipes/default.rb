#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: video
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


## Requirements

include_recipe "base"


## Deploy

box = node[:box]
video = data_bag_item('apps', 'video')

# Uninstall apps not needed

apps = video['apps']
selected = box['apps']['video']
unselected = apps - selected

uninstall_apps "video" do
  apps unselected
  profiles video['profiles']
end

# Install selected apps

node.set[:apps] = { :video => video }

include_recipe "video::openshot" if selected.include?("openshot")
include_recipe "video::vlc" if selected.include?("vlc")

