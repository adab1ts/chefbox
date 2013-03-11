#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: virtualization
# Library:: virtualization
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


require 'open-uri'

module Coderebels
  module Virtualization

    class VirtualBox
      def self.download_uri
        "http://download.virtualbox.org/virtualbox"
      end

      def self.fetch_extpack(vbox_pkg, &block)
        reader, writer = IO.pipe
        system("dpkg-query -W #{vbox_pkg} | awk '{print $2}'", [:err, :out] => writer)
        writer.close

        /(?<version>\d+.\d+.\d+)-(?<build>\d+)/ =~ reader.gets
        vbox_version = version
        vbox_build = build

        extpack_file = "Oracle_VM_VirtualBox_Extension_Pack-#{vbox_version}-#{vbox_build}.vbox-extpack"
        extpack_url  = "#{download_uri}/#{vbox_version}/#{extpack_file}"
        extpack_sha256 = ""

        sha256_url = "#{download_uri}/#{vbox_version}/SHA256SUMS"

        open(sha256_url).each do |line|
          extpack_sha256 = line.split(" ")[0] if line =~ /#{extpack_file}/
        end

        block.call(extpack_file, extpack_url, extpack_sha256)
      end
    end

  end
end

