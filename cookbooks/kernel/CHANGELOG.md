# CHANGELOG for kernel

This file is used to list changes made in each version of kernel.

## 0.4.8:

* README.md - update copyright note
* recipes/* - update copyright note

* recipes/default - do not include recipe[kernel::preload] any more
* recipes/preload - removed

## 0.4.7:

* README.md - update copyright note
* recipes/* - update copyright note

* recipes/intel_graphics - intel server certificate no longer needed

## 0.4.6:

* recipes/intel_graphics - fix intel linux server certificate verification issue

## 0.4.5:

* README.md - ubuntu 12.04 no longer supported

## 0.4.4:

* README.md - linuxmint 13 no longer supported

## 0.4.3:

* recipes/intel_graphics - remove intel linux graphics installer execution (defer to post task)

## 0.4.2:

* README.md - include CrunchBang as target platform

## 0.4.1:

* recipes/swappiness - refactor

## 0.4.0:

* recipes/default

  - enable intel_graphics app installation again
  - include swappiness configuration management

* recipes/intel_graphics - check availability before app installation
* recipes/swappiness     - manage swappiness configuration
* recipes/tlp            - check availability before app installation

## 0.3.3:

* recipes/default - disable intel_graphics app installation

## 0.3.2:

* recipes/default - install tlp on demand only

## 0.3.1:

* recipes/default - availability check for intel_graphics is now delegated to 'install_app' definition in 'core' cookbook

## 0.3.0:

* README   - update copyright note
* metadata - remove 'core' and 'base' dependencies

* recipes/default

  - update copyright note
  - do not include recipe[base:default] any more
  - normal attribute 'apps' becomes default attribute
  - use of symbols for attribute keys

* recipes/dkms - update copyright note

* recipes/intel_graphics

  - update copyright note
  - execute intel linux graphics installer immediately

* recipes/preload - update copyright note

* recipes/tlp

  - update copyright note
  - start tlp immediately

## 0.2.1:

* recipes/default - now recipe[kernel::preload] lowers memory requirements to be applied

## 0.2.0:

* recipes/default        - now only recipe[kernel::intel_graphics] applies on ubuntu platform exclusively
* recipes/intel_graphics - includes additional provider key file

## 0.1.1:

* recipes/default - now recipe[kernel::intel_graphics] and recipe[kernel::tlp] apply on ubuntu platform only

## 0.1.0:

* Initial release of kernel
