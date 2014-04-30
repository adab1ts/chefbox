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
    puts "*) Prepare your workspace the very first time:  rake coderebels:workspace[env,email,domain]"
    puts
    puts "1) Switch to the target environment:  rake coderebels:switch_env[env,ip]"
    puts "2) Setup the owncloud server:         rake coderebels:setup_ocs[ip]"
    puts "3) Pull and upload chefbox updates:   rake coderebels:chefbox_updt"
    puts "4) For each node to bootstrap:"
    puts "   4.1) Create a new node profile:    rake coderebels:create_profile[nodename,roles,recipes]"
    puts "   4.2) Bundle a bootstrap package:   rake coderebels:bundle[user,nodename,mtype]"
    puts "   4.3) Bootstrap the node:           rake coderebels:bootstrap[user,nodename,ip,platform,arch]"
  end


  desc "Get help about task usage"
  task :help, [:taskname] do |t, args|
    args.with_defaults(:taskname => "all")

    output = case args.taskname
    when "all"
      <<-EOH
         USAGE: rake coderebels:help[taskname]

                taskname = { workspace | setup_env | remove_env | switch_env | setup_ocs |
                             chefbox_updt | create_profile | edit_profile | update_profile |
                             bundle | bootstrap | info }
      EOH
    when "workspace"
      <<-EOH
          TASK: workspace
          DESC: creates your workspace for the target environment the very first time
                if you need to create another environment use setup_env instead

          ARGS: env     => name of the target environment
                email   => email address of the recipient of chef-client run reports
                domain *=> domain name of the target environment chef server ([coderebels.org])

      EXAMPLES: rake coderebels:workspace[cof,you@example.com]
                rake coderebels:workspace[oop,no-reply@oop-coop.cc,oop-coop.cc]
      EOH
    when "setup_env"
      <<-EOH
          TASK: setup_env
          DESC: sets up the target environment
                if you want to change the current environment setup,
                switch to another environment first

          ARGS: env     => name of the target environment
                email   => email address of the recipient of chef-client run reports
                domain *=> domain name of the target environment chef server ([coderebels.org])

      EXAMPLES: rake coderebels:make_env[cof,you@example.com]
                rake coderebels:make_env[dps,no-reply@ladispersa.net,ladispersa.net]
      EOH
    when "remove_env"
      <<-EOH
          TASK: remove_env
          DESC: removes environment directory structure and related files

          ARGS: env => name of the target environment

      EXAMPLES: rake coderebels:remove_env[dps]
      EOH
    when "switch_env"
      <<-EOH
          TASK: switch_env
          DESC: prepares your workspace for the target environment

          ARGS: env => name of the target environment
                ip  => ip address of the target environment chef server

      EXAMPLES: rake coderebels:switch_env[oop,192.168.0.100]
      EOH
    when "setup_ocs"
      <<-EOH
          TASK: setup_ocs
          DESC: acknowledges the owncloud server ip address, alias and domain

          ARGS: ip      => ip address of the owncloud server
                alias  *=> alias of the owncloud server ([ocserver])
                domain *=> domain name of the owncloud server ([coderebels.org])

      EXAMPLES: rake coderebels:setup_ocs[192.168.0.100]
                rake coderebels:setup_ocs[192.168.0.100,your-ocserver]
                rake coderebels:setup_ocs[192.168.0.100,ocserver,oop-coop.cc]
      EOH
    when "chefbox_updt"
      <<-EOH
          TASK: chefbox_updt
          DESC: fetch chefbox code from Github and merge into the master branch
                then upload changes to your current environment chef server

          ARGS: none

      EXAMPLES: rake coderebels:chefbox_updt
      EOH
    when "create_profile"
      <<-EOH
          TASK: create_profile
          DESC: creates a profile for the target node that includes:
                - roles and recipes to apply
                - box info
                - apps to install

          ARGS: nodename  => name of the target node
                roles    *=> list of roles to apply to the target node ([average-box])
                recipes  *=> list of recipes to apply to the target node

      EXAMPLES: rake coderebels:create_profile[OOP-0K001-pc1]
                rake coderebels:create_profile[OOP-0K001-pc1,basic-box]
                rake coderebels:create_profile[OOP-0K001-pc1,starter-box:ubuntu-box]
                rake coderebels:create_profile[OOP-0K001-pc1,starter-box,graphics_pro]
                rake coderebels:create_profile[OOP-0K001-pc1,average-box:design-box,video_pro:vms]
      EOH
    when "edit_profile"
      <<-EOH
          TASK: edit_profile
          DESC: opens the target node profile in a text editor

          ARGS: nodename => name of the target node

      EXAMPLES: rake coderebels:edit_profile[OOP-0K001-pc1]
      EOH
    when "update_profile"
      <<-EOH
          TASK: update_profile
          DESC: uploads the target node profile to the environment chef server

          ARGS: nodename => name of the target node

      EXAMPLES: rake coderebels:update_profile[OOP-0K001-pc1]
      EOH
    when "bundle"
      <<-EOH
          TASK: bundle
          DESC: bundles a compressed bootstrap package to be delivered to the target node

          ARGS: user      => name of the default user of the target node
                nodename  => name of the target node
                mtype    *=> type of machine ([laptop], pc or vm)

      EXAMPLES: rake coderebels:bundle[dummy,OOP-0K001-laptop1]
                rake coderebels:bundle[dummy,OOP-0K001-pc1,pc]
      EOH
    when "bootstrap"
      <<-EOH
          TASK: bootstrap
          DESC: bootstraps the target box to become a new chef node

          ARGS: user      => name of the default user of the target node
                nodename  => name of the target node
                ip        => ip address of the target node
                platform *=> os platform (linuxmint, [ubuntu], ...)
                arch     *=> processor arch ([i686] or x86_64)

      EXAMPLES: rake coderebels:bootstrap[dummy,OOP-0K001-pc1,192.168.1.195]
                rake coderebels:bootstrap[dummy,OOP-0K001-pc1,192.168.1.195,linuxmint]
                rake coderebels:bootstrap[dummy,OOP-0K001-pc1,192.168.1.195,ubuntu,x86_64]
      EOH
    when "info"
      <<-EOH
          TASK: info
          DESC: provides info about specified application

          ARGS: appname => name of the application

      EXAMPLES: rake coderebels:info[linuxband]
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
             APP: #{app}
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

