# CHANGELOG for core

This file is used to list changes made in each version of core.

## 1.0.9:

* definitions/install_app   - now manages git repositories installation as well
* definitions/uninstall_app - now manages git repositories uninstallation as well

## 1.0.8:

* README.md - ubuntu 12.04 no longer supported

## 1.0.7:

* libraries/box - new implementation for Box.arch method

## 1.0.6:

* definitions/install_app - fix source id management bug

## 1.0.5:

* README.md - include CrunchBang as target platform

## 1.0.4:

* definitions/uninstall_app - fix typo

## 1.0.3:

* definitions/uninstall_app - fix bug

## 1.0.2:

* definitions/support - check if resource exists before downloading and minor refactoring 

## 1.0.1:

* libraries/app - new public method to retrieve the source data of an app

## 1.0.0:

* definitions/autostart_app - refactored due to new multi-platform structure of app profile

* definitions/install_app

  - refactored due to new multi-platform structure of app profile
  - no longer includes gem packages installation

* definitions/uninstall_app - refactored due to new multi-platform structure of app profile
* libraries/app             - module Coderebels::Chefbox::App provides app related methods
* libraries/box             - lsb_id method now returns linuxmint instead of mint when needed
* recipes/default           - includes custom Coderebels::Chefbox::App module

## 0.23.0:

* libraries/box

  - new method to retrieve the default platform desktop
  - now lsb_codename method is aware of new ubuntu release (trusty tahr)

## 0.22.4:

* definitions/support - fix bug

## 0.22.3:

* definitions/support

  - 'platforms' param renamed to 'only_for' to deliver support to specified platforms only
  - now accepts 'not_for' param to exclude delivery to specified platforms
  - now implements per-user support delivery as well

## 0.22.2:

* definitions/install_app - now manages gem packages installation as well

## 0.22.1:

* definitions/support - now accepts 'platforms' param to deliver support to specified platforms only

## 0.22.0:

* attributes/default - definition of default attribute 'chef_report.recipient', overridable by roles own definition at run time

## 0.21.1:

* libraries/shell - redefine method to evaluate a shell command

## 0.21.0:

* attributes/default        - definition of default attribute 'box', overriden by roles own definition at run time
* definitions/autostart_app - use of symbols for attribute keys
* definitions/install_app   - use of symbols for attribute keys
* definitions/launcher      - use of symbols for attribute keys

* definitions/support

  - use of symbols for attribute keys
  - Enumerable#reject implementation attempts to modify underlying immutable attribute hash. see:

    + https://tickets.opscode.com/browse/CHEF-4844
    + https://github.com/sethvargo/chefspec/issues/270

* definitions/uninstall_app - use of symbols for attribute keys

* definitions/uninstaller

  - use of symbols for attribute keys
  - Enumerable#reject implementation attempts to modify underlying immutable attribute hash

* libraries/box - use of symbols for attribute keys
* providers/ppa - use of symbols for attribute keys

## 0.20.1:

* definitions/support     - exclude guest users from delivering support
* definitions/uninstaller - exclude guest users from installing custom uninstaller script

## 0.20.0:

* definitions/uninstaller - adds a custom uninstaller script for specified app

## 0.19.4:

* definitions/install_app - zipped binaries installation targets guest users again

## 0.19.3:

* definitions/install_app   - minor update
* definitions/uninstall_app - do not purge suggested packages of the app being uninstalled (undesired effects)

## 0.19.2:

* definitions/install_app - minor update

## 0.19.1:

* definitions/install_app - minor refactorization

## 0.19.0:

* definitions/uninstall_app - now manages bin packages uninstallation

## 0.18.0:

* definitions/install_app - now manages zipped binaries installation as well

## 0.17.2:

* definitions/install_app - now manages version-based package installation

## 0.17.1:

* definitions/install_app - extend dependencies management to all kind of package sources 

## 0.17.0:

* libraries/box - new method to retrieve the code name of the target platform and some refactorization
* definitions/install_app   - now uses the new method to retrieve the platform code name
* definitions/uninstall_app - now uses the new method to retrieve the platform code name

## 0.16.0:

* libraries/box - new method to check if target box is virtual

## 0.15.0:

* attributes/default        - defines new core attribute node['apt']['sources_path']
* definitions/install_app   - minor refactorization
* definitions/uninstall_app - minor refactorization
* providers/ppa             - minor refactorization

## 0.14.1:

* definitions/install_app - now checks repo file existence before creation

## 0.14.0:

* libraries/box - new method to retrieve the operating system of the box

## 0.13.3:

* definitions/support - now delivers support material specific to platform

## 0.13.2:

* libraries/box - method to retrieve box architecture as class method now

## 0.13.1:

* definitions/uninstall_app - fix 'apps' data bag items update regression
* libraries/shell           - method to evaluate a shell command as class method now
* recipes/default           - Coderebels::Chefbox::Shell module for internal use now

## 0.13.0:

* definitions/install_app - now supports different distributions and archs for deb packages
* libraries/box           - moved from kernel cookbook, now includes device-related methods
* recipes/default         - includes custom Coderebels::Chefbox::Box module again

## 0.12.0:

* definitions/install_app - now purges packages replaced by app being installed

## 0.11.0:

* libraries/shell  - adds method to evaluate a shell command
* libraries/digest - refactorization of shadow method
* libraries/box    - moved to kernel cookbook
* recipes/default  - does not include custom Coderebels::Chefbox::Box module any more

## 0.10.2:

* definitions/launcher - now creates custom launcher with 00644 perms
* definitions/support - now creates folder without numbered prefix for better maintainance
* definitions/uninstall_app - now excludes src packages from purge

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

