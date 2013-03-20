# base Cookbook

This cookbook sets up a fresh installation of Ubuntu desktop with a minimum profile.  
The following recipes are applied:

- `base::begin` - manages code and resources to be executed in the first place

- `base::main` - manages the following packages:
  
  `-example-content`            - Ubuntu example content  
  `+dkms`                       - Dynamic Kernel Module Support Framework  
  `+preload`                    - Adaptive readahead daemon (mem > 4 GB only)  
  `+qtnx`                       - NX client for QT  
  `+p7zip-full`                 - 7z and 7za file archivers with high compression ratio  
  `+nautilus-filename-repairer` - Nautilus extension for filename encoding repair  
  `+nautilus-gtkhash`           - Nautilus extension for computing checksums and more using gtkhash  
  `+nautilus-open-terminal`     - Nautilus plugin for opening terminals in arbitrary paths  
  `+lo-menubar`                 - A LibreOffice extension for the global menubar (Ubuntu 12.04 only)  
  `+libreoffice-style-galaxy`   - Office productivity suite -- Galaxy (Default) symbol style  
  `+ubuntu-restricted-extras`   - Commonly used restricted packages for Ubuntu  
  `MS Office True Type Fonts`

- `base::end` - executes first system upgrade and creates a support folder with post-installation instructions


## Requirements

This cookbook only applies to Ubuntu 12.04+ platform.

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

