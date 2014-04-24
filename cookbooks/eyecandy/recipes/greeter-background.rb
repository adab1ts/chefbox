#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: eyecandy
# Recipe:: greeter-background
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


# Requirements
package "wget"

# Greeter Background
greeter = node[:box][:greeter]

if greeter
  author = greeter[:author]
  image  = greeter[:background]
  resolution = greeter[:resolution]

  backgrounds = data_bag_item('backgrounds', author)
  background  = backgrounds[image][resolution]

  remote_file "unity_greeter_background" do
    path "#{node[:eyecandy][:backgrounds_dir]}/#{image}.jpg"
    source background['url']
    checksum background['sha256']
    backup false
  end

  case platform
  when "ubuntu"
    cookbook_file "unity_greeter_background_gschema" do
      path "/usr/share/glib-2.0/schemas/10_unity_greeter_background.gschema.override"
      source "/gschemas/unity_greeter_background.gschema.override"
      mode 0644
      backup false
    end

    execute "greeter-background-apply" do
      command "glib-compile-schemas /usr/share/glib-2.0/schemas/"
      action :nothing
      subscribes :run, resources("cookbook_file[unity_greeter_background]"), :immediately
    end
  end
end

