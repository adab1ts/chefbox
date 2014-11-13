#
# Author:: Carles Muiños (<carles.ml.dev@gmail.com>)
# Cookbook Name:: devel
# Recipe:: ruby
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


# refs:
#   https://robots.thoughtbot.com/using-rbenv-to-manage-rubies-and-gems
#   https://github.com/sstephenson/rbenv
#   https://github.com/sstephenson/rbenv/wiki/Plugins
#   https://github.com/sstephenson/ruby-build
#   https://github.com/sstephenson/ruby-build/wiki
#   https://github.com/thoughtbot/laptop
#   https://github.com/thoughtbot/laptop/blob/39768b19959f74724ed0c0ea92e5b2f6f78e45c1/linux
#   https://github.com/thoughtbot/laptop/blob/master/mac

devel = node[:apps][:devel]

# A dynamic and open source programming language
ruby = devel['profiles']['ruby']

if app_available? ruby
  # Installing curl ...
  package "curl"

  # Installing rbenv, to change Ruby versions ...
  install_app "ruby" do
    force true
    profile ruby
  end

  # Setting rbenv environment up ...
  bootstrap "ruby" do
    folders [".rbenv/plugins"]
    env :priority => "10"
  end

  box = node[:box]

  box[:devel][:users].each do |username|
    usr = box[:users][username]

    # Installing rbenv-binstubs to make rbenv transparently aware of project-specific binstubs created by bundler ...
    git "#{username}-rbenv-binstubs" do
      repository "https://github.com/ianheggie/rbenv-binstubs.git"
      revision "master"
      destination "#{usr[:home]}/.rbenv/plugins/rbenv-binstubs"
      user username
      group usr[:group]
      action :sync
    end

    # Installing rbenv-gem-rehash so the shell automatically picks up binaries after installing gems with binaries ...
    git "#{username}-rbenv-gem-rehash" do
      repository "https://github.com/sstephenson/rbenv-gem-rehash.git"
      revision "master"
      destination "#{usr[:home]}/.rbenv/plugins/rbenv-gem-rehash"
      user username
      group usr[:group]
      action :sync
    end

    # Installing rbenv-env, adds the rbenv env command that shows relevant environment variables ...
    git "#{username}-rbenv-env" do
      repository "https://github.com/ianheggie/rbenv-env.git"
      revision "master"
      destination "#{usr[:home]}/.rbenv/plugins/rbenv-env"
      user username
      group usr[:group]
      action :sync
    end

    # Installing rbenv-update, adds the rbenv update command that updated rbenv and all installed plugins ...
    git "#{username}-rbenv-update" do
      repository "https://github.com/rkh/rbenv-update.git"
      revision "master"
      destination "#{usr[:home]}/.rbenv/plugins/rbenv-update"
      user username
      group usr[:group]
      action :sync
    end

    # Installing ruby-build, to install Rubies ...
    git "#{username}-ruby-build" do
      repository "https://github.com/sstephenson/ruby-build.git"
      revision "master"
      destination "#{usr[:home]}/.rbenv/plugins/ruby-build"
      user username
      group usr[:group]
      action :sync
    end

    bash "#{username}-ruby_install" do
      user username
      group usr[:group]
      cwd usr[:home]
      environment 'HOME' => usr[:home]
      code <<-EOH
        # Loading user environment ...
        . ${HOME}/.bashrc

        export PATH="${HOME}/.rbenv/bin:${PATH}"
        eval "$(rbenv init -)"

        ruby_version="$(curl -sSL http://ruby.thoughtbot.com/latest)"

        # Installing Ruby ${ruby_version} ...
        rbenv install -s "$ruby_version"

        # Setting ${ruby_version} as global default Ruby ...
        rbenv global "$ruby_version"
        rbenv rehash

        # Updating to latest Rubygems version ...
        gem update --system

        # Installing Bundler to install project-specific Ruby gems ...
        gem install bundler --no-document

        # Configuring Bundler for faster, parallel gem installation ...
        number_of_cores=$(nproc)
        bundle config --global jobs $((number_of_cores - 1))
        EOH
      action :nothing
      subscribes :run, resources("git[#{username}-ruby-build]"), :immediately
    end
  end
end

