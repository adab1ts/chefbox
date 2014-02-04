# CHANGELOG for security

This file is used to list changes made in each version of security.

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

* recipe/default - now checks for section presence in box profile's apps list before proceed
* recipe/privacy - replaces recipe[nautilus] and extends privacy related packages to supported platforms

## 0.3.0:

* recipe/default  - now includes recipe with nautilus security plugins
* recipe/nautilus - installs security related plugins, ie. hash sums check, secure deletion and encrypt/decrypt of files

## 0.2.0:

* recipe/firewall - delivers first steps documentation concerning firewall solution
* recipe/tracking - delivers first steps documentation concerning tracking solution

## 0.1.0:

* Initial release of security

