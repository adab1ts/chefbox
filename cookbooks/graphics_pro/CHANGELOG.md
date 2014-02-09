# CHANGELOG for graphics_pro

This file is used to list changes made in each version of graphics_pro.

## 0.4.0:

* README   - update requirements section
* metadata - remove 'core' and 'base' dependencies

* recipes/default

  - do not include recipe[base:default] any more
  - normal attribute 'apps' becomes default attribute
  - use of symbols for attribute keys

* recipes/qcad - use of symbols for attribute keys

## 0.3.2:

* recipes/qcad - minor update to QCAD launcher params
* templates/linuxmint-13/qcad/qcad.desktop - minor update to QCAD launcher icon
* templates/ubuntu-12.04/qcad/qcad.desktop - minor update to QCAD launcher icon

## 0.3.1:

* recipes/qcad - now deploys custom uninstaller script for QCAD
* templates/default/qcad/uninstall_qcad-[ca,es].sh - custom uninstaller scripts for QCAD
* templates/ubuntu-12.04/qcad/qcad.desktop - moved from 'templates/default/qcad' folder

## 0.3.0:

* recipes/default     - now includes darktable, draftsight, freecad, librecad, qcad and rawtherapee install management
* recipes/darktable   - installs Darktable virtual lighttable and darkroom for photographers
* recipes/draftsight  - delivers support for DraftSight CAD solution installation
* recipes/freecad     - installs FreeCAD CAx program
* recipes/qcad        - installs QCAD program
* recipes/rawtherapee - installs Rawtherapee RAW file processor
* templates/default/qcad/qcad.desktop      - ubuntu launcher for QCAD
* templates/linuxmint-13/qcad/qcad.desktop - linux mint launcher for QCAD

## 0.2.0:

* recipe/default - now checks for section presence in box profile's apps list before proceed

## 0.1.3:

* recipes/default - dryed removal of unselected applications using uninstall_apps definition
* recipes/*       - dryed installation of selected application using install_app definition

## 0.1.2:

* recipes/default - dryed purge of unnecessary packages using purge_pkgs definition

## 0.1.1:

* recipes/default - purge of unnecessary suggested packages and autoremove task

## 0.1.0:

* Initial release of graphics_pro

