#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: audio_pro
# Recipe:: transcribe
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


audio_pro = node[:apps][:audio_pro]
box = node[:box]

# World's leading software for helping musicians to work out music from recordings
transcribe = audio_pro['profiles']['transcribe']

if app_available? transcribe
  install_app "transcribe" do
    force true
    profile transcribe
  end

  launcher "transcribe" do
    template "/transcribe/transcribe.desktop.erb"
    variables(
      :exec => "sh -c '~/#{box[:folders][:apps]}/transcribe/transcribe'"
    )
  end

  uninstaller "transcribe" do
    template "/transcribe/uninstall_transcribe-#{box[:lang]}.sh.erb"
    variables(
      :app     => "transcribe",
      :website => audio_pro['profiles']['transcribe']['website']
    )
  end
end

