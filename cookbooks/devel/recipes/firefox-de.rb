#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Recipe:: firefox-de
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
#   https://www.mozilla.org/en-US/firefox/developer/

devel = node[:apps][:devel]

# Firefox Developer Edition
firefox = devel['profiles']['firefox-de']

if app_available? firefox
  install_app "firefox" do
    force true
    profile firefox
  end

  box = node[:box]

  bin_folder = box[:devel][:bin_folder]
  firefox_folder = "#{box[:folders][:apps]}/firefox"

  bootstrap "firefox" do
    links [{ :from => "#{bin_folder}/firefox", :to => "#{firefox_folder}/firefox" }]
  end

  launcher "firefox" do
    template "/firefox/firefox.desktop.erb"
    variables(
      :exec => "firefox %u"
    )
  end

  uninstaller "firefox" do
    template "/firefox/uninstall_firefox-#{box[:lang]}.sh.erb"
    variables(
      :app     => "firefox",
      :website => firefox['website'],
      :bin_folder => bin_folder
    )
  end
end

