# CHANGELOG for devel

This file is used to list changes made in each version of devel.

## 0.12.0:

* README.md     - update copyright note and description
* definitions/* - update copyright note
* recipes/*     - update copyright note

* recipes/default  - remove grunt, juju and shelr install management
* recipes/ansible  - update ansible install management
* recipes/atom     - update atom packages installation
* recipes/grunt    - removed
* recipes/juju     - removed
* recipes/nodejs   - nvm now manages node.js installation
* recipes/shelr    - removed
* recipes/vagrant  - add vagrant-bindfs plugin
* recipes/wp-devel - install evolution wordpress dependency
* files/default/git/gitconfig      - update pretty format
* files/default/juju/juju.zal      - removed
* files/default/nodejs/nodejs.zenv - automatically activate nvm upon login
* files/default/nodejs/nodejs.zfn  - automatically call `nvm use` in a directory with a `.nvmrc` file
* files/default/ruby/ruby.zal      - noglob rake
* templates/default/juju/environments.yaml.erb - removed

## 0.11.1:

* recipes/wp-devel - new wp generator: evolve-wordpress
* files/default/wp-devel/wp-devel.zal - update wp development aliases
* README.md - Evolution WordPress as new wordpress generator

## 0.11.0:

* recipes/default - now includes keroku toolbelt install management
* recipes/heroku  - manage heroku toolbelt installation
* files/default/heroku/heroku.zenv - env variables for heroku toolbelt

## 0.10.0:

* recipes/default    - remove virtualbox install management
* recipes/firefox-de - fix launcher exec & icon vars
* recipes/processing - fix launcher exec & icon vars
* recipes/vagrant    - add NFS support and setup
* recipes/virtualbox - removed
* recipes/wp-devel   - move required NFS support to vagrant recipe
* files/default/vagrant/nfs-kernel-server - bind rpc.mountd to one static port
* files/default/vagrant/ufw_nfs           - firewall rules to unblock nfs ports
* templates/default/firefox/firefox.desktop.erb       - fix launcher exec & icon params
* templates/default/processing/processing.desktop.erb - fix launcher exec & icon params

## 0.9.0:

* definitions/*       - update copyright note
* recipes/*           - update copyright note

* recipes/default     - now includes chef development kit and google web designer install management
* recipes/atom        - manage atom packages installation
* recipes/chefdk      - manage chef development kit installation
* recipes/webdesigner - manage google web designer installation
* recipes/wp-devel    - include aliases for wp instances management

## 0.8.2:

* recipes/default                        - update development shared env variables
* templates/default/devel/devel.zenv.erb - include CDPATH env variable
* files/default/git/gitconfig            - update git aliases

## 0.8.1:

* recipes/firefox-de - include launcher and uninstaller

## 0.8.0:

* recipes/default    - now includes firefox developer edition install management
* recipes/firefox-de - manage firefox developer edition installation
* recipes/processing - enable uninstaller
* recipes/vagrant    - fix public key authentication issue with vagrant boxes
* recipes/wp-devel   - delegate capistrano installation to Bundle
* files/default/vagrant/vagrant_nfs                 - sudoers.d rules for vagrant nfs management
* templates/default/vagrant/vagrant_hostmanager.erb - sudoers.d rules for vagrant-hostmanager plugin

## 0.7.1:

* recipes/default - remove libc6 upgrade from debian sid
* recipes/ansible - fix ansible dependency
* recipes/nodejs  - ensure that gyp uses python2

## 0.7.0:

* definitions/bootstrap - now includes package-specific env variables management
* definitions/env       - manage package-specific env variables
* recipes/default       - now includes ansible, atom, bower, grunt, gulp, node.js, processing, ruby,
                          vagrant, virtualbox, web starter kit, genesis wordpress and yeoman install management
* recipes/ansible       - manage ansible installation
* recipes/atom          - manage atom installation
* recipes/bower         - manage bower installation
* recipes/grunt         - manage grunt installation
* recipes/gulp          - manage gulp installation
* recipes/nodejs        - manage node.js installation
* recipes/ruby          - manage ruby installation
* recipes/processing    - manage processing installation
* recipes/vagrant       - manage vagrant installation
* recipes/virtualbox    - manage virtualbox installation
* recipes/wp-devel      - manage genesis wordpress installation
* recipes/wsk           - manage web starter kit installation
* recipes/yeoman        - manage yeoman installation
* files/default/ruby/ruby.zenv           - env variables for ruby programming language
* templates/default/devel/devel.zenv.erb - development shared env variables

## 0.6.2:

* README.md - ubuntu 12.04 no longer supported

## 0.6.1:

* README.md - linuxmint 13 no longer supported

## 0.6.0:

* recipes/default  - now includes brackets install management
* recipes/brackets - manage brackets installation

## 0.5.2:

* README.md - include CrunchBang as target platform

## 0.5.1:

* recipes/git  - check availability before app installation
* recipes/juju - check availability before app installation
* recipes/zsh  - check availability before app installation

## 0.5.0:

* recipes/default  - now includes shelr install management
* recipes/shelr    - manage shelr installation

## 0.4.1:

* recipes/zsh                   - deploy zsh env.d directory for application env variables
* files/default/zsh/env         - now sources zenv files in env.d directory
* files/default/zsh/README.zenv - instructions about how to create and use zenv files

## 0.4.0:

* README              - update requirements section
* metadata            - remove 'core' and 'base' dependencies
* definitions/aliases - update copyright note

* definitions/bootstrap

  - update copyright note
  - use of symbols for attribute keys

* definitions/devfile - update copyright note
* definitions/functions - update copyright note

* recipes/default

  - update copyright note
  - do not include recipe[base:default] any more
  - move htop package installation to recipe[sysadmin::htop]
  - normal attribute 'apps' becomes default attribute
  - use of symbols for attribute keys

* recipes/git

  - update copyright note
  - use of symbols for attribute keys

* recipes/juju

  - update copyright note
  - use of symbols for attribute keys

* recipes/zsh

  - update copyright note
  - use of symbols for attribute keys

## 0.3.0:

* recipes/default - now checks for section presence in box profile's apps list before proceed

## 0.2.1:

* recipes/juju    - minor update of bootstrapping's before script

## 0.2.0:

* recipes/default - now includes htop installation and zsh & git recipes
* recipes/git     - installs and bootstraps git distributed version control system
* recipes/juju    - now bootstraps juju service orchestration tool
* recipes/zsh     - installs and bootstraps zsh shell

## 0.1.0:

* Initial release of devel
