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


namespace :coderebels do

  def current_env
    IO.read(File.join(TOPDIR, ".environment")).chomp
  end


  desc "Pull chefbox code from Github and upload to chef server"
  task :chefbox_updt do
    FileUtils.cd(TOPDIR) do
      sh %{git checkout master}
      sh %{git pull}

      FileList["roles/common/*"].each { |role| sh %{knife role from file #{role}} }
      FileList["data_bags/apps/*"].each { |dbi| sh %{knife data bag from file apps #{File.basename(dbi)}} }
      FileList["data_bags/global/*"].each { |dbi| sh %{knife data bag from file global #{File.basename(dbi)}} }
      FileList["data_bags/resources/*"].each { |dbi| sh %{knife data bag from file resources #{File.basename(dbi)}} }
      sh %{knife cookbook upload -a}
    end
  end


  desc "Generate openssl key for encrypted data bags management"
  task :edb_keygen do
    keys_dir = File.join(TOPDIR, "keys")
    edb_file = File.join(keys_dir, "edb")

    unless File.exists? edb_file
      FileUtils.mkdir_p keys_dir unless File.exists? keys_dir
      sh %{openssl rand -base64 512 | tr -d '\\r\\n' > #{edb_file}}
    end
  end


  desc "Make environment directory structure"
  task :make_env, [:env] do |t, args|
    raise "Must provide an environment name" unless args.env

    env_dir       = File.join(TOPDIR, ".chef-#{args.env}")
    env_keys_dir  = File.join(TOPDIR, "keys", args.env)
    env_roles_dir = File.join(TOPDIR, "roles", args.env)
    
    FileUtils.mkdir env_dir unless File.exists? env_dir
    FileUtils.mkdir_p env_keys_dir unless File.exists? env_keys_dir
    FileUtils.mkdir_p env_roles_dir unless File.exists? env_roles_dir
  end


  desc "Remove environment directory structure"
  task :remove_env, [:env] do |t, args|
    raise "Must provide an environment name" unless args.env

    env_dir       = File.join(TOPDIR, ".chef-#{args.env}")
    env_keys_dir  = File.join(TOPDIR, "keys", args.env)
    env_roles_dir = File.join(TOPDIR, "roles", args.env)
    
    FileUtils.rm_rf env_dir if File.exists? env_dir
    FileUtils.rm_rf env_keys_dir if File.exists? env_keys_dir
    FileUtils.rm_rf env_roles_dir if File.exists? env_roles_dir
  end


  desc "Prepare your chefbox workspace"
  task :workspace, [:env] => [:edb_keygen, :make_env] do |t, args|
    raise "Must provide the default environment for your workspace" unless args.env

    keys_dir = File.join(TOPDIR, "keys")
    bootstrap_keys_dir = File.join(TOPDIR, "bootstrap", "keys")

    unless File.exists? bootstrap_keys_dir
      FileUtils.mkdir_p bootstrap_keys_dir
      FileUtils.cp File.join(keys_dir, "edb"), File.join(bootstrap_keys_dir, "edb")
    end

    chef_dir = File.join(TOPDIR, ".chef")
    env_dir  = File.join(TOPDIR, ".chef-#{args.env}")
    env_file = File.join(TOPDIR, ".environment")

    unless File.exists? env_file
      File.open(env_file, "w") { |file| file.puts args.env }
      FileUtils.mv env_dir, chef_dir
    end
  end


  desc "Generate authentication keys to establish a ssh connection with a box"
  task :ssh_keygen, [:user, :nodename] do |t, args|
    raise "Must provide a user and a nodename" unless (args.user and args.nodename)

    user     = args.user
    nodename = args.nodename
    keys_dir = File.join(TOPDIR, "keys", current_env, "#{user}@#{nodename}")

    unless File.exists? keys_dir
      FileUtils.mkdir_p keys_dir
      sh %{ssh-keygen -b 2048 -t rsa -N "" -C "Chef: ssh key for #{user}@#{nodename}" -f #{File.join(keys_dir, "#{user}@#{nodename}")}}
    end
  end


  desc "Establish a ssh connection with specified box"
  task :ssh, [:user, :nodename, :ip, :cmd] do |t, args|
    raise "Must provide a user, a nodename and an IP address" unless (args.user and args.nodename and args.ip)

    user     = args.user
    nodename = args.nodename
    ip       = args.ip
    port     = 2222
    cmd      = args.cmd
    key_file = File.join(TOPDIR, "keys", current_env, "#{user}@#{nodename}", "#{user}@#{nodename}")

    sh %{ssh -p #{port} -i #{key_file} #{user}@#{ip} "#{cmd}"}
  end


  desc "Switch to environment chef server"
  task :switch_svr, [:env] do |t, args|
    raise "Must provide an environment" unless args.env

    chef_dir = File.join(TOPDIR, ".chef")
    env_dir  = File.join(TOPDIR, ".chef-#{args.env}")
    env_file = File.join(TOPDIR, ".environment")
    current  = current_env

    if args.env =~ /#{current}/i
      puts "Current environment: #{current}"
    else
      if File.exists? env_dir
        FileUtils.mv chef_dir, File.join(TOPDIR, ".chef-#{current}")
        FileUtils.mv env_dir, chef_dir
        system("sed", "-i", "1s:#{current}:#{args.env}:g", env_file)

        puts "Current environment: #{current_env}"
      else
        puts "The environment '#{args.env}' does not exist."
        puts "Create it first with 'rake coderebels:make_env[#{args.env}]'"
      end
    end
  end


  desc "Bundle a bootstrap package for specified box"
  task :bundle, [:user, :nodename, :mtype] => :ssh_keygen do |t, args|
    args.with_defaults(:mtype => "laptop")
    raise "Must provide a user and a nodename" unless (args.user and args.nodename)
    raise "Allowed values for mtype are: laptop, pc" if (args.mtype and not %w[laptop pc].include? args.mtype)

    user     = args.user
    nodename = args.nodename
    mtype    = args.mtype

    bootstrap_file = File.join(ENV['HOME'], "#{user}@#{nodename}.tar.gz")

    unless File.exists? bootstrap_file
      bootstrap_dir = File.join(TOPDIR, "bootstrap")
      target_dir    = File.join(ENV['HOME'], "bootstrap")
      FileUtils.cp_r bootstrap_dir, target_dir

      iface = mtype == "laptop" ? "wlan" : "eth"

      FileList["#{target_dir}/*.sh"].each do |target_file|
        File.open(target_file, "w") do |file|
          content = IO.read("#{bootstrap_dir}/#{File.basename(file)}").
                      gsub(/@@CHEF_REPORT_RECIPIENT@@/, ENV['CHEF_REPORT_RECIPIENT']).
                      gsub(/@@CHEF_SVR_ALIAS@@/, ENV['CHEF_SVR_ALIAS']).
                      gsub(/@@CHEF_SVR_FQDN@@/, ENV['CHEF_SVR_FQDN']).
                      gsub(/@@CHEF_SVR_IP@@/, ENV['CHEF_SVR_IP']).
                      gsub(/@@IFACE@@/, iface)
          file.puts content
        end
      end

      keys_dir = File.join(TOPDIR, "keys", current_env, "#{user}@#{nodename}")
      pub_key  = File.join(keys_dir, "#{user}@#{nodename}.pub")
      FileUtils.cp pub_key, File.join(target_dir, "keys", "key.pub")

      system("tar", "-C", ENV['HOME'], "-cvzf", bootstrap_file, "bootstrap")
      FileUtils.rm_r target_dir
    end
  end


  desc "Create a new profile for specified node"
  task :node_profile, [:nodename, :roles, :recipes] do |t, args|
    args.with_defaults(:roles => "average-box", :recipes => "")
    raise "Must provide a nodename" unless args.nodename

    nodename = args.nodename
    roles    = args.roles
    recipes  = args.recipes

    profiles_dir = File.join(TOPDIR, "roles")
    profile_file = File.join(profiles_dir, current_env, "#{nodename}.json")

    unless File.exists? profile_file
      run_list = roles.split(":").map{ |r| "\"role[#{r}]\"" } + recipes.split(":").map{ |r| "\"#{r}\"" }

      FileUtils.cp File.join(profiles_dir, "NODE_PROFILE.json"), profile_file
      system("sed", "-i", "8s:@@RUN_LIST@@:#{run_list.join(',')}:g", profile_file)
      system("gedit", profile_file)
    end
  end


  desc "Bootstrap a chef client node"
  task :bootstrap, [:user, :nodename, :ip, :platform, :arch] do |t, args|
    args.with_defaults(:platform => "ubuntu", :arch => "i686")
    raise "Must provide a user, a nodename and an IP address" unless (args.user and args.nodename and args.ip)
    raise "Allowed values for platform are: ubuntu, mint" if (args.platform and not %w[ubuntu mint].include? args.platform)
    raise "Allowed values for arch are: i686, x86_64" if (args.arch and not %w[i686 x86_64].include? args.arch)

    user     = args.user
    nodename = args.nodename
    platform = args.platform
    ip       = args.ip
    port     = 2222

    ssh_dir      = File.join(ENV['HOME'], ".ssh")
    profiles_dir = File.join(TOPDIR, "roles", current_env)
    key_file     = File.join(TOPDIR, "keys", current_env, "#{user}@#{nodename}", "#{user}@#{nodename}")

    FileUtils.cp File.join(ssh_dir, "known_hosts"), File.join(ssh_dir, "known_hosts.orig")

    if platform == "mint"
      url = "https://www.opscode.com/chef/download?p=ubuntu&pv=12.04&m=#{args.arch}"
      cmd = "curl -L '#{url}' > '/tmp/chef_client.deb' ; sudo dpkg -i '/tmp/chef_client.deb'"

      sh %{ssh -p #{port} -i #{key_file} #{user}@#{ip} "#{cmd}"}
    end

    sh %{knife role from file #{profiles_dir}/#{nodename}.json}
    sh %{knife bootstrap #{ip} --ssh-port #{port} --ssh-user #{user} --identity-file #{key_file} --node-name #{nodename} --sudo}
    sh %{knife node run_list add #{nodename} 'role[#{nodename}]'}

    FileUtils.mv File.join(ssh_dir, "known_hosts.orig"), File.join(ssh_dir, "known_hosts")
  end


  desc "Converge a chef client node"
  task :converge, [:user, :nodename, :ip, :platform, :arch] do |t, args|
    args.with_defaults(:platform => "ubuntu", :arch => "i686")
    raise "Must provide a user, a nodename and an IP address" unless (args.user and args.nodename and args.ip)
    raise "Allowed values for platform are: ubuntu, mint" if (args.platform and not %w[ubuntu mint].include? args.platform)
    raise "Allowed values for arch are: i686, x86_64" if (args.arch and not %w[i686 x86_64].include? args.arch)

    user     = args.user
    nodename = args.nodename
    platform = args.platform
    ip       = args.ip
    port     = 2222

    ssh_dir      = File.join(ENV['HOME'], ".ssh")
    profiles_dir = File.join(TOPDIR, "roles", current_env)
    key_file     = File.join(TOPDIR, "keys", current_env, "#{user}@#{nodename}", "#{user}@#{nodename}")

    FileUtils.cp File.join(ssh_dir, "known_hosts"), File.join(ssh_dir, "known_hosts.orig")

    if platform == "mint"
      url = "https://www.opscode.com/chef/download?p=ubuntu&pv=12.04&m=#{args.arch}"
      cmd = "curl -L '#{url}' > '/tmp/chef_client.deb' ; sudo dpkg -i '/tmp/chef_client.deb'"

      sh %{ssh -p #{port} -i #{key_file} #{user}@#{ip} "#{cmd}"}
    end

    sh %{knife role from file #{profiles_dir}/#{nodename}.json}
    sh %{knife bootstrap #{ip} --ssh-port #{port} --ssh-user #{user} --identity-file #{key_file} --node-name #{nodename} --run-list 'role[#{nodename}]' --sudo}

    FileUtils.mv File.join(ssh_dir, "known_hosts.orig"), File.join(ssh_dir, "known_hosts")
  end

end

