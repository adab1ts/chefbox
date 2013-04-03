# CHANGELOG for core

This file is used to list changes made in each version of core.

## 0.10.1:

* definitions/launcher - now supports specified file as launcher

## 0.10.0:

* definitions/launcher - adds a custom launcher for specified app

## 0.9.0:

* definitions/support - delivers support material to every box user

## 0.8.1:

* definitions/uninstall_app - now purges ppa/repo packages if sources have been previously added

## 0.8.0:

* definitions/autostart_app - now creates .desktop files for every box user
* definitions/directory_tree - creates directories in a path recursively, applying same owner, group and mode
* libraries/digest - adds method to shadow plain text passwords

## 0.7.1:

* definitions/install_app - now accepts blank distribution and keyserver values for apt repositories

## 0.7.0:

* libraries/monkey_patches - opens class Numeric to add kB, MB and GB methods

## 0.6.1:

* definitions/autostart_app - addition of 'desktop_file' definition argument

## 0.6.0:

* definitions/install_app - now manages deb packages installation as well
* libraries/box - module Coderebels::Chefbox::Box provides box related methods
* libraries/digest - module Coderebels::Chefbox::Digest provides digest related methods
* recipes/default - includes custom modules

## 0.5.0:

* definitions/autostart_app - tells an application to autostart when login in

## 0.4.1:

* definitions/purge_pkgs - removal of purge_pkgs definition (uninstall_app in its place)

## 0.4.0:

* definitions/uninstall_apps - wraps the removal of specified applications

## 0.3.0:

* definitions/install_app - wraps the installation of an application, managing the addition of external sources when nedeed
* definitions/uninstall_app - wraps the purge of an application and the suggested packages installed with it

## 0.2.0:

* definitions/purge_pkgs - new definition wrapping the purge of a package and the suggested ones installed with it

## 0.1.1:

* resources/ppa - added clean_saved attribute to trigger sources backup removal
* providers/ppa - sources backup removal triggered based on clean_saved resource attribute

## 0.1.0:

* Initial release of core - new core_ppa resource & provider for ppa management

