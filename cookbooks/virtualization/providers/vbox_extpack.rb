#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: virtualization
# Provider:: vbox_extpack
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

def whyrun_supported?
  true
end

def load_current_resource
  @current_resource = Chef::Resource::VirtualizationVboxExtpack.new(new_resource.name)
end

action :install do
  version = new_resource.version
  build   = new_resource.build

  unless version and build
    version, build = get_version new_resource.package
  end

  file, url, sha256 = extpack_for version, build
  cache_path = new_resource.run_context.node[:deploy][:resources_path]

  remote_file "#{cache_path}/#{file}" do
    source url
    checksum sha256
    notifies :run, "bash[install_vbox_extpack]", :immediately
  end

  bash "install_vbox_extpack" do
    code <<-EOH
      /usr/lib/virtualbox/VBoxExtPackHelperApp install \
      --base-dir '/usr/lib/virtualbox/ExtensionPacks' \
      --cert-dir '/usr/share/virtualbox/ExtPackCertificates' \
      --name 'Oracle VM VirtualBox Extension Pack' \
      --tarball '#{cache_path}/#{file}' \
      --sha-256 '#{sha256}'
    EOH
    action :nothing
  end
end

private

def get_version(vbox_pkg)
  reader, writer = IO.pipe
  system("dpkg-query -W #{vbox_pkg} | awk '{print $2}'", [:err, :out] => writer)
  writer.close

  /(?<version>\d+.\d+.\d+)-(?<build>\d+)/ =~ reader.gets

  [version, build]
end

def download_uri
  "http://download.virtualbox.org/virtualbox"
end

def extpack_for(version, build)
  require 'open-uri'

  file   = "Oracle_VM_VirtualBox_Extension_Pack-#{version}-#{build}.vbox-extpack"
  url    = "#{download_uri}/#{version}/#{file}"
  sha256 = ""

  sha256_url = "#{download_uri}/#{version}/SHA256SUMS"

  open(sha256_url).each do |line|
    sha256 = line.split(" ")[0] if line =~ /#{file}/
  end

  [file, url, sha256]
end

