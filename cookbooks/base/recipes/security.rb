#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: base
# Recipe:: security
#
# Copyright 2013, Carles Muiños
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


# Anti-virus utility for Unix
package "clamtk"
package "cabextract"
package "libclamunrar6"


# Program for managing a Netfilter firewall
package "gufw"

cookbook_file "/etc/ufw/applications.d/chef-openssh-server" do
  source "/ufw/chef-openssh-server"
  mode 0644
  backup false
end

bash "enable_firewall" do
  code <<-EOH
    ufw allow ChefSSH
    ufw enable
  EOH
  not_if { node[:first_run_completed] }
end

