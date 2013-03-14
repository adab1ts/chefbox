#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: graphics
# Recipe:: gimp
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


graphics = node[:apps][:graphics]
gimp = graphics['profiles']['gimp']


## PPA Addition

gimp_ppa = gimp['source']['data']

core_ppa gimp_ppa['repo_name'] do
  uri gimp_ppa['uri']
  distribution node[:lsb][:codename]
  action :add
end


## Deploy

# The GNU Image Manipulation Program
package gimp['package']

# Suggested packages
gimp['suggested'].each do |pkg|
  package pkg
end

