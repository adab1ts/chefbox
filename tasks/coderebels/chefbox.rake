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

  def load_env_vars(env=nil)
    env_folder = env ? ".chef-#{env}" : ".chef"
    env_file   = File.join(TOPDIR, env_folder, "env")

    IO.foreach(env_file) do |line|
      line = line.chomp.strip
      ENV.store *line.split('=', 2) unless line.empty?
    end
  end

  def update_env_vars(vars, env=nil)
    load_env_vars(env)
    vars.each { |k, v| ENV.store(k.to_s.upcase, v) }

    env_folder = env ? ".chef-#{env}" : ".chef"
    env_file   = File.join(TOPDIR, env_folder, "env")
    skel_env_file = File.join(TOPDIR, ".chef-skel", "env")

    File.open(env_file, "w") do |file|
      IO.foreach(skel_env_file) do |line|
        line = line.chomp.strip

        unless line.empty?
          key = line.split('=')[0]
          file.puts "#{key}=#{ENV[key]}"
        end
      end
    end
  end

  # def update_hosts_file(env, vars)
  #   hostname   = "chefserver-#{env}"
  #   hosts_file = "/etc/hosts"

  #   host_data  = []
  #   host_entry = nil

  #   output = %x( grep -ERwne #{hostname} #{hosts_file} ).chomp

  #   if output.empty?
  #     host_data << "#192.168.0.100" << "#{hostname}.#{vars[:chef_svr_domain]}" << hostname
  #   else
  #     _ = output.split(":")

  #     n = _.first
  #     system("sudo", "sed", "-i", "#{n}d", hosts_file)

  #     host_data = _.last.split("\s")
  #     host_data[0] = vars[:chef_svr_ip] if vars[:chef_svr_ip]
  #     host_data[1] = "#{hostname}.#{vars[:chef_svr_domain]}" if vars[:chef_svr_domain]
  #   end

  #   host_entry = host_data.join("\t")
  #   system %{printf "#{host_entry}\n" | sudo tee -a #{hosts_file}}
  # end

  def update_hosts_file(env, vars)
    hostname   = env == "ocs" ? "ocserver" : "chefserver-#{env}"
    hosts_file = "/etc/hosts"

    host_data  = []
    host_entry = nil

    output = %x( grep -ERwne #{hostname} #{hosts_file} ).chomp

    if output.empty?
      ip   = env == "ocs" ? vars[:svr_ip] : "#192.168.0.100"
      fqdn = env == "ocs" ? "#{hostname}.coderebels.org" : "#{hostname}.#{vars[:svr_domain]}"
      host_data << ip << fqdn << hostname
    else
      _ = output.split(":")

      n = _.first
      system("sudo", "sed", "-i", "#{n}d", hosts_file)

      host_data = _.last.split("\s")
      host_data[0] = vars[:svr_ip] if vars[:svr_ip]
      host_data[1] = "#{hostname}.#{vars[:svr_domain]}" if vars[:svr_domain]
    end

    host_entry = host_data.join("\t")
    system %{printf "#{host_entry}\n" | sudo tee -a #{hosts_file}}
  end


  desc "Pull chefbox code from Github and upload to chef server"
  task :chefbox_updt do
    FileUtils.cd(TOPDIR) do
      sh %{git checkout master}
      sh %{git pull}

      FileList["roles/crb/*"].each { |role| sh %{knife role from file #{role}} }
      FileList["roles/common/*"].each { |role| sh %{knife role from file #{role}} }
      FileList["data_bags/apps/*"].each { |dbi| sh %{knife data bag from file apps #{File.basename(dbi)}} }
      FileList["data_bags/backgrounds/*"].each { |dbi| sh %{knife data bag from file backgrounds #{File.basename(dbi)}} }
      FileList["data_bags/global/*"].each { |dbi| sh %{knife data bag from file global #{File.basename(dbi)}} }
      FileList["data_bags/resources/*"].each { |dbi| sh %{knife data bag from file resources #{File.basename(dbi)}} }
      sh %{knife cookbook upload -a}
    end
  end


  desc "Remove environment directory structure"
  task :remove_env, [:env] do |t, args|
    raise "Must provide an environment name" unless args.env

    if args.env == current_env
      puts "You are trying to remove the current environment."
      puts "Switch to another environment first and try again."
    else
      env_dir       = File.join(TOPDIR, ".chef-#{args.env}")
      env_keys_dir  = File.join(TOPDIR, "keys", args.env)
      env_roles_dir = File.join(TOPDIR, "roles", args.env)
      
      FileUtils.rm_rf env_dir if File.exists? env_dir
      FileUtils.rm_rf env_keys_dir if File.exists? env_keys_dir
      FileUtils.rm_rf env_roles_dir if File.exists? env_roles_dir

      # /etc/hosts
      hostname   = "chefserver-#{args.env}"
      hosts_file = "/etc/hosts"

      output = %x( grep -ERwne #{hostname} #{hosts_file} ).chomp

      unless output.empty?
        n = output.split(":").first
        system("sudo", "sed", "-i", "#{n}d", hosts_file)
      end
    end
  end


  desc "Make environment directory structure"
  task :make_env, [:env] do |t, args|
    raise "Must provide an environment name" unless args.env

    skel_dir      = File.join(TOPDIR, ".chef-skel")
    env_dir       = File.join(TOPDIR, ".chef-#{args.env}")
    env_keys_dir  = File.join(TOPDIR, "keys", args.env)
    env_roles_dir = File.join(TOPDIR, "roles", args.env)
    
    FileUtils.cp_r(skel_dir, env_dir) unless File.exists? env_dir
    FileUtils.mkdir_p env_keys_dir unless File.exists? env_keys_dir
    FileUtils.mkdir_p env_roles_dir unless File.exists? env_roles_dir
  end


  desc "Setup the target environment"
  task :setup_env, [:env, :email, :domain] => :make_env do |t, args|
    args.with_defaults(:domain => "coderebels.org")
    raise "Must provide an environment name and an email address" unless (args.env and args.email)

    skel_dir = File.join(TOPDIR, ".chef-skel")
    env_dir  = File.join(TOPDIR, ".chef-#{args.env}")

    # TOPDIR/.chef-env/knife.rb
    File.open(File.join(env_dir, "knife.rb"), "w") do |file|
      content = IO.read(File.join(skel_dir, "knife.rb")).
                  gsub(/@@ENV@@/, args.env).
                  gsub(/@@DOMAIN@@/, args.domain)
      file.puts content
    end

    # TOPDIR/.chef-env/env
    env_vars = {chef_report_recipient: args.email,
                chef_svr_alias: "chefserver-#{args.env}",
                chef_svr_domain: args.domain}
    update_env_vars(env_vars, args.env)

    # /etc/hosts
    update_hosts_file args.env, svr_domain: args.domain
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


  desc "Prepare your chefbox workspace"
  task :workspace, [:env, :email, :domain] => [:edb_keygen, :setup_env] do |t, args|
    args.with_defaults(:domain => "coderebels.org")
    raise "Must provide the default environment for your workspace" unless args.env
    raise "Must provide the email address of the recipient of chef-client run reports" unless args.email

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


  desc "Setup owncloud server"
  task :setup_ocs, [:ip] do |t, args|
    raise "Must provide an IP address" unless args.ip

    update_hosts_file "ocs", svr_ip: args.ip
  end


  desc "Switch current environment"
  task :switch_env, [:env, :ip] do |t, args|
    raise "Must provide an environment and an IP address" unless (args.env and args.ip)

    current = current_env

    if args.env == current
      update_env_vars chef_svr_ip: args.ip
      update_hosts_file args.env, svr_ip: args.ip

      puts "Current environment: #{current}"
    else
      env_dir = File.join(TOPDIR, ".chef-#{args.env}")

      if File.exists? env_dir
        chef_dir = File.join(TOPDIR, ".chef")
        env_file = File.join(TOPDIR, ".environment")

        FileUtils.mv chef_dir, File.join(TOPDIR, ".chef-#{current}")
        FileUtils.mv env_dir, chef_dir
        system("sed", "-i", "1s:#{current}:#{args.env}:g", env_file)

        update_env_vars chef_svr_ip: args.ip
        update_hosts_file args.env, svr_ip: args.ip

        puts "Current environment: #{current_env}"
      else
        puts "The environment '#{args.env}' does not exist."
        puts "Create it first with 'coderebels:setup_env' task"
      end
    end
  end


  desc "Create a new profile for specified node"
  task :create_profile, [:nodename, :roles, :recipes] do |t, args|
    args.with_defaults(:roles => "average-box", :recipes => "")
    raise "Must provide a nodename" unless args.nodename

    nodename = args.nodename
    roles    = args.roles
    recipes  = args.recipes

    profiles_dir = File.join(TOPDIR, "roles")
    profile_file = File.join(profiles_dir, current_env, "#{nodename}.json")

    unless File.exists? profile_file
      run_list = roles.split(":").map{ |r| "\"role[#{r}]\"" } + recipes.split(":").map{ |r| "\"#{r}\"" }

      File.open(profile_file, "w") do |file|
        content = IO.read(File.join(profiles_dir, "NODE_PROFILE.json")).
                    gsub(/@@NODE_NAME@@/, nodename).
                    gsub(/@@RUN_LIST@@/, run_list.join(','))
        file.puts content
      end

      system(ENV['XEDITOR'], profile_file)
    end
  end


  desc "Edit profile for specified node"
  task :edit_profile, [:nodename] do |t, args|
    raise "Must provide a nodename" unless args.nodename

    profile_file = File.join(TOPDIR, "roles", current_env, "#{args.nodename}.json")
    system(ENV['XEDITOR'], profile_file)
  end


  desc "Update profile for specified node"
  task :update_profile, [:nodename] do |t, args|
    raise "Must provide a nodename" unless args.nodename

    profile_file = File.join(TOPDIR, "roles", current_env, "#{args.nodename}.json")
    sh %{knife role from file #{profile_file}}
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


  desc "Bundle a bootstrap package for specified box"
  task :bundle, [:user, :nodename, :mtype] => :ssh_keygen do |t, args|
    args.with_defaults(:mtype => "laptop")
    raise "Must provide a user and a nodename" unless (args.user and args.nodename)
    raise "Allowed values for mtype are: laptop, pc, vm" if (args.mtype and not %w[laptop pc vm].include? args.mtype)

    user     = args.user
    nodename = args.nodename
    mtype    = args.mtype

    bootstrap_file = File.join(ENV['HOME'], "#{user}@#{nodename}.tar.gz")

    unless File.exists? bootstrap_file
      load_env_vars

      bootstrap_dir = File.join(TOPDIR, "bootstrap")
      target_dir    = File.join(ENV['HOME'], "bootstrap")
      FileUtils.cp_r bootstrap_dir, target_dir

      iface = mtype == "laptop" ? "wlan" : "eth"

      FileList["#{target_dir}/*.sh"].each do |target_file|
        File.open(target_file, "w") do |file|
          content = IO.read(File.join(bootstrap_dir, File.basename(file))).
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

    ssh_dir  = File.join(ENV['HOME'], ".ssh")
    key_file = File.join(TOPDIR, "keys", current_env, "#{user}@#{nodename}", "#{user}@#{nodename}")
    profile_file = File.join(TOPDIR, "roles", current_env, "#{nodename}.json")

    FileUtils.cp File.join(ssh_dir, "known_hosts"), File.join(ssh_dir, "known_hosts.orig")

    if platform == "mint"
      url = "https://www.opscode.com/chef/download?p=ubuntu&pv=12.04&m=#{args.arch}"
      cmd = "curl -L '#{url}' > '/tmp/chef_client.deb' ; sudo dpkg -i '/tmp/chef_client.deb'"

      sh %{ssh -p #{port} -i #{key_file} #{user}@#{ip} "#{cmd}"}
    end

    sh %{knife role from file #{profile_file}}
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

    ssh_dir  = File.join(ENV['HOME'], ".ssh")
    key_file = File.join(TOPDIR, "keys", current_env, "#{user}@#{nodename}", "#{user}@#{nodename}")
    profile_file = File.join(TOPDIR, "roles", current_env, "#{nodename}.json")

    FileUtils.cp File.join(ssh_dir, "known_hosts"), File.join(ssh_dir, "known_hosts.orig")

    if platform == "mint"
      url = "https://www.opscode.com/chef/download?p=ubuntu&pv=12.04&m=#{args.arch}"
      cmd = "curl -L '#{url}' > '/tmp/chef_client.deb' ; sudo dpkg -i '/tmp/chef_client.deb'"

      sh %{ssh -p #{port} -i #{key_file} #{user}@#{ip} "#{cmd}"}
    end

    sh %{knife role from file #{profile_file}}
    sh %{knife bootstrap #{ip} --ssh-port #{port} --ssh-user #{user} --identity-file #{key_file} --node-name #{nodename} --run-list 'role[#{nodename}]' --sudo}

    FileUtils.mv File.join(ssh_dir, "known_hosts.orig"), File.join(ssh_dir, "known_hosts")
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

end

