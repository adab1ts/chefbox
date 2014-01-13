#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: audio
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


## Requirements

include_recipe "base"


## Deploy

box = node[:box]
selected = box['apps']['audio']

if selected
  audio = data_bag_item('apps', 'audio')
  apps  = audio['apps']

  # Uninstall apps not needed
  unselected = apps - selected

  uninstall_apps "audio" do
    apps unselected
    profiles audio['profiles']
  end

  # Install selected apps
  node.set[:apps] = { :audio => audio }

  include_recipe "audio::lastfm" if selected.include?("lastfm")
  include_recipe "audio::nuvola" if selected.include?("nuvola")
  include_recipe "audio::rdio" if selected.include?("rdio")
  include_recipe "audio::rhythmbox" if selected.include?("rhythmbox")
  include_recipe "audio::spotify" if selected.include?("spotify")
  include_recipe "audio::tomahawk" if selected.include?("tomahawk")
end

