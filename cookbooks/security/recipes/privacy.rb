#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: security
# Recipe:: privacy
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


case platform
when "ubuntu"
  case platform_desktop
  when "unity"
    package "nautilus-gtkhash"
    package "nautilus-wipe"
    package "seahorse-nautilus"
  when "xfce"
    package "thunar-gtkhash"
    package "seahorse"
  end
when "linuxmint"
  package "gtkhash"
  package "secure-delete"
  package "nemo-seahorse" if platform_desktop == "cinnamon"
end

