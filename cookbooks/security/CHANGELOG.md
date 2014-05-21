# CHANGELOG for security

This file is used to list changes made in each version of security.

## 0.8.0:

* recipes/antivirus - install clamtk file explorer integration on openbox
* recipes/privacy   - include openbox desktop logic and refactor accordingly

## 0.7.0:

* recipes/antivirus - install clamtk file explorer integration
* recipes/privacy   - install secure-delete on xubuntu platform

## 0.6.0:

* recipes/default    - now includes tor browser bundle install management
* recipes/privacy     - privacy tools installation is aware of platform desktop
* recipes/torbrowser - manages tor browser bundle installation

## 0.5.1:

* recipes/firewall - check app availability before installation

* recipes/privacy

  - use linuxmint instead of mint when needed
  - linuxmint encrypting tool install on cinnamon flavour only

* recipes/tracking - check app availability before installation

## 0.5.0:

* README   - update copyright note
* metadata - remove 'core' and 'base' dependencies

* recipes/default

  - update copyright note
  - do not include recipe[base:default] any more
  - normal attribute 'apps' becomes default attribute
  - use of symbols for attribute keys

* recipes/antivirus - update copyright note

* recipes/firewall

  - update copyright note
  - disable ChefSSH profile rules ("backdoor" closed)

* recipes/privacy   - update copyright note
* recipes/tracking  - update copyright note

## 0.4.0:

* recipes/default - now checks for section presence in box profile's apps list before proceed
* recipes/privacy - replaces recipe[nautilus] and extends privacy related packages to supported platforms

## 0.3.0:

* recipes/default  - now includes recipe with nautilus security plugins
* recipes/nautilus - installs security related plugins, ie. hash sums check, secure deletion and encrypt/decrypt of files

## 0.2.0:

* recipes/firewall - delivers first steps documentation concerning firewall solution
* recipes/tracking - delivers first steps documentation concerning tracking solution

## 0.1.0:

* Initial release of security

