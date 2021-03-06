#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: core
# Library:: monkey_patches
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


class Numeric
  @@units = { 'kB' => 1, 'MB' => 2**10, 'GB' => 2**20 }

  def method_missing(method_id, *args)
    unit = method_id.to_s

    if @@units.has_key? unit
      self * @@units[unit]
    else
      super
    end
  end
end

