# Chefbox

Coderebels chef workstation repository.  
Forked from [opscode/chef-repo](https://github.com/opscode/chef-repo)


## Repository Directories

This repository contains several directories, and each directory contains a README file that describes what it is for in greater detail, and how to use it for managing your systems with Chef.

* `.chef-skel/`   - Contains certificates, config and env files to setup new chef server environments.
* `bootstrap/`    - Contains config files and scripts to be delivered to new chefbox nodes before bootstrapping.
* `certificates/` - SSL certificates generated by `rake ssl_cert` live here.
* `config/`       - Contains the Rake configuration file, `rake.rb`.
* `cookbooks/`    - Cookbooks you download or create.
* `data_bags/`    - Store data bags and items in .json in the repository.
* `roles/`        - Store roles in .rb or .json in the repository.
* `tasks/`        - Include rake tasks to ease converging of new chefbox nodes.


## Rake Tasks

The repository contains a `Rakefile` that includes tasks that are installed with the Chef libraries. To view the tasks available with in the repository with a brief description, run `rake -T`.

The default task (`default`) is run when executing `rake` with no arguments. It will call the task `test_cookbooks`.

The following tasks are not directly replaced by knife sub-commands.

* `bundle_cookbook[cookbook]` - Creates cookbook tarballs in the `pkgs/` dir.
* `install`                   - Calls `update`, `roles` and `upload_cookbooks` Rake tasks.
* `ssl_cert`                  - Create self-signed SSL certificates in `certificates/` dir.
* `update`                    - Update the repository from source control server, understands git and svn.

The following tasks duplicate functionality from knife and may be removed in a future version of Chef.

* `metadata`                  - replaced by `knife cookbook metadata -a`.
* `new_cookbook`              - replaced by `knife cookbook create`.
* `role[role_name]`           - replaced by `knife role from file`.
* `roles`                     - iterates over the roles and uploads with `knife role from file`.
* `test_cookbooks`            - replaced by `knife cookbook test -a`.
* `test_cookbook[cookbook]`   - replaced by `knife cookbook test COOKBOOK`.
* `upload_cookbooks`          - replaced by `knife cookbook upload -a`.
* `upload_cookbook[cookbook]` - replaced by `knife cookbook upload COOKBOOK`.

The following tasks ease converging new nodes

* `coderebels:bootstrap[user,nodename,ip,platform,arch]` - Bootstrap a chef client node.
* `coderebels:bundle[user,nodename,mtype]`               - Bundle a bootstrap package for specified box.
* `coderebels:chefbox_updt`                              - Pull chefbox code from Github and upload to chef server.
* `coderebels:converge[user,nodename,ip,platform,arch]`  - Converge a chef client node.
* `coderebels:edb_keygen[keyname]`                       - Generate openssl key for encrypted data bags management.
* `coderebels:help[taskname]`                            - Get help about task usage.
* `coderebels:info[appname]`                             - Get info about specified application.
* `coderebels:make_env[env]`                             - Make environment directory structure.
* `coderebels:create_profile[nodename,roles,recipes]`    - Create a new profile for specified node.
* `coderebels:remindme`                                  - Show how to proceed to converge a new chefbox node.
* `coderebels:remove_env[env]`                           - Remove environment directory structure.
* `coderebels:setup_env[env,email,domain]`               - Setup the target environment.
* `coderebels:ssh[user,nodename,ip,cmd]`                 - Establish a ssh connection with specified box.
* `coderebels:ssh_keygen[user,nodename]`                 - Generate authentication keys to establish a ssh connection with a box.
* `coderebels:switch_env[env,ip]`                        - Switch current environment.
* `coderebels:update_profile[nodename]`                  - Update profile for specified node.
* `coderebels:workspace[env,email,domain]`               - Prepare your chefbox workspace.


## Configuration

The repository uses two configuration files.

* config/rake.rb
* .chef/knife.rb

The first, `config/rake.rb` configures the Rakefile in two sections.

* Constants used in the `ssl_cert` task for creating the certificates.
* Constants that set the directory locations used in various tasks.

If you use the `ssl_cert` task, change the values in the `config/rake.rb` file appropriately. These values were also used in the `new_cookbook` task, but that task is replaced by the `knife cookbook create` command which can be configured below.

The second config file, `.chef/knife.rb` is a repository specific configuration file for knife. If you're using the Opscode Platform, you can download one for your organization from the management console. If you're using the Open Source Chef Server, you can generate a new one with `knife configure`. For more information about configuring Knife, see the [Knife documentation](http://help.opscode.com/faqs/chefbasics/knife).


## Environment

Some rake tasks expect the following ENV variables to be set

* `XEDITOR` - Preferred text editor

Define and export them in the proper config file (ie. $HOME/.bashrc, $HOME/.zshrc, ...)


## Contact

By Email:   carles.ml.dev at gmail dot com  
On Twitter: [@zuzudev](https://twitter.com/zuzudev)  
On Google+: [Carles Muiños](https://plus.google.com/109480759201585988691)


## License

Copyright (c) 2013,2014 Carles Muiños

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

