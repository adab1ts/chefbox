#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: indicators
# Recipe:: weather
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


indicators = node[:apps][:indicators]

# An indicator for weather
weather = indicators['profiles']['weather']

install_app "weather" do
  profile weather
end

autostart_app "weather" do
  profile weather
  desktop_file "#{weather['package']}-autostart.desktop"
end

support "weather" do
  section "indicators"
  only_for ["ubuntu"]
end

