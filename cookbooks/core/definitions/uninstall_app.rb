#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: core
# Definitions:: uninstall_app
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


define :uninstall_app do
  profile = params[:profile]

  source = profile['source']
  origin = source['type']

  case origin
  when "bin"
    box = node[:box]

    box[:users].each do |username, usr|
      app_dir  = "#{usr[:home]}/#{box[:folders][:apps]}/#{params[:name]}"
      launcher = "#{usr[:home]}/.local/share/applications/#{params[:name]}.desktop"

      bash "#{username}_#{params[:name]}_uninstall" do
        code <<-EOH
          rm -rf #{app_dir} \
          && rm -f #{launcher}
          EOH
        only_if { ::File.exists?(app_dir) }
      end
    end
  else
    package params[:name] do
      package_name profile['package']
      action :purge
      not_if do
        %w(repo ppa).include?(origin) and
        not ::File.exists?("#{node[:apt][:sources_path]}/#{source['data']['repo_name']}-#{Coderebels::Chefbox::Box.lsb_codename}.list")
      end
    end
  end
end

