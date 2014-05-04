# CHANGELOG for eyecandy

This file is used to list changes made in each version of eyecandy.

## 0.9.0:

* recipes/default     - now includes unity tweak tool install management
* recipes/unity-tweak - manages unity tweak tool installation

## 0.8.1:

* recipes/unsettings - deliver unsettings support to ubuntu platform only again

## 0.8.0:

* recipes/default            - now includes some new icons and gtk themes install management
* recipes/faba-icons         - manages faba icon theme installation
* recipes/faenza-icons       - removed
* recipes/faience-icons      - removed
* recipes/moka-theme         - manages moka gtk theme installation
* recipes/numix-icons        - removed (no longer needed)
* recipes/numix-circle-icons - manages numix circle icon theme installation
* recipes/numix-shine- icons - manages numix shine icon theme installation
* recipes/orchis-theme       - manages orchis gtk theme installation
* recipes/unsettings         - check app availability before installation

## 0.7.2:

* recipes/greeter-background - refactor greeter background download

## 0.7.1:

* recipes/unsettings - deliver unsettings support to ubuntu platform only

## 0.7.0:

* recipes/default            - now includes greeter background image management
* recipes/greeter-background - manages greeter background image configuration
* attributes/default         - new default attribute for background images directory
* files/ubuntu-12.04/gschemas/unity_greeter_background.gschema.override - unity greeter background config file

## 0.6.0:

* recipes/default     - now includes numix icon theme install management
* recipes/numix-icons - manages numix icon theme installation

## 0.5.0:

* README   - update requirements section and copyright note
* metadata - remove 'core' and 'base' dependencies

* recipes/default

  - update copyright note
  - do not include recipe[base:default] any more
  - normal attribute 'apps' becomes default attribute
  - use of symbols for attribute keys

* recipes/faenza-icons  - update copyright note
* recipes/faience-icons - update copyright note
* recipes/moka-icons    - update copyright note
* recipes/nitrux-icons  - update copyright note
* recipes/unsettings    - update copyright note


## 0.4.0:

* recipes/default - now checks for section presence in box profile's apps list before proceed

## 0.3.0:

* recipes/default    - now includes recipe with moka icon theme install management
* recipes/moka-icons - installs moka icon theme 

## 0.2.0:

* recipes/unsettings - delivers first steps documentation concerning unsettings configuration manager

## 0.1.0:

* Initial release of eyecandy

