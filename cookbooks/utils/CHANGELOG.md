# CHANGELOG for utils

This file is used to list changes made in each version of utils.

## 0.12.0:

* recipes/default - now includes brasero install management
* recipes/brasero - manages brasero app installation

## 0.11.1:

* README.md - linuxmint 13 no longer supported

## 0.11.0:

* recipes/default - now includes discs install management
* recipes/discs   - manages discs app installation

## 0.10.2:

* recipes/backintime - fix bug

## 0.10.1:

* recipes/backintime - purge packages no longer needed

## 0.10.0:

* recipes/default  - now includes gnome-do install management
* recipes/furius   - check availability before app installation
* recipes/gnome-do - manages gnome-do app installation

## 0.9.0:

* recipes/default    - now includes backintime install management
* recipes/backintime - manages backintime app installation

## 0.8.0:

* recipes/default - do not include qle install management anymore
* recipes/qle     - deleted

## 0.7.0:

* README   - update requirements section
* metadata - remove 'core' and 'base' dependencies

* recipes/default

  - do not include recipe[base:default] any more
  - normal attribute 'apps' becomes default attribute
  - use of symbols for attribute keys
  - move y-ppa-manager installation to recipe[sysadmin::yppamgr]
  - now includes fogger and qle install management

* recipes/fogger  - manages fogger app installation
* recipes/furius  - use of symbols for attribute keys
* recipes/qle     - manages qle app installation
* recipes/yppamgr - deleted

## 0.6.0:

* recipes/default   - now includes shutter install management
* recipes/shutter   - manages shutter app installation

## 0.5.0:

* recipes/default - now includes y-ppa-manager install management
* recipes/yppamgr - manages y-ppa-manager app installation

## 0.4.0:

* recipes/default - now checks for section presence in box profile's apps list before proceed

## 0.3.0:

* recipes/furius - delivers first steps documentation concerning furius and ISO images management

## 0.2.0:

* recipes/hardinfo - manages hardinfo app installation
* recipes/p7zip    - manages p7zip-full app installation

## 0.1.0:

* Initial release of utils

