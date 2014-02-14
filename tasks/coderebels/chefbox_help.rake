#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
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

require 'rubygems'
require 'json'


namespace :coderebels do

  desc "Show how to proceed to converge a new chefbox node"
  task :remindme do 
    puts "If you need help concerning any task: rake coderebels:help[taskname]"
    puts
    puts "*) Prepare your workspace the very first time:  rake coderebels:workspace[env]"
    puts
    puts "1) Pull and upload chefbox updates:   rake coderebels:chefbox_updt"
    puts "2) Switch to the target environment:  rake coderebels:switch_svr[env]"
    puts "3) For each node to bootstrap:"
    puts "   3.1) Bundle a bootstrap package:   rake coderebels:bundle[user,nodename,mtype]"
    puts "   3.2) Create a new node profile:    rake coderebels:node_profile[nodename,roles,recipes]"
    puts "   3.3) Bootstrap the node:           rake coderebels:bootstrap[user,nodename,ip,platform,arch]"
  end


  desc "Get help about task usage"
  task :help, [:taskname] do |t, args|
    raise "Must provide a task name" unless args.taskname

    output = case args.taskname
    when "workspace"
      <<-EOH
          TASK: workspace
          DESC: create your workspace for the target environment the very first time
                if you need to create another environment use make_env instead

          ARGS: env => name of the target environment

      EXAMPLES: rake coderebels:workspace[oop]
      EOH
    when "chefbox_updt"
      <<-EOH
          TASK: chefbox_updt
          DESC: fetch chefbox code from Github and merge into the master branch
                then upload changes to your chef server

          ARGS: none

      EXAMPLES: rake coderebels:chefbox_updt
      EOH
    when "switch_svr"
      <<-EOH
          TASK: switch_svr
          DESC: prepares your workspace for the target environment

          ARGS: env => name of the target environment

      EXAMPLES: rake coderebels:switch_svr[cof]
                rake coderebels:switch_svr[ldps]
                rake coderebels:switch_svr[oop]
      EOH
    when "bundle"
      <<-EOH
          TASK: bundle
          DESC: bundles a compressed bootstrap package to be delivered to the target box

          ARGS: user      => name of the default user of the target box
                nodename  => name of the target box
                mtype    *=> type of machine ([laptop] or pc)

      EXAMPLES: rake coderebels:bundle[dummy,OOP-0K001-laptop1]
                rake coderebels:bundle[dummy,OOP-0K001-pc1,pc]
      EOH
    when "node_profile"
      <<-EOH
          TASK: node_profile
          DESC: creates a profile for the target box that includes:
                - roles and recipes to apply
                - box info
                - apps to install

          ARGS: nodename  => name of the target box
                roles    *=> list of roles to apply to the target box ([average-box])
                recipes  *=> list of recipes to apply to the target box

      EXAMPLES: rake coderebels:node_profile[OOP-0K001-pc1]
                rake coderebels:node_profile[OOP-0K001-pc1,basic-box]
                rake coderebels:node_profile[OOP-0K001-pc1,starter-box:ubuntu-box]
                rake coderebels:node_profile[OOP-0K001-pc1,starter-box,graphics_pro]
                rake coderebels:node_profile[OOP-0K001-pc1,average-box:design-box,video_pro:vms]
      EOH
    when "bootstrap"
      <<-EOH
          TASK: bootstrap
          DESC: bootstraps the target box to become a new chef node

          ARGS: user      => name of the default user of the target box
                nodename  => name of the target box
                ip        => ip address of the target box
                platform *=> os platform (mint, [ubuntu], ...)
                arch     *=> processor arch ([i686] or x86_64)

      EXAMPLES: rake coderebels:bootstrap[dummy,OOP-0K001-pc1,192.168.1.195]
                rake coderebels:bootstrap[dummy,OOP-0K001-pc1,192.168.1.195,mint]
                rake coderebels:bootstrap[dummy,OOP-0K001-pc1,192.168.1.195,ubuntu,x86_64]
      EOH
    when "make_env"
      <<-EOH
          TASK: make_env
          DESC: make new directory structure for the target environment

          ARGS: env => name of the target environment

      EXAMPLES: rake coderebels:make_env[ldps]
      EOH
    when "remove_env"
      <<-EOH
          TASK: remove_env
          DESC: remove environment directory structure

          ARGS: env => name of the target environment

      EXAMPLES: rake coderebels:remove_env[ldps]
      EOH
    else
     "No info available"
    end

    puts output
  end


  desc "Get info about specified application"
  task :info, [:appname] do |t, args|
    raise "Must provide an app name" unless args.appname

    app = args.appname.downcase

    cmd = Mixlib::ShellOut.new("grep", "-ERwle", app, File.join(TOPDIR, "data_bags", "apps"))
    cmd.run_command

    file = cmd.stdout.chomp

    unless file.empty?
      data    = JSON.parse(IO.read file)
      profile = data["profiles"]["#{app}"]

      if profile
        output = <<-EOH
             APP: #{profile["package"]}
            DESC: #{profile["description"]}
         WEBSITE: #{profile["website"]}
        EOH
        puts output
      else
        puts "No profile data found for app '#{args.appname}'. Check the app name or"
        puts "review data file '#{file}'"
      end
    else
      puts "No info available for app '#{args.appname}'"
    end
  end

end

