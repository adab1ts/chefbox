#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: graphics_pro
# Recipe:: qcad
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


graphics_pro = node[:apps][:graphics_pro]
box = node[:box]

# The Open Source 2D CAD
install_app "qcad" do
  profile graphics_pro['profiles']['qcad']
end

launcher "qcad" do
  template "/qcad/qcad.desktop.erb"
  variables(
    :icon => "~/#{box['folders']['apps']}/qcad/qcad_icon.png",
    :exec => "sh -c '~/#{box['folders']['apps']}/qcad/qcad'"
  )
end

uninstaller "qcad" do
  template "/qcad/uninstall_qcad-#{box['lang']}.sh.erb"
  variables(
    :app     => "qcad",
    :website => graphics_pro['profiles']['qcad']['website']
  )
end

