# CHANGELOG for audio_pro

This file is used to list changes made in each version of audio_pro.

## 0.4.3:

* README.md - linuxmint 13 no longer supported

## 0.4.2:

* templates/default/transcribe/transcribe.desktop - fix template name bug

## 0.4.1:

* recipes/default    - airtime installation constrained to platforms with 1GB+ of RAM
* recipes/airtime    - check availability before app installation
* recipes/linuxband  - check availability before app installation
* recipes/transcribe - check availability before app installation
* files/default/linuxband/linuxband.desktop            - single multiplatform desktop file
* files/linuxmint-13/linuxband/linuxband.desktop       - removed
* files/ubuntu-12.04/linuxband/linuxband.desktop       - removed
* templates/default/transcribe/transcribe.desktop      - single multiplatform desktop template
* templates/ubuntu-12.04/transcribe/transcribe.desktop - removed
* templates/linuxmint-13/transcribe/transcribe.desktop - removed

## 0.4.0:

* README   - update requirements section
* metadata - remove 'core' and 'base' dependencies

* recipes/default

  - do not include recipe[base:default] any more
  - normal attribute 'apps' becomes default attribute
  - use of symbols for attribute keys

* recipes/airtime    - use of symbols for attribute keys
* recipes/transcribe - use of symbols for attribute keys

## 0.3.3:

* files/ubuntu-12.04/linuxband/linuxband.desktop - moved from 'files/default/linuxband' folder

## 0.3.2:

* recipes/transcribe - now deploys custom uninstaller script for Transcribe!
* templates/default/transcribe/uninstall_transcribe-[ca,es].sh - custom uninstaller scripts for Transcribe!
* templates/ubuntu-12.04/transcribe/transcribe.desktop - moved from 'templates/default/transcribe' folder

## 0.3.1:

* recipes/linuxband  - deploy a per-user LinuxBand launcher
* recipes/transcribe - minor update to Transcribe! launcher params
* files/default/linuxband/linuxband.desktop            - ubuntu launcher for LinuxBand
* files/linuxmint-13/linuxband/linuxband.desktop       - linuxmint launcher for LinuxBand
* templates/default/transcribe/transcribe.desktop      - minor update to Transcribe! launcher icon
* templates/linuxmint-13/transcribe/transcribe.desktop - minor update to Transcribe! launcher icon

## 0.3.0:

* recipes/default    - now includes idjc, linuxband, transcribe and tuxguitar install management
* recipes/idjc       - installs Internet DJ Console shoutcast/icecast client
* recipes/linuxband  - installs LinuxBand user-interface for MMA (Musical MIDI Accompaniment)
* recipes/transcribe - installs Transcribe! software to work out music from recordings
* recipes/tuxguitar  - installs TuxGuitar multitrack guitar tablature editor and player
* templates/default/transcribe/transcribe.desktop      - ubuntu launcher for Transcribe!
* templates/linuxmint-13/transcribe/transcribe.desktop - linuxmint launcher for Transcribe!

## 0.2.0:

* recipes/default   - now includes guitarix and musescore install management
* recipes/guitarix  - installs Guitarix rock guitar amplifier for Jack
* recipes/musescore - installs Musescore score editor

## 0.1.0:

* Initial release of audio_pro

