#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: lenses
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
lenses = data_bag_item('apps', 'lenses')

# Uninstall apps not needed

apps = lenses['apps']
selected = box['apps']['lenses']
unselected = apps - selected

uninstall_apps "lenses" do
  apps unselected
  profiles lenses['profiles']
end

# Install selected apps

node.set[:apps] = { :lenses => lenses }

include_recipe "lenses::academic" if selected.include?("academic")
include_recipe "lenses::dictionary" if selected.include?("dictionary")
include_recipe "lenses::music" if selected.include?("music")
include_recipe "lenses::news" if selected.include?("news")
include_recipe "lenses::torrents" if selected.include?("torrents")
include_recipe "lenses::translator" if selected.include?("translator")
include_recipe "lenses::utilities" if selected.include?("utilities")
include_recipe "lenses::video" if selected.include?("video")
include_recipe "lenses::wikipedia" if selected.include?("wikipedia")
