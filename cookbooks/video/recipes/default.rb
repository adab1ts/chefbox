#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: video
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

selected = node[:box][:apps][:video]

if selected
  video = data_bag_item('apps', 'video')
  apps  = video['apps']

  # Uninstall apps not needed
  unselected = apps - selected

  uninstall_apps "video" do
    apps unselected
    profiles video['profiles']
  end

  # Install selected apps
  node.default[:apps] = { :video => video }

  include_recipe "video::bombonodvd" if selected.include?("bombonodvd")
  include_recipe "video::dvdstyler" if selected.include?("dvdstyler")
  include_recipe "video::handbrake" if selected.include?("handbrake")
  include_recipe "video::miro" if selected.include?("miro")
  include_recipe "video::mmc" if selected.include?("mmc")
  include_recipe "video::mvc" if selected.include?("mvc")
  include_recipe "video::ogmrip" if selected.include?("ogmrip")
  include_recipe "video::openshot" if selected.include?("openshot")
  include_recipe "video::recmydesk" if selected.include?("recmydesk")
  include_recipe "video::ssr" if selected.include?("ssr")
  include_recipe "video::vlc" if selected.include?("vlc")
end

