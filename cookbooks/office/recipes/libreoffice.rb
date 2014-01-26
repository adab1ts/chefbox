#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: office
# Recipe:: libreoffice
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


box = node[:box]
office = node[:apps][:office]

# Office productivity suite
install_app "libreoffice" do
  profile office['profiles']['libreoffice']
end

package "libreoffice-l10n-ca"
package "libreoffice-l10n-es"
package "libreoffice-help-ca"
package "libreoffice-help-es"

if box['lang'] == 'ca'
  package "mythes-ca"
  package "hyphen-ca"
end

support "libreoffice" do
  section "office"
end

