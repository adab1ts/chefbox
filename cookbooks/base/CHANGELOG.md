# CHANGELOG for base

This file is used to list changes made in each version of base.

## 0.5.0:

* recipes/default - now includes only recipe[base::begin], recipe[base::main] and recipe[base::end]
* recipes/begin - includes code and resources to be executed in the first place
* recipes/end - includes code and resources to be executed at the end
* recipes/main - now includes the contents of recipe[base::office] and recipe[base::restricted-extras] as well
* recipes/office - deleted
* recipes/restricted-extras - deleted

## 0.4.0:

* recipes/default - removed inclusion of recipe[base::eyecandy]
* recipes/eyecandy - deleted

## 0.3.0:

* recipes/default - removed inclusion of recipe[base::indicators]
* recipes/indicators - deleted
* files/default/autostart/* - deleted

## 0.2.0:

* recipes/default - removed inclusion of recipe[base::security]
* recipes/security - deleted
* files/default/ufw/chef-openssh-server - deleted

## 0.1.4:

* recipes/* - refactorization of recipes by introducing definitions in 'core' cookbook

## 0.1.3:

* Create Suport folder with post installation instructions in recipe[base::default]

## 0.1.2:

* Remove Faenza icon theme from recipe[base::eyecandy]

## 0.1.1:

* Remove Faience icon theme from recipe[base::eyecandy]

## 0.1.0:

* Initial release of base

