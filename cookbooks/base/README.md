# base Cookbook

This cookbook sets up a fresh installation of your GNU/Linux desktop with a minimum profile.  
The following recipes are applied:

- `base::begin` - manages code and resources to be executed in the first place

- `base::main` - manages the following packages:
  
  * `Ubuntu`

      `+ia32-libs-multiarch`        - Multi-arch versions of former ia32-libraries (x86_64 only)  
      `+y-ppa-manager`              - PPA Management software  
      `-example-content`            - Ubuntu example content  
      `+nautilus-filename-repairer` - Nautilus extension for filename encoding repair  
      `+nautilus-open-terminal`     - Nautilus plugin for opening terminals in arbitrary paths  
      `+lo-menubar`                 - A LibreOffice extension for the global menubar (Ubuntu 12.04 only)  
      `+libreoffice-style-galaxy`   - Office productivity suite -- Galaxy (Default) symbol style  
      `+ubuntu-restricted-extras`   - Commonly used restricted packages for Ubuntu  

  * `Linux Mint`

      `+ia32-libs-multiarch`        - Multi-arch versions of former ia32-libraries (x86_64 only)  
      `+y-ppa-manager`              - PPA Management software  
      `+libreoffice-style-galaxy`   - Office productivity suite -- Galaxy (Default) symbol style  

  * `All`

      `+gnome-do`                   - Quickly perform actions on your desktop  
      `virtualbox guest packages`   - Support packages for virtual boxes
      `MS Office True Type Fonts`

- `base::end` - executes first system upgrade and creates a support folder with post-installation instructions


## Requirements

This cookbook only applies to the following platforms:  
- `Ubuntu 12.04+`
- `Linux Mint 13+`

#### cookbooks
- `core`
- `sudo`

#### recipes
- `core::default`

#### packages
- `openssl`           - Secure Socket Layer (SSL) binary and related cryptographic tools
- `libshadow-ruby1.8` - Interface of shadow password for Ruby 1.8


## Usage

#### base::default
Just include `base` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[base]"
  ]
}
```


## Contact

By Email:   carles.ml.dev at gmail dot com  
On Twitter: [@zuzudev](https://twitter.com/zuzudev)  
On Google+: [Carles Muiños](https://plus.google.com/109480759201585988691)


## License

Copyright (c) 2013,2014 Carles Muiños

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

