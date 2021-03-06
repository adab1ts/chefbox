#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: video
# Recipe:: mvc
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


video = node[:apps][:video]

# Miro Video Converter
mvc = video['profiles']['mvc']

if app_available? mvc
  codename  = platform_codename
  repo_name = "mc3man-trusty-media"
  repo_uri  = "ppa:mc3man/trusty-media"

  core_ppa repo_name do
    uri repo_uri
    distribution codename
    action :add
  end

  install_app "mvc" do
    force true
    profile mvc
  end
end

