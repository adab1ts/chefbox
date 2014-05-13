# CHANGELOG for office

This file is used to list changes made in each version of office.

## 0.4.1:

* recipes/springseed - fix source issue

## 0.4.0:

* recipes/default     - now includes springseed install management indeed
* recipes/libreoffice - check app availability before installation
* recipes/masterpdf   - check app availability before installation

## 0.3.1:

* attributes/default - ms true type fonts now stored in owncloud server
* recipes/masterpdf  - refactorization due to installation of new relase
* templates/default/masterpdf/uninstall_masterpdf-[ca,es].sh - removed (no longer needed)
* templates/linuxmint-13/masterpdf/masterpdf.desktop         - removed (no longer needed)
* templates/ubuntu-12.04/masterpdf/masterpdf.desktop         - removed (no longer needed)

## 0.3.0:

* README   - update requirements section and new attributes section
* metadata - remove 'core' and 'base' dependencies

* recipes/default

  - do not include recipe[base:default] any more
  - normal attribute 'apps' becomes default attribute
  - use of symbols for attribute keys

* recipes/libreoffice - use of symbols for attribute keys
* recipes/masterpdf   - use of symbols for attribute keys

* recipes/msttfonts

  - use office default attribute to retrieve fonts metadata
  - use of symbols for attribute keys

* attributes/default - metadata moved from 'resources/fonts' data bag item (no longer needed)

## 0.2.1:

* recipes/libreoffice - lo_menubar conflicts with newest version of libreoffice

## 0.2.0:

* recipes/default    - now includes nitro and taskcoach install management
* recipes/nitro      - manages nitro app installation
* recipes/springseed - manages springseed app installation
* recipes/taskcoach  - manages taskcoach app installation

## 0.1.0:

* Initial release of office

