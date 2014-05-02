# CHANGELOG for base

This file is used to list changes made in each version of base.

## 0.23.2:

* recipes/main-ubuntu - restricted extras installation based on platform flavour

## 0.23.1:

* recipes/end - refactor platform support

## 0.23.0:

* recipes/begin         - install ruby shadow library for the target platform
* recipes/end           - include end-linuxmint instead of former end-mint recipe
* recipes/end-linuxmint - former end-mint recipe

* recipes/main

  - move gnome-do installation to recipe[utils::gnome-do]
  - include main-linuxmint instead of former main-mint recipe

* recipes/main-linuxmint

  - former main-mint recipe
  - maya only support for ia32-libs in x86_64 platforms

* recipes/main-ubuntu

  - precise only support for ia32-libs in x86_64 platforms
  - enable trusty only support for virtual guest machine

* recipes/run-end       - use linuxmint instead of mint when needed

## 0.22.4:

* recipes/end-mint - first system upgrade based on platform desktop

## 0.22.3:

* recipes/main-mint   - full support for ia32-libs in x86_64 platforms
* recipes/main-ubuntu - full support for ia32-libs in x86_64 platforms

## 0.22.2:

* recipes/begin - manage system user accounts creation

## 0.22.1:

* files/ubuntu-12.04/apt/sources.list - add precise-backports to sources management

## 0.22.0:

* recipes/main-ubuntu - remove virtual guest support again (virtualbox-guest-x11 dependency
                        prevents from completing installation)

## 0.21.0:

* recipes/main-ubuntu - manage virtual guest support again

## 0.20.1:

* files/host-chefbox/apt/sources.list - sources list for chefadmin box

## 0.20.0:

* metadata         - add cookbook 'chef_handler' dependency
* recipes/run-init - install and enable MailHandler to send chef-run reports by mail

## 0.19.0:

* metadata        - remove cookbook 'core' dependency
* recipes/default - do not include recipe[core:default] any more

* recipes/begin

  - box profile is now a default attribute loaded from roles (data bag items not needed anymore)
  - move apt sources management to new recipe[run-init]
  - use of symbols for attribute keys
  - Enumerable#reject implementation attempts to modify underlying immutable attribute hash. see:

    + https://tickets.opscode.com/browse/CHEF-4844
    + https://github.com/sethvargo/chefspec/issues/270

* recipes/main      - minor update
* recipes/main-mint - use of symbols for attribute keys

* recipes/main-ubuntu

  - do not manage virtual guest support any more
  - use of symbols for attribute keys

* recipes/end-mint

  - purge gnome-control-center by default
  - move apt sources management to new recipe[run-end]

* recipes/end-ubuntu - minor update
* recipes/end        - move first_run_completed attribute management to new recipe[run-end]
* recipes/run-init   - manage apt sources

* recipes/run-end

  - restore apt sources in linuxmint platforms (backports disabled)
  - manage first_run_completed normal attribute
  - reboot the very first run when chef client succeeds

## 0.18.0:

* recipes/main-mint   - move y-ppa-manager installation to recipe[utils::yppamgr]
* recipes/main-ubuntu - move y-ppa-manager installation to recipe[utils::yppamgr]

## 0.17.0:

* recipes/main

  - install Catalan and Spanish language packages by default
  - move MS Office True Type Fonts installation to recipe[office::msttfonts]

* recipes/main-mint   - move libreoffice installation to recipe[office::libreoffice]
* recipes/main-ubuntu - move libreoffice installation to recipe[office::libreoffice]

## 0.16.0:

* recipes/begin - update sources.list file the very first run only

* recipes/main

  - remove qtnx package installation
  - delegate platform specific stuff to platform-based recipes

* recipes/main-mint

  - manage linuxmint specific tasks from main recipe
  - install ia32-libs package in x86_64 platforms
  - install y-ppa-manager for ppa management

* recipes/main-ubuntu

  - manage ubuntu specific tasks from main recipe
  - install ia32-libs package in x86_64 platforms
  - install y-ppa-manager for ppa management

* recipes/end - delegate platform specific stuff to platform-based recipes

* recipes/end-mint

  - manage linuxmint specific tasks from end recipe
  - restore sources.list file to its original (backport disabled)

* recipes/end-ubuntu - manage ubuntu specific tasks from end recipe
* files/linuxmint-13/apt/sources.list.final - backport disabled

## 0.15.1:

* recipes/main - now uses module Box's new method to retrieve platform code name

## 0.15.0:

* recipes/main - install virtualbox guest packages on virtual boxes or purge them otherwise
* recipes/end  - removed purge of virtualbox guest packages

## 0.14.2:

* recipes/main - now checks existence of repository file before addition

## 0.14.1:

* files/linuxmint-13/apt/sources.list - replaces official repository server with primary mirror

## 0.14.0:

* recipes/begin

  - updates sources.list file on target platforms
  - runs package sources first update
  - only selected users are assigned the sudo group

* recipes/main

  - installs required language packages
  - now manages linuxmint specific packages

* recipes/end

  - now manages linuxmint first system upgrade
  - now delivers first steps documentation to target platforms

## 0.13.0:

* recipes/main - removed installation of redshift; now installs gnome-do

## 0.12.1:

* recipes/begin - now updates sources.list file on ubuntu platform only

## 0.12.0:

* recipes/main - moved nautilus-gtkhash installation to recipe[security::nautilus]

## 0.11.0:

* recipes/main - now installs redshift to adjust the color temperature of the screen

## 0.10.0:

* recipes/main - moved dkms installation to recipe[kernel::dkms]
* recipes/main - moved preload installation to recipe[kernel::preload]

## 0.9.0:

* recipes/main - moved p7zip installation to recipe[utils::p7zip]

## 0.8.0:

* recipes/main - delivers first steps documentation concerning libreoffice suite
* recipes/end  - delivers first steps documentation concerning the USC and the Ubuntu platform

## 0.7.1:

* recipes/begin - now excludes existing default user from account management

## 0.7.0:

* recipes/begin - concerning official ubuntu sources management, ensures all nodes are on the same page
* files/default/apt/sources.list - included in sources management

## 0.6.0:

* recipes/begin - includes users account management
* recipes/end   - refactorized to allow deployment of next steps instructions to every box user
* recipes/main  - refactorized to apply user-dependent tasks to every box user
* templates/default/sudoer.erb - included in sudo management

## 0.5.0:

* recipes/default - now includes only recipe[base::begin], recipe[base::main] and recipe[base::end]
* recipes/begin   - includes code and resources to be executed in the first place
* recipes/end     - includes code and resources to be executed at the end
* recipes/main    - now includes the contents of recipe[base::office] and recipe[base::restricted-extras] as well
* recipes/office  - deleted
* recipes/restricted-extras - deleted

## 0.4.0:

* recipes/default  - removed inclusion of recipe[base::eyecandy]
* recipes/eyecandy - deleted

## 0.3.0:

* recipes/default           - removed inclusion of recipe[base::indicators]
* recipes/indicators        - deleted
* files/default/autostart/* - deleted

## 0.2.0:

* recipes/default  - removed inclusion of recipe[base::security]
* recipes/security - deleted
* files/default/ufw/chef-openssh-server - deleted

## 0.1.4:

* recipes/* - refactorization of recipes by introducing definitions in 'core' cookbook

## 0.1.3:

* Create Suport folder with post installation instructions in recipe[base::default]

## 0.1.2:

* Remove Faenza icon theme from recipe[base::eyecandy]

## 0.1.1:

* Remove Faience icon theme from recipe[base::eyecandy]

## 0.1.0:

* Initial release of base

