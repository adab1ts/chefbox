# CHANGELOG for cloud

This file is used to list changes made in each version of cloud.

## 0.7.0:

* README.md - update copyright note
* recipes/* - update copyright note

* recipes/default - now includes copy client install management
* recipes/copy    - manage copy client installation
* templates/default/copy/uninstall_copy-[ca,es].sh - custom uninstaller scripts for Copy

## 0.6.0:

* recipes/default  - now includes google drive client install management
* recipes/owncloud - manage google drive client installation

## 0.5.4:

* README.md - ubuntu 12.04 no longer supported

## 0.5.3:

* README.md - linuxmint 13 no longer supported

## 0.5.2:

* README.md       - include CrunchBang as target platform
* recipes/dropbox - extend dropbox client integration to openbox desktop

## 0.5.1:

* recipes/dropbox - extend dropbox client integration to mate and xfce desktops

## 0.5.0:

* recipes/default   - do not install ubuntuone client anymore
* recipes/ubuntuone - removed due to end of Ubuntu One service

## 0.4.0:

* recipes/default  - now includes owncloud client install management
* recipes/owncloud - manage owncloud client installation

## 0.3.0:

* README   - update requirements section
* metadata - remove 'core' and 'base' dependencies

* recipes/default

  - update copyright note
  - do not include recipe[base:default] any more
  - normal attribute 'apps' becomes default attribute
  - use of symbols for attribute keys

* recipes/dropbox   - update copyright note
* recipes/ubuntuone - update copyright note

## 0.2.1:

* recipes/dropbox - fixes regression issue concerning dropbox profile name for linuxmint boxes

## 0.2.0:

* recipes/default - now checks for section presence in box profile's apps list before proceed
* recipes/dropbox - now extends dropbox integration to supported platforms

## 0.1.0:

* Initial release of cloud
