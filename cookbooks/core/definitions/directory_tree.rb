#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: core
# Definitions:: directory_tree
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


define :directory_tree, :owner => "root", :group => "root", :mode => 00755, :exclude => "" do
  unless params[:name].start_with? params[:exclude]
    Chef::Application.fatal!('Invalid exclude argument')
  end

  tree = params[:name].scan(/[^\/]+/)
  base = params[:exclude].scan(/[^\/]+/)

  n = base.size
  m = tree.size

  (n+1..m).each do |i|
    dir = "/" + tree.take(i).join("/")

    directory dir do
      owner params[:owner]
      group params[:group]
      mode params[:mode]
    end
  end
end

