# CHANGELOG for vms

This file is used to list changes made in each version of vms.

## 0.5.0:

* attributes/default     - new default attribute for virtualbox checksums file url
* recipes/default        - now installs virtualbox as a system service
* recipes/virtualbox-as  - manages virtualbox autostart service configuration
* providers/vbox_extpack - get_version & extpack_for methods refactorized

## 0.4.0:

* README   - update requirements section
* metadata - remove 'core' and 'base' dependencies

* recipes/default

  - do not include recipe[base:default] any more
  - normal attribute 'apps' becomes default attribute
  - use of symbols for attribute keys
  - Enumerable#reject implementation attempts to modify underlying immutable attribute hash. see:

    + https://tickets.opscode.com/browse/CHEF-4844
    + https://github.com/sethvargo/chefspec/issues/270

## 0.3.1:

* recipes/default    - minor update
* recipes/virtualbox - minor update

## 0.3.0:

* recipes/default    - now checks for section presence in box profile's apps list before proceed
* recipes/virtualbox - now only non-guest users are assigned to vboxusers group

## 0.2.0:

* recipes/virtualbox - refactorized to allow addition of box users to vboxusers group

## 0.1.3:

* recipes/default - dryed removal of unselected applications using uninstall_apps definition
* recipes/virtualbox - dryed installation of __VirtualBox__ application using install_app definition

## 0.1.2:

* recipes/default - dryed purge of unnecessary packages using purge_pkgs definition

## 0.1.1:

* recipes/default - purge of unnecessary suggested packages and autoremove task

## 0.1.0:

* Initial release of vms

