#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: kernel
# Recipe:: swappiness
#
# Copyright 2013-2016 Carles Muiños
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

# refs
#   https://sites.google.com/site/easylinuxtipsproject/first-xubuntu#TOC-Decrease-the-swap-use-very-important-

cookbook_file 'swappiness.conf' do
  path '/etc/sysctl.d/60-swappiness.conf'
  source '/sysctl.d/swappiness.conf'
  mode 0644
  backup false
end
