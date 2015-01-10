#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: kernel
# Recipe:: intel_graphics
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

# refs:
#   http://askubuntu.com/questions/570888/download-01-org-certificate-verification-failed-crlfile-missing

kernel = node[:apps][:kernel]

# Intel graphics drivers update utility
intel_graphics = kernel['profiles']['intel_graphics']

if app_available? intel_graphics
  ## Requirements
  package 'wget'

  ## Deploy
  cache_path = Chef::Config[:file_cache_path]
  key_file   = 'RPM-GPG-KEY-ilg'
  key_file_2 = 'RPM-GPG-KEY-ilg-2'

  bash 'add_apt_keys' do
    cwd cache_path
    creates "#{cache_path}/#{key_file}"
    code <<-EOH
      wget --no-check-certificate https://download.01.org/gfx/#{key_file}
      apt-key add "#{cache_path}/#{key_file}"

      wget --no-check-certificate https://download.01.org/gfx/#{key_file_2}
      apt-key add "#{cache_path}/#{key_file_2}"

      echo -n | openssl s_client -connect download.01.org:443 | \
        sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' | \
        tee '/usr/local/share/ca-certificates/download_01_org.crt'
      update-ca-certificates
      EOH
  end

  install_app 'intel_graphics' do
    force true
    profile intel_graphics
  end
end
