# core Cookbook

This cookbook includes core components to be used as a foundation for other cookbooks.  
The following recipes apply:

- `core::default` - includes helper modules.

It is inspired by [opscode-cookbooks/apt](https://github.com/opscode-cookbooks/apt) cookbook
by  

Joshua Timberman (&lt;joshua at opscode.com&gt;)  
Matt Ray (&lt;matt at opscode.com&gt;)  
Seth Chisamore (&lt;schisamo at opscode.com&gt;)


## Requirements

This cookbook only applies to Ubuntu 12.04+ platform.

#### cookbooks
- `apt`


## Definitions

### Installing applications

`install_app` provides an easy way to manage the installation of an application,
ensuring the correct addition of external sources when nedeed.

#### Examples

    # install gimp application
    graphics = data_bag_item('apps', 'graphics')

    install_app "gimp" do
      profile graphics['profiles']['gimp']
    end

### Uninstalling applications

`uninstall_app` provides an easy way to uninstall an application,
purging all unnecessary packages.

#### Examples

    # uninstall gimp application
    graphics = data_bag_item('apps', 'graphics')

    uninstall_app "gimp" do
      profile graphics['profiles']['gimp']
    end

`uninstall_apps` provides an easy way to uninstall a set of applications,
purging all unnecessary packages.

#### Examples

    # uninstall graphics applications
    box = node[:box]
    graphics = data_bag_item('apps', 'graphics')

    apps = graphics['apps']
    selected = box['apps']['graphics']
    unselected = apps - selected

    uninstall_apps "graphics" do
      apps unselected
      profiles graphics['profiles']
    end

### Autostart of applications

`autostart_app` provides an easy way to tell an application to autostart at login time.

#### Examples

    # autostart caffeine indicator
    indicators = data_bag_item('apps', 'indicators')

    autostart_app "screensaver" do
      profile indicators['profiles']['screensaver']
    end

### Creation of directories

`directory_tree` provides an easy way to create directories in a path recursively, applying same owner, group and mode.

#### Examples

    # dotfiles folder creation
    directory_tree "#{ENV['HOME']}/admin/dotfiles" do
      exclude ENV['HOME']
      owner username
      group groupname
      mode 00755
    end

### Delivery of support material

`support` delivers support material about specified subject.

#### Examples

    # delivery of support material about firewall
    support "firewall" do
      section "security"
    end

### Custom launcher creation

`launcher` provides a custom launcher for specified app.

#### Examples

    # custom launcher for backup-mgr script
    launcher "backup-mgr" do
      template "/jobs/backup/backup-mgr.desktop.erb"
      variables(
        :backup_script => backup_script
      )
    end


## Resources/Providers

### Managing repositories

This LWRP provides an easy way to manage additional PPA repositories.
Adding a new repository will notify running the `execute[synchronize_package_index]`
resource immediately.

#### Actions

- :add: creates a repository file and builds the repository listing
- :remove: removes the repository file

#### Attribute Parameters

- repo_name: the name of the new source file
- uri: the ppa uri to add
- distribution: this is usually your release's codename
- cache_build: triggers package index synchronization (defaults true)
- clean_saved: triggers sources backup removal (defaults true)

#### Examples

    # add the nitrux-umd repo
    core_ppa "kokoto-java-omgubuntu-stuff" do
      uri "ppa:kokoto-java/omgubuntu-stuff"
      distribution "precise"
    end


## Libraries

### module Coderebels::Chefbox::Box

Provides box related functions.

#### Functions

- `memory` - retrieves the total amount of memory of the box.

### module Coderebels::Chefbox::Digest

Provides digest related functions.

#### Functions

- `sha256sum` - prints SHA256 checksum of a given file.
- `md5sum` - prints MD5 checksum of a given file.
- `shadow` - shadows plain text passwords.


## Contact

By Email:   carles.ml.dev at gmail dot com  
On Twitter: [@zuzudev](https://twitter.com/zuzudev)  
On Google+: [Carles Muiños](https://plus.google.com/109480759201585988691)


## License

Copyright (C) 2013 Carles Muiños

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

