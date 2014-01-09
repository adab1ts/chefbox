#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: core
# Library:: shell
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


module Coderebels
  module Chefbox
    module Shell

      def self.rep(cmd)
        reader, writer = IO.pipe
        system(cmd, [:err, :out] => writer)
        reader.gets.chomp
      end

    end
  end
end

