# CHANGELOG for video_pro

This file is used to list changes made in each version of video_pro.

## 0.3.3:

* README.md - ubuntu 12.04 no longer supported

## 0.3.2:

* README.md - linuxmint 13 no longer supported

## 0.3.1:

* recipes/shotcut - fix bug

## 0.3.0:

* recipes/default - now includes shotcut install management indeed
* recipes/shotcut - check availability before app installation
* templates/default/shotcut/shotcut.desktop      - single multiplatform desktop template
* templates/linuxmint-13/shotcut/shotcut.desktop - removed
* templates/ubuntu-12.04/shotcut/shotcut.desktop - removed

## 0.2.0:

* README   - update requirements section
* metadata - remove 'core' and 'base' dependencies

* recipes/default

  - do not include recipe[base:default] any more
  - normal attribute 'apps' becomes default attribute
  - use of symbols for attribute keys

* recipes/shotcut - use of symbols for attribute keys

## 0.1.1:

* recipes/shotcut - now deploys custom uninstaller script for Shotcut
* templates/default/shotcut/uninstall_shotcut-[ca,es].sh - custom uninstaller scripts for Shotcut
* templates/ubuntu-12.04/shotcut/shotcut.desktop         - moved from 'templates/default/shotcut' folder

## 0.1.0:

* Initial release of video_pro

