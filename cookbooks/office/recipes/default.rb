#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: office
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
selected = box['apps']['office']

if selected
  office = data_bag_item('apps', 'office')
  apps   = office['apps']

  # Uninstall apps not needed
  unselected = apps - selected

  uninstall_apps "office" do
    apps unselected
    profiles office['profiles']
  end

  # Install selected apps
  node.set[:apps] = { :office => office }

  include_recipe "office::msttfonts"
  include_recipe "office::fontmanager" if selected.include?("fontmanager")
  include_recipe "office::libreoffice" if selected.include?("libreoffice")
  include_recipe "office::masterpdf" if selected.include?("masterpdf")
  include_recipe "office::nitro" if selected.include?("nitro")
  include_recipe "office::pdfshuffler" if selected.include?("pdfshuffler")
  # include_recipe "office::springseed" if selected.include?("springseed")
  include_recipe "office::taskcoach" if selected.include?("taskcoach")
end

