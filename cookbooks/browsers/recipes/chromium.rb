#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: browsers
# Recipe:: chromium
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


browsers = node[:apps][:browsers]

# Chromium browser
install_app "chromium" do
  profile browsers['profiles']['chromium']
end

# Unity Web Apps install
if platform?("ubuntu") and platform_version == 12.04
  codename = platform_codename

  core_ppa "webapps-preview" do
    uri "ppa:webapps/preview"
    distribution codename
    action :add
  end

  package "unity-webapps-preview"
end

