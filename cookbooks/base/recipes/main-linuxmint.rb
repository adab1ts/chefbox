#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: base
# Recipe:: main-linuxmint
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


# Language support
package "language-pack-ca"
package "language-pack-gnome-ca"
package "aspell-ca"
package "myspell-ca"

package "language-pack-es"
package "language-pack-gnome-es"
package "aspell-es"
package "myspell-es"


# Virtualization support
unless virtual_box?
  %w[
    virtualbox-guest-dkms
    virtualbox-guest-utils
    virtualbox-guest-x11
  ].each do |pkg|
    package pkg do
      action :purge
    end
  end
end

