#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: music
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
music = data_bag_item('apps', 'music')

# Uninstall apps not needed

apps = music['apps']
selected = box['apps']['music']
unselected = apps - selected

uninstall_apps "music" do
  apps unselected
  profiles music['profiles']
end

# Install selected apps

node.set[:apps] = { :music => music }

include_recipe "music::lastfm" if selected.include?("lastfm")
include_recipe "music::nuvola" if selected.include?("nuvola")
include_recipe "music::rdio" if selected.include?("rdio")
include_recipe "music::rhythmbox" if selected.include?("rhythmbox")
include_recipe "music::spotify" if selected.include?("spotify")
include_recipe "music::tomahawk" if selected.include?("tomahawk")

