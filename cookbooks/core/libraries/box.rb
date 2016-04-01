#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: core
# Library:: box
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

      def platform
        Coderebels::Chefbox::Box.lsb_id
      end

      def platform_version
        Coderebels::Chefbox::Box.lsb_release
      end

      def platform_codename
        Coderebels::Chefbox::Box.lsb_codename
      end

      def platform_arch
        Coderebels::Chefbox::Box.arch
      end

      def platform_desktop
        node[:box][:platform][:desktop]
      end

      def virtual_box?
        node[:box][:platform][:virtual]
      end

      def self.lsb_id
        id_str = Coderebels::Chefbox::Shell.rep "lsb_release -i"

        case id_str
        when /debian/i then "debian"
        when /mint/i   then "linuxmint"
        when /ubuntu/i then "ubuntu"
        end
      end

      def self.lsb_release
        /Release:\s+(?<release>[\d.]+)/i =~ Coderebels::Chefbox::Shell.rep("lsb_release -r")
        release.to_f
      end

      def self.lsb_codename
        case self.lsb_id
        when "debian", "ubuntu"
          /Codename:\s+(?<codename>\w+)/i =~ Coderebels::Chefbox::Shell.rep("lsb_release -c")
          codename
        when "linuxmint"
          case self.lsb_release
          when 13 then "precise"
          when 14 then "quantal"
          when 15 then "raring"
          when 16 then "saucy"
          when 17, 17.1, 17.2, 17.3 then "trusty"
          end
        end
      end

      def self.arch
        Coderebels::Chefbox::Shell.rep "uname -m"
      end

    end
  end
end
