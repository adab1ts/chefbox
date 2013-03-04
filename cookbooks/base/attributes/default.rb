#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: base
# Attributes:: default
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

# default[:base][:apt_path] = File.expand_path('../../files/default/apt', __FILE__)
default[:base][:uid]          = 1000
default[:base][:gid]          = 1000
default[:base][:fonts_url]    = "http://ubuntuone.com/6QmipqSO7F5OXSwhDPOs4J"
default[:base][:fonts_sha256] = "34afc268300fe5b863ddd6cde973aba3a87d7512ae92e37e4de891a49faa3465"

