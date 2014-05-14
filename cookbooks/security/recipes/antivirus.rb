#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: security
# Recipe:: antivirus
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


security = node[:apps][:security]

# Anti-virus utility for Unix
antivirus = security['profiles']['antivirus']

if app_available? antivirus
  install_app "antivirus" do
    force true
    profile antivirus
  end

  deb = case platform_desktop
        when "cinnamon" then {
          'package'   => "nemo-sendto-clamtk",
          'file_name' => "nemo-sendto-clamtk_0.02-1_all.deb",
          'uri'       => "https://ocserver/public.php?service=files&t=997eddadc89f1636026a0fdf7847352e&download",
          'sha256'    => "fd31b7299ad26932d5e75dbd9759ea7312f0f60b95eeca12074b7806d84afbb3"
        }
        when "xfce" then {
          'package'   => "thunar-sendto-clamtk",
          'file_name' => "thunar-sendto-clamtk_0.05-1_all.deb",
          'uri'       => "https://ocserver/public.php?service=files&t=51861c8480f008665b423f62da60f91d&download",
          'sha256'    => "b935066cbc03e5ab5d8702b233ccfa492d349fc52ab6d06aca3e486b0719982f"
        }
        else nil
        end

  if deb
    deb_file = "#{Chef::Config[:file_cache_path]}/#{deb['file_name']}"

    remote_file deb_file do
      source deb['uri']
      checksum deb['sha256']
    end

    package deb['package'] do
      source deb_file
      provider Chef::Provider::Package::Dpkg
    end
  end
end

