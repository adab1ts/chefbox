#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: indicators
# Recipe:: screensaver
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


indicators = node[:apps][:indicators]

# A status bar application able to temporarily prevent the activation
# of both the screensaver and the "sleep" powersaving mode
install_app "screensaver" do
  profile indicators['profiles']['screensaver']
end

autostart_app "screensaver" do
  profile indicators['profiles']['screensaver']
end

