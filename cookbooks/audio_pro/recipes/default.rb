#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: audio_pro
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

# User interface for controlling the JACK sound server
package "qjackctl"


## Deploy

selected = node[:box][:apps][:audio_pro]

if selected
  audio_pro = data_bag_item('apps', 'audio_pro')
  apps = audio_pro['apps']

  # Uninstall apps not needed
  unselected = apps - selected

  uninstall_apps "audio_pro" do
    apps unselected
    profiles audio_pro['profiles']
  end

  # Install selected apps
  node.default[:apps] = { :audio_pro => audio_pro }

  include_recipe "audio_pro::ardour" if selected.include?("ardour")
  include_recipe "audio_pro::audacity" if selected.include?("audacity")
  include_recipe "audio_pro::guitarix" if selected.include?("guitarix")
  include_recipe "audio_pro::hydrogen" if selected.include?("hydrogen")
  include_recipe "audio_pro::idjc" if selected.include?("idjc")
  include_recipe "audio_pro::mixxx" if selected.include?("mixxx")
  include_recipe "audio_pro::muse" if selected.include?("muse")
  include_recipe "audio_pro::musescore" if selected.include?("musescore")
  include_recipe "audio_pro::rosegarden" if selected.include?("rosegarden")
  include_recipe "audio_pro::transcribe" if selected.include?("transcribe")
  include_recipe "audio_pro::traverso" if selected.include?("traverso")
  include_recipe "audio_pro::tuxguitar" if selected.include?("tuxguitar")
end

