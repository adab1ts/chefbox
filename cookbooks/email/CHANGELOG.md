# CHANGELOG for email

This file is used to list changes made in each version of email.

## 0.4.2:

* README.md - linuxmint 13 no longer supported

## 0.4.1:

* recipes/thunderbird - check app availability before installation

## 0.4.0:

* README   - update requirements section and copyright note
* metadata - remove 'core' and 'base' dependencies

* recipes/default

  - update copyright note
  - do not include recipe[base:default] any more
  - normal attribute 'apps' becomes default attribute
  - use of symbols for attribute keys

* recipes/geary - update copyright note

* recipes/thunderbird

  - update copyright note
  - do not install deprecated thunderbird-globalmenu package any more

## 0.3.1:

* recipes/thunderbird - install thunderbird locale packages

## 0.3.0:

* recipe/default - now checks for section presence in box profile's apps list before proceed

## 0.2.0:

* recipes/thunderbird - delivers first steps documentation concerning thunderbird email client

## 0.1.0:

* Initial release of email

