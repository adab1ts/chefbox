#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: base
# Recipe:: main
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


box = node[:box]

# Ubuntu example content
package "example-content" do
  action :purge
end

execute "remove_example_content_file" do
  command "rm #{box['home']}/examples.desktop"
  only_if { ::File.exists? "#{box['home']}/examples.desktop" }
end

# Dynamic Kernel Module Support Framework
package "dkms"

# Adaptive readahead daemon
package "preload"

# NX client for QT
package "qtnx"

# 7z and 7za file archivers with high compression ratio
package "p7zip-full"

# Nautilus plugins
package "nautilus-filename-repairer"
package "nautilus-gtkhash"
package "nautilus-open-terminal"

