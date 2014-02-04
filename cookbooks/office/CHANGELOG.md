# CHANGELOG for office

This file is used to list changes made in each version of office.

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

