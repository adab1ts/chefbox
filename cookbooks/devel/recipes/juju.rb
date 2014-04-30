#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Recipe:: juju
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


devel = node[:apps][:devel]

# next generation service orchestration system
juju = devel['profiles']['juju']

if app_available? juju
  install_app "juju" do
    force true
    profile devel['profiles']['juju']
  end

  devel_folder = node[:box][:devel][:folder]

  script = <<-EOH
    if [[ ! -f "${HOME}/.ssh/id_rsa" ]]; then
      ssh-keygen -b 2048 -t rsa -N "" -f "${HOME}/.ssh/id_rsa"
    fi
    EOH

  dev_folders = [
    ".juju",
    "#{devel_folder}/juju"
  ]

  dev_templates = [
    { :file => '.juju/environments.yaml', :vars => { :data_dir => 'juju' } }
  ]

  bootstrap "juju" do
    before script
    folders dev_folders
    templates dev_templates
    aliases true
  end
end

