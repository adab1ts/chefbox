#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: video_pro
# Recipe:: obs-studio
#
# Copyright 2013-2015 Carles Muiños
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

# refs:
#   https://obsproject.com/
#   https://github.com/jp9000/obs-studio/blob/master/INSTALL

video_pro = node[:apps][:video_pro]

# OBS Studio streaming software
obs_studio = video_pro['profiles']['obs-studio']

if app_available? obs_studio
  codename  = platform_codename
  repo_name = 'jon-severinsson-ffmpeg'
  repo_uri  = 'ppa:jon-severinsson/ffmpeg'

  core_ppa repo_name do
    uri repo_uri
    distribution codename
    action :add
  end

  install_app 'obs-studio' do
    force true
    profile obs_studio
  end
end
