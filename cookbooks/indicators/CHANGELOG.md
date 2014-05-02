# CHANGELOG for indicators

This file is used to list changes made in each version of indicators.

## 0.5.2:

* recipes/screensaver - deliver screensaver indicator support to ubuntu platform only
* recipes/weather     - deliver weather indicator support to ubuntu platform only

## 0.5.1:

* recipes/plugandplay - check availability before app installation
* recipes/screensaver - check availability before app installation
* recipes/touchpad    - check availability before app installation
* recipes/weather     - check availability before app installation
* files/default/autostart/caffeine.desktop                       - moved from 'files/ubuntu-12.04/autostart' folder
* files/default/autostart/my-weather-indicator-autostart.desktop - moved from 'files/ubuntu-12.04/autostart' folder
* files/default/autostart/touchpad-indicator-autostart.desktop   - moved from 'files/ubuntu-12.04/autostart' folder
* files/default/autostart/udev-notify.desktop                    - moved from 'files/ubuntu-12.04/autostart' folder

## 0.5.0:

* recipe/default   - do not install ubuntuone indicator anymore
* recipe/ubuntuone - removed due to end of Ubuntu One service

## 0.4.1:

* recipes/screensaver - deliver screensaver indicator support to ubuntu platform only
* recipes/weather     - deliver weather indicator support to ubuntu platform only

## 0.4.0:

* README   - update requirements section
* metadata - remove 'core' and 'base' dependencies

* recipes/default

  - do not include recipe[base:default] any more
  - normal attribute 'apps' becomes default attribute
  - use of symbols for attribute keys

## 0.3.1:

* files/ubuntu-12.04/autostart/caffeine.desktop                       - moved from 'files/default/autostart' folder
* files/ubuntu-12.04/autostart/my-weather-indicator-autostart.desktop - moved from 'files/default/autostart' folder
* files/ubuntu-12.04/autostart/touchpad-indicator-autostart.desktop   - moved from 'files/default/autostart' folder
* files/ubuntu-12.04/autostart/udev-notify.desktop                    - moved from 'files/default/autostart' folder

## 0.3.0:

* recipe/default   - now checks for section presence in box profile's apps list before proceed
* recipe/ubuntuone - now it makes explicit the installation on Ubuntu platform

## 0.2.0:

* recipe/screensaver - delivers first steps documentation concerning screensaver indicator
* recipe/weather - delivers first steps documentation concerning weather indicator

## 0.1.1:

* recipe/plugandplay - dryed plug&play indicator installation using install_app core definition

## 0.1.0:

* Initial release of indicators

