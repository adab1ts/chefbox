# CHANGELOG for groupware

This file is used to list changes made in each version of groupware.

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

* recipe/default  - now checks for section presence in box profile's apps list before proceed
* recipe/hangouts - installs Google Hangouts plugin

## 0.2.0:

* recipes/skype - delivers first steps documentation concerning skype

## 0.1.0:

* Initial release of groupware

