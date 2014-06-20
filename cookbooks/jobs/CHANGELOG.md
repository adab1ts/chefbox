# CHANGELOG for jobs

This file is used to list changes made in each version of jobs.

## 0.5.3:

* README.md - minor update

## 0.5.2:

* README.md - precise-based platforms no longer supported
* templates/default/jobs/backup/drive/backup-drive - minor update

## 0.5.1:

* templates/linuxmint/jobs/backup/backup-mgr.desktop - moved from 'templates/linuxmint-13/jobs/backup' folder
* templates/ubuntu/jobs/backup/backup-mgr.desktop    - moved from 'templates/ubuntu-12.04/jobs/backup' folder

## 0.5.0:

* README   - update requirements section
* metadata - remove 'core' and 'base' dependencies

* recipes/default

  - do not include recipe[base:default] any more
  - use of symbols for attribute keys

* recipes/backup

  - use of symbols for attribute keys

## 0.4.1:

* templates/ubuntu-12.04/jobs/backup/backup-mgr.desktop - moved from 'templates/default/jobs/backup' folder

## 0.4.0:

* templates/default/jobs/backup/backup-box_name    - force utf-8 encoding
* templates/default/jobs/backup/drive/backup-drive - force utf-8 encoding
* templates/default/jobs/setup                     - force utf-8 encoding
* templates/linuxmint-13/jobs/backup/backup-mgr.desktop - extends launcher to target platform

## 0.3.1:

* recipes/backup - dryed backup-mgr custom launcher creation using launcher core definition

## 0.3.0:

* recipes/backup - delivers first steps documentation concerning backup process

## 0.2.0:

* recipes/default - refactorized to allow deployment of jobs configuration files to selected users
* recipes/backup  - refactorized to allow deployment of backup job files to selected users
* templates/default/logrotate/jobs.erb - refactorized to include log files management of selected users

## 0.1.0:

* Initial release of jobs

