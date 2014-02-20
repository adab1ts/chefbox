# CHANGELOG for devel

This file is used to list changes made in each version of devel.

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

