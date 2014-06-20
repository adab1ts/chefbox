#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: eyecandy
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

selected = node[:box][:apps][:eyecandy]

if selected
  eyecandy = data_bag_item('apps', 'eyecandy')
  apps = eyecandy['apps']

  # Uninstall apps not needed
  unselected = apps - selected

  uninstall_apps "eyecandy" do
    apps unselected
    profiles eyecandy['profiles']
  end

  # Install selected apps
  node.default[:apps] = { :eyecandy => eyecandy }

  include_recipe "eyecandy::greeter-background" if selected.include?("greeter-background")
  include_recipe "eyecandy::faba-icons" if selected.include?("faba-icons")
  include_recipe "eyecandy::moka-icons" if selected.include?("moka-icons")
  include_recipe "eyecandy::moka-theme" if selected.include?("moka-theme")
  include_recipe "eyecandy::numix-circle-icons" if selected.include?("numix-circle-icons")
  include_recipe "eyecandy::numix-shine-icons" if selected.include?("numix-shine-icons")
  include_recipe "eyecandy::orchis-theme" if selected.include?("orchis-theme")

  if platform_desktop == "unity"
    include_recipe "eyecandy::unity-tweak" if selected.include?("unity-tweak")
  end
end

