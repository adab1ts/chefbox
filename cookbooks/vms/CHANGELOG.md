# CHANGELOG for vms

This file is used to list changes made in each version of vms.

## 0.3.0:

* recipe/default     - now checks for section presence in box profile's apps list before proceed
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

