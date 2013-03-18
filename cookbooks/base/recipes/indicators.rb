#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: base
# Recipe:: indicators
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


indicators = data_bag_item('apps', 'indicators')

# Display notifications about newly plugged hardware
plugandplay = indicators['profiles']['plug&play']
source = plugandplay['source']['data']

apt_repository "#{source['repo_name']}-#{node[:lsb][:codename]}" do
  uri source['uri']
  distribution ""
  components source['components']
  key source['key']
  action :add
end

package plugandplay['package']

autostart_app "plug&play" do
  profile plugandplay
end

# A status bar application able to temporarily prevent the activation
# of both the screensaver and the "sleep" powersaving mode
install_app "screensaver" do
  profile indicators['profiles']['screensaver']
end

autostart_app "screensaver" do
  profile indicators['profiles']['screensaver']
end

# Indicator for Ubuntu One synchronization service
if node[:platform_version] == "12.04"
  install_app "ubuntuone" do
    profile indicators['profiles']['ubuntuone']
  end
end

