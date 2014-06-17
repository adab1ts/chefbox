# CHANGELOG for audio

This file is used to list changes made in each version of audio.

## 0.3.1:

* README.md - linuxmint 13 no longer supported

## 0.3.0:

* README   - update requirements section
* metadata - remove 'core' and 'base' dependencies

* recipes/default

  - do not include recipe[base:default] any more
  - normal attribute 'apps' becomes default attribute
  - use of symbols for attribute keys

## 0.2.0:

* recipe/default - now checks for section presence in box profile's apps list before proceed

## 0.1.0:

* Initial release of audio

