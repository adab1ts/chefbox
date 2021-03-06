# CHANGELOG for groupware

This file is used to list changes made in each version of groupware.

## 0.8.1:

* recipes/hangouts - install hangouts plugin from repo and remove original source file

## 0.8.0:

* README.md       - ubuntu 12.04 no longer supported
* recipes/default - xchat install management no longer included
* recipes/xchat   - removed

## 0.7.0:

* recipes/default - now includes hexchat install management
* recipes/gobby   - manages hexchat app installation

## 0.6.3:

* README.md - linuxmint 13 no longer supported

## 0.6.2:

* README.md - include CrunchBang as target platform

## 0.6.1:

* recipes/hangouts - rename hangouts plugin source file

## 0.6.0:

* recipes/default - now includes gobby install management
* recipes/gobby   - manages gobby app installation

## 0.5.1:

* recipes/skype - check availability before app installation

## 0.5.0:

* README   - update requirements section
* metadata - remove 'core' and 'base' dependencies

* recipes/default

  - do not include recipe[base:default] any more
  - normal attribute 'apps' becomes default attribute
  - use of symbols for attribute keys
  - now includes smuxi install management

* recipes/smuxi - manage smuxi app installation

## 0.4.0:

* recipes/default - now includes mumble and xchat install management
* recipes/mumble  - installs Mumble low latency VoIP client
* recipes/xchat   - installs XChat IRC client

## 0.3.0:

* recipes/default  - now checks for section presence in box profile's apps list before proceed
* recipes/hangouts - installs Google Hangouts plugin

## 0.2.0:

* recipes/skype - delivers first steps documentation concerning skype

## 0.1.0:

* Initial release of groupware
