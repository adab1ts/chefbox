#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Recipe:: processing
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
#   https://github.com/processing/processing/wiki/Supported-Platforms

devel = node[:apps][:devel]

# Open source creative programming language
processing = devel['profiles']['processing']

if app_available? processing
  install_app 'processing' do
    force true
    profile processing
  end

  box = node[:box]

  bin_folder = box[:devel][:bin_folder]
  projects_folder = box[:devel][:folder]
  processing_folder = "#{box[:folders][:apps]}/processing"

  bootstrap 'processing' do
    folders ["#{projects_folder}/processing"]
    links [{ from: "#{bin_folder}/processing", to: "#{processing_folder}/processing" }]
  end

  launcher 'processing' do
    template '/processing/processing.desktop.erb'
    variables(
      exec: "sh -c '~/#{processing_folder}/processing'"
    )
  end

  uninstaller 'processing' do
    template "/processing/uninstall_processing-#{box[:lang]}.sh.erb"
    variables(
      app: 'processing',
      website: processing['website'],
      bin_folder: bin_folder
    )
  end
end
