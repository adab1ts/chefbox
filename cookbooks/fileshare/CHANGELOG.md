# CHANGELOG for fileshare

This file is used to list changes made in each version of fileshare.

## 0.5.0:

* recipes/default   - now includes btsync and frostwire install management
* recipes/btsync    - manages btsync app installation
* recipes/frostwire - manages frostwire app installation

## 0.4.0:

* recipes/default - now includes uget install management
* recipes/uget    - manages uget app installation

## 0.3.0:

* README   - update requirements section and copyright note
* metadata - remove 'core' and 'base' dependencies

* recipes/default

  - update copyright note
  - do not include recipe[base:default] any more
  - normal attribute 'apps' becomes default attribute
  - use of symbols for attribute keys

* recipes/jdownloader  - update copyright note
* recipes/transmission - update copyright note

## 0.2.0:

* recipe/default - now checks for section presence in box profile's apps list before proceed

## 0.1.0:

* Initial release of fileshare

