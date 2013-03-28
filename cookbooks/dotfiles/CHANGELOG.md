# CHANGELOG for dotfiles

This file is used to list changes made in each version of dotfiles.

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

