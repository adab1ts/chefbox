#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: kernel
# Recipe:: swappiness
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


# See https://sites.google.com/site/easylinuxtipsproject/first-xubuntu#TOC-Decrease-the-swap-use-very-important-
sysctl_file = "/etc/sysctl.conf"

bash "change_swappiness" do
  code <<-EOH
    echo >> #{sysctl_file}
    echo >> #{sysctl_file}
    echo ########################################### >> #{sysctl_file}
    echo # Decrease swap usage to a reasonable level >> #{sysctl_file}
    echo vm.swappiness = 10 >> #{sysctl_file}
    echo # Improve cache management >> #{sysctl_file}
    echo vm.vfs_cache_pressure = 50 >> #{sysctl_file}
  EOH
end

