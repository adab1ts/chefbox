#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: vms
# Resource:: vbox_extpack
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

actions :install

attribute :package, :kind_of => String, :name_attribute => true
attribute :version, :kind_of => String, :default => nil
attribute :build, :kind_of => String, :default => nil

default_action :install

