#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: video_pro
# Recipe:: shotcut
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


video_pro = node[:apps][:video_pro]

# Shotcut is a free, open source, cross-platform video editor
shotcut = video_pro['profiles']['shotcut']

if available_app? shotcut
  install_app "shotcut" do
    force true
    profile shotcut
  end

  box = node[:box]

  launcher "shotcut" do
    template "/shotcut/shotcut.desktop.erb"
    variables(
      :exec => %{sh -c '~/#{box[:folders][:apps]}/shotcut/Shotcut.app/shotcut "%F"'}
    )
  end

  uninstaller "shotcut" do
    template "/shotcut/uninstall_shotcut-#{box[:lang]}.sh.erb"
    variables(
      :app     => "shotcut",
      :website => shotcut['website']
    )
  end
end

