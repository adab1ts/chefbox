# CHANGELOG for dotfiles

This file is used to list changes made in each version of dotfiles.

## 0.6.1:

* README.md - ubuntu 12.04 no longer supported

## 0.6.0:

* README.md                            - linuxmint 13 no longer supported
* files/default/bash/env.d/README.benv - instructions about how to create bash env files
* templates/debian/bash/env.erb        - source env.d folder contents
* templates/default/bash/env.erb       - source env.d folder contents

## 0.5.5:

* templates/debian/bash/env.erb - extend chefadmin boxes env variables to crunchbang boxes

## 0.5.4:

* files/default/bash/functions.d/misc.bfn - new function to change the hostname of the box

## 0.5.3:

* recipes/default - minor update

## 0.5.2:

* templates/host-chefbox/bash/env.erb - env variables for chefadmin boxes

## 0.5.1:

* recipes/default - deliver 'apt-file' support to ubuntu platform only

## 0.5.0:

* README   - update copyright note
* metadata - remove 'core' and 'base' dependencies

* recipes/default

  - do not include recipe[base:default] any more
  - update apt-file cache immediately
  - use of symbols for attribute keys

## 0.4.1:

* recipes/default - now checks existence of ~/.bashrc file before backing it up

## 0.4.0:

* recipes/default - delivers first steps documentation concerning apt-file package

## 0.3.0:

* recipes/default - update to allow deployment of dotfiles to selected folder
* files/default/bash/* - moved from '$ADMIN_PATH/dotfiles' to '$DOTFILES_PATH'
* templates/default/bash/bashrc.erb - moved from '<%= @admin_folder %>/dotfiles' to '<%= @dotfiles_folder %>'
* templates/default/bash/env.erb - moved from '${ADMIN_PATH}/dotfiles' to '${HOME}/<%= @dotfiles_folder %>'

## 0.2.0:

* recipes/default - refactorized to allow deployment of dotfiles to selected users

## 0.1.0:

* Initial release of dotfiles

