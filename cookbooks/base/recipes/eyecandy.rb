#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: base
# Recipe:: eyecandy
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


eyecandy = data_bag_item('apps', 'eyecandy')

# Graphical configuration program for the Unity desktop environment
install_app "unsettings" do
  profile eyecandy['profiles']['unsettings']
end

# NITRUX-like icon theme
install_app "nitrux-icons" do
  profile eyecandy['profiles']['nitrux-icons']
end

