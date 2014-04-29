#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: core
# Library:: app
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
    module App

      def app_available?(profile)
        Coderebels::Chefbox::App.available? profile
      end

      def app_package_name(profile)
        Coderebels::Chefbox::App.package_name profile
      end

      def self.available?(profile, os=nil, release=nil)
        os       = Coderebels::Chefbox::Box.lsb_id unless os
        release  = Coderebels::Chefbox::Box.lsb_release unless release
        platform = "#{os}-#{release}"

        !!profile['platforms'][platform]
      end

      def self.default?(profile, os=nil, release=nil)
        os       = Coderebels::Chefbox::Box.lsb_id unless os
        release  = Coderebels::Chefbox::Box.lsb_release unless release
        platform = "#{os}-#{release}"

        profile['platforms'][platform]['default']
      end

      def self.package_name(profile, os=nil, release=nil)
        os        = Coderebels::Chefbox::Box.lsb_id unless os
        release   = Coderebels::Chefbox::Box.lsb_release unless release
        platform  = "#{os}-#{release}"

        source_id = profile['platforms'][platform]['source']
        profile['sources'][source_id]['package']
      end

      def self.source(profile, os=nil, release=nil)
        os       = Coderebels::Chefbox::Box.lsb_id unless os
        release  = Coderebels::Chefbox::Box.lsb_release unless release
        platform = "#{os}-#{release}"

        source_id   = profile['platforms'][platform]['source']
        source_data = profile['sources'][source_id]
        [source_id, source_data]
      end

    end
  end
end

