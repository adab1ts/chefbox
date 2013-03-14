# CHANGELOG for core

This file is used to list changes made in each version of core.

## 0.1.0:

* Initial release of core - new core_ppa resource & provider for ppa management

## 0.1.1:

* resources/ppa - added clean_saved attribute to trigger sources backup removal
* providers/ppa - sources backup removal triggered based on clean_saved resource attribute

## 0.2.0:

* definitions/purge_pkgs - new definition wrapping the purge of a package and the suggested ones installed with it

