# CHANGELOG for base

This file is used to list changes made in each version of base.

## 0.15.1:

* recipes/main - now uses module Box's new method to retrieve platform code name

## 0.15.0:

* recipes/main - install virtualbox guest packages on virtual boxes and purge them otherwise
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
  - now manages Linux Mint specific packages

* recipes/end

  - now manages Linux Mint first system upgrade
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

