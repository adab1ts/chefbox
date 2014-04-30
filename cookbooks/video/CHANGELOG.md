# CHANGELOG for video

This file is used to list changes made in each version of video.

## 0.7.0:

* recipes/default - now includes simplescreenrecorder install management
* recipes/ssr     - manages simplescreenrecorder app installation

## 0.6.1:

* recipes/default - mvc installation on x86_64 platforms only

## 0.6.0:

* README   - update requirements section
* metadata - remove 'core' and 'base' dependencies

* recipes/default

  - do not include recipe[base:default] any more
  - normal attribute 'apps' becomes default attribute
  - mmc installation on i686 platforms only (no fix for x86_64 package dependencies)
  - use of symbols for attribute keys

## 0.5.0:

* recipes/default   - now includes recordmydesktop install management
* recipes/recmydesk - manages recordmydesktop app installation

## 0.4.0:

* recipes/default    - now includes bombonodvd, dvdstyler, handbrake, mvc and ogmrip install management
* recipes/bombonodvd - installs Bombono DVD authoring program
* recipes/dvdstyler  - installs DVDStyler DVD Authoring System for Video DVD Production
* recipes/handbrake  - installs HandBrake DVD ripper and video transcoder
* recipes/mvc        - installs Miro Video Converter
* recipes/ogmrip     - installs OGMRip DVD ripper and encoder

## 0.3.0:

* recipes/default - now includes miro and mmc install management
* recipes/miro    - installs Miro media player
* recipes/mmc     - installs Mobile Media Converter

## 0.2.0:

* recipe/default - now checks for section presence in box profile's apps list before proceed

## 0.1.0:

* Initial release of video

