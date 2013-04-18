#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: core
# Library:: box
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


module Coderebels
  module Chefbox
    module Box

      DEVCLASS = { :graphics => "0300" }
      VENDORS  = { "8086" => "intel" }

      def memory
        /(?<mem>\d+)kB/ =~ node[:memory][:total]
        mem.to_i
      end

      def device(category)
        cmd = case category
              when :graphics
                "lspci -n | grep #{DEVCLASS[category]} | awk '{ print $3 }'"
              end
        dev = Coderebels::Chefbox::Shell.rep cmd
        dev.split(":")
      end

      def vendor(category)
        ven, prod = device category
        VENDORS[ven]
      end

      def arch
        Coderebels::Chefbox::Shell.rep "uname -i"
      end

      def platform_version
        node[:platform_version].to_f
      end

    end
  end
end
