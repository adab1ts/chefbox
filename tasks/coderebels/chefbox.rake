#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Copyright:: Copyright (c) 2013, Carles Muiños
# License:: Apache License, Version 2.0
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

  desc "Show how to proceed to converge a new chefbox node"
  task :remindme do
    puts "1) Bundle a bootstrap package:  rake coderebels:bundle[user,hostname]"
    puts "2) Create a new profile:        rake coderebels:box_profile[user,hostname]"
    puts "3) Create a new role:           rake coderebels:box_role[user,hostname,recipes]"
    puts "4) Bootstrap/Converge the node: rake coderebels:bootstrap[user,hostname,ip]"
    puts "                                rake coderebels:converge[user,hostname,ip]"
  end


  desc "Generate openssl key for encrypted data bags management"
  task :edb_keygen, :keyname do |t, args|
    edb = args[:keyname] || "edb"
    edb_file = File.join(TOPDIR, "keys", edb)

    unless File.exists? edb_file
      sh %{openssl rand -base64 512 | tr -d '\\r\\n' > #{edb_file}}
    end
  end


  desc "Generate authentication keys to establish a ssh connection with a box"
  task :ssh_keygen, :user, :hostname do |t, args|
    raise "Must provide a user and a hostname" unless (args[:user] and args[:hostname])

    user     = args[:user]
    hostname = args[:hostname]
    keys_dir = File.join(TOPDIR, "keys", "#{user}@#{hostname}")

    unless File.exists? keys_dir
      FileUtils.mkdir_p keys_dir
      sh %{ssh-keygen -b 2048 -t rsa -N "" -C "Chef: ssh key for #{user}@#{hostname}" -f #{File.join(keys_dir, "#{user}@#{hostname}")}}
    end
  end


  desc "Bundle a bootstrap package for specified box"
  task :bundle => :ssh_keygen
  task :bundle, :user, :hostname do |t, args|
    raise "Must provide a user and a hostname" unless (args[:user] and args[:hostname])

    user     = args[:user]
    hostname = args[:hostname]

    desktop_dir = File.join(ENV['HOME'], "Escriptori")
    target_dir  = File.join(desktop_dir, "bootstrap")

    unless File.exists? target_dir
      bootstrap_dir = File.join(TOPDIR, "bootstrap")
      FileUtils.cp_r bootstrap_dir, target_dir

      keys_dir = File.join(TOPDIR, "keys", "#{user}@#{hostname}")
      pub_key  = File.join(keys_dir, "#{user}@#{hostname}.pub")
      FileUtils.cp pub_key, File.join(target_dir, "keys", "key.pub")

      system("tar", "-C", desktop_dir, "-cvzf", File.join(desktop_dir, "bootstrap.tar.gz"), "bootstrap")
      FileUtils.rm_r target_dir
    end
  end


  desc "Create a new profile for specified box"
  task :box_profile, :user, :hostname do |t, args|
    raise "Must provide a user and a hostname" unless (args[:user] and args[:hostname])

    user     = args[:user]
    hostname = args[:hostname]

    profile = "#{user}-#{hostname}"
    profile_file = File.join(TOPDIR, "data_bags", "boxes", "#{profile}.json")

    unless File.exists? profile_file
      edb_file = File.join(TOPDIR, "keys", "edb")
      editor   = "gedit"

      sh %{knife data bag create boxes #{profile} --secret-file #{edb_file} -e #{editor}}
      sh %{knife download data_bags}
    end
  end


  desc "Create a new role for specified box"
  task :box_role, :user, :hostname, :recipes do |t, args|
    raise "Must provide a user and a hostname" unless (args[:user] and args[:hostname])

    user     = args[:user]
    hostname = args[:hostname]
    recipes  = args[:recipes] || ""

    role = "#{user}-#{hostname}"
    role_file = File.join(TOPDIR, "roles", "#{role}.json")

    unless File.exists? role_file
      run_list = ["\"role[average-box]\""] + recipes.split(':').map{ |r| "\"recipe[#{r}]\"" }

      open(role_file, "w") do |file|
        file.puts <<-EOH
{
  "name": "#{role}",
  "description": "Profile for #{user}@#{hostname} box",
  "json_class": "Chef::Role",
  "chef_type": "role",
  "default_attributes": {
    "profile": "#{role}"
  },
  "override_attributes": {},
  "run_list": [
    #{run_list.join(',')}
  ],
  "env_run_lists": {}
}
EOH
      end

      sh %{knife role from file #{role}.json}
    end
  end


  desc "Bootstrap a chef client node"
  task :bootstrap, :user, :hostname, :ip do |t, args|
    raise "Must provide a user, a hostname and an IP address" unless (args[:user] and args[:hostname] and args[:ip])

    user     = args[:user]
    hostname = args[:hostname]
    ip       = args[:ip]
    port     = 2222
    key_file = File.join(TOPDIR, "keys", "#{user}@#{hostname}", "#{user}@#{hostname}")
    run_list = "role[#{user}-#{hostname}]"

    sh %{knife bootstrap #{ip} --ssh-port #{port} --ssh-user #{user} --identity-file #{key_file} --sudo}
    sh %{knife node run_list add #{hostname} '#{run_list}'}
  end


  desc "Converge a chef client node"
  task :converge, :user, :hostname, :ip do |t, args|
    raise "Must provide a user, a hostname and an IP address" unless (args[:user] and args[:hostname] and args[:ip])

    user     = args[:user]
    hostname = args[:hostname]
    ip       = args[:ip]
    port     = 2222
    key_file = File.join(TOPDIR, "keys", "#{user}@#{hostname}", "#{user}@#{hostname}")
    run_list = "role[#{user}-#{hostname}]"

    sh %{knife bootstrap #{ip} --ssh-port #{port} --ssh-user #{user} --identity-file #{key_file} --run-list '#{run_list}' --sudo}
  end


  desc "Establish a ssh connection with specified box"
  task :ssh, :user, :hostname, :ip, :cmd do |t, args|
    raise "Must provide a user, a hostname and an IP address" unless (args[:user] and args[:hostname] and args[:ip])

    user     = args[:user]
    hostname = args[:hostname]
    ip       = args[:ip]
    port     = 2222
    cmd      = args[:cmd]
    key_file = File.join(TOPDIR, "keys", "#{user}@#{hostname}", "#{user}@#{hostname}")

    sh %{ssh -p #{port} -i #{key_file} #{user}@#{ip} #{cmd}}
  end

end

